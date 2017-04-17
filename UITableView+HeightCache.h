//
//  UITableView+HeightCache.h
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeightCache : NSObject

@property (nonatomic,assign) CGFloat cellHeight;

- (BOOL)existsHeightForKey:(id<NSCopying>)key;
- (void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key;
- (CGFloat)heightForKey:(id<NSCopying>)key;
@end
@interface UITableView (HeightCache)

@property (nonatomic,strong,readonly) HeightCache *heightCache;

- (CGFloat)getCellHeightCacheWithCacheKey:(NSString *)cacheKey;

- (void)setCellHeightCacheWithCellHeight:(CGFloat)cellHeight
                                cacheKey:(NSString *)cacheKey;


@end
