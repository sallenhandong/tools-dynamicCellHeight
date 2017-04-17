//
//  YBPictureView.h
//
//  Created by lightman on 16/2/19.
//  Copyright © 2016年 YCTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBPictureView : UIView

@property(nonatomic,strong) NSArray *pictures;

@property(nonatomic,assign,getter=isEnterDetailVC) BOOL enterDetailVC;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
