//
//  UITableView+HeightCache.m
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import "UITableView+HeightCache.h"
#import <objc/runtime.h>

@interface HeightCache ()

@property (nonatomic,strong) NSMutableDictionary<id<NSCopying>,NSNumber*> *mutableCellHeightCaches;

@end

@implementation HeightCache

- (void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _mutableCellHeightCaches = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (BOOL)existsHeightForKey:(id<NSCopying>)key {
    NSNumber *number = self.mutableCellHeightCaches[key];
    return number && ![number isEqualToNumber:@-1];
}

- (void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key {
    self.mutableCellHeightCaches[key] = @(height);
}

- (CGFloat)heightForKey:(id<NSCopying>)key {
#if CGFLOAT_IS_DOUBLE
    return [self.mutableCellHeightCaches[key] doubleValue];
#else
    return [self.mutableCellHeightCaches[key] floatValue];
#endif
}


@end

@implementation UITableView (HeightCache)

//如果缓存存在则返回，不则在则设置缓存
- (HeightCache *)heightCache
{
    HeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [HeightCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}


- (CGFloat)getCellHeightCacheWithCacheKey:(NSString *)cacheKey
{
    if (!cacheKey) {
        return 0;
    }
    
    //如果已经存在cell height 则返回
    if ([self.heightCache existsHeightForKey:cacheKey]) {
        CGFloat cachedHeight = [self.heightCache heightForKey:cacheKey];
        return cachedHeight;
    } else {
        return 0;
    }
}

//缓存cell的高度
- (void)setCellHeightCacheWithCellHeight:(CGFloat)cellHeight
                                cacheKey:(NSString *)cacheKey{

 [self.heightCache cacheHeight:cellHeight byKey:cacheKey];


}





@end
