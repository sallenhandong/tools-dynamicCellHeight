//
//  YBPictureView.m
//
//  Created by lightman on 16/2/19.
//  Copyright © 2016年 YCTime. All rights reserved.
//

#import "YBPictureView.h"
#import "YBSinglePictureView.h"
#import "UIView+Extension.h"

#define kStatusPicturesMaxCols(photosCount) ((photosCount==4)?2:3)
#define kCellWidth [UIScreen mainScreen].bounds.size.width
#define kStatusPictureW ((kCellWidth - 2 * kPictureMargin - 2 * kStatusCellInset) / 3)
#define kStatusPictureH kStatusPictureW

static const int kPictureMaxCount = 9;
static const CGFloat kPictureMargin =  10;
static const CGFloat kStatusCellInset = 20;
static const CGFloat kStatusIconW = 30;
static const CGFloat kStatusNameFont = 15;
static const CGFloat kStatusTimeFont = 12;
static const CGFloat kStatusTextFont = 12;
static const CGFloat kStatusPadding = 10;

@interface YBPictureView ()

@property(nonatomic,assign) CGFloat imageWidth;

@property(nonatomic,assign) CGFloat imageHeight;



@end


@implementation YBPictureView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 预先创建9个图片控件
        for (int i = 0; i < kPictureMaxCount; i++) {
            YBSinglePictureView *photoView = [[YBSinglePictureView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
        }
        
        self.clipsToBounds = YES;
        self.enterDetailVC = NO;
        
    }
    return self;
}


- (void)setPictures:(NSArray *)pictures
{
    _pictures = pictures;
    
    for (int i = 0; i < kPictureMaxCount; i++) {
        YBSinglePictureView *picView = self.subviews[i];
        
        CGFloat pictureFixedWidth = kCellWidth - 40;
        CGFloat pictureFixedHeight = pictureFixedWidth * 0.5;
        
        if (self.enterDetailVC) {
            if (i < pictures.count) { // 显示图片
                
                NSString *imageName = pictures[i];
                UIImage *image = [UIImage imageNamed:imageName];
                

                
                if (pictures.count == 1) {
                    CGSize imageSize = image.size;
                    float scale = imageSize.width / imageSize.height;
                    self.imageWidth = pictureFixedWidth;
                    self.imageHeight = self.imageWidth / scale;
                    [self setNeedsLayout];
                    
                    UIImage *scaleImage = [self scale:image toSize:CGSizeMake(self.imageWidth, self.imageHeight)];
                    picView.image = scaleImage;
                    
                }else {
                    picView.image = image;
                    
                }
                picView.hidden = NO;
                
            } else { // 隐藏
                picView.hidden = YES;
            }
            
        } else {
            if (i < pictures.count) { // 显示图片
                
                NSString *imageName = pictures[i];
                UIImage *image = [UIImage imageNamed:imageName];
                
                if (pictures.count == 1) {
                    CGSize imageSize = image.size;
                    float scale = imageSize.width / imageSize.height;
                    
                    
                    if (scale >= 1.0) {
                        self.imageWidth = pictureFixedWidth;
                        self.imageHeight = self.imageWidth / scale;
                    } else {
                        self.imageHeight = pictureFixedHeight;
                        self.imageWidth = self.imageHeight * scale;
                    }
                    [self setNeedsLayout];
                    
                    UIImage *scaleImage = [self scale:image toSize:CGSizeMake(self.imageWidth, self.imageHeight)];
                    picView.image = scaleImage;
                    
                } else {
                    picView.image = image;
                    
                }
                picView.hidden = NO;
                
            } else { // 隐藏
                picView.hidden = YES;
            }
            
        }
        
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSUInteger count = self.pictures.count;
    
    if (self.enterDetailVC) {
        if (count == 1) {
            
            YBSinglePictureView *picView = self.subviews.firstObject;
            picView.width = self.imageWidth ;
            picView.height = self.imageHeight;
            
            picView.x = 0;
            picView.y = 0;
        } else if (count == 4){
            int maxCols = kStatusPicturesMaxCols(count);
            for (int i = 0; i<count; i++) {
                YBSinglePictureView *picView = self.subviews[i];
                CGFloat picViewW = ((kCellWidth -  kPictureMargin - 2 * kStatusCellInset) / maxCols);
                picView.width = picViewW;
                picView.height = picViewW;
                picView.x = (i % maxCols) * (picViewW + kPictureMargin);
                picView.y = (i / maxCols) * (picViewW + kPictureMargin);
            }
        }else {
            int maxCols = kStatusPicturesMaxCols(count);
            for (int i = 0; i<count; i++) {
                YBSinglePictureView *picView = self.subviews[i];
                picView.width = kStatusPictureW;
                picView.height = kStatusPictureW;
                picView.x = (i % maxCols) * (kStatusPictureW + kPictureMargin);
                picView.y = (i / maxCols) * (kStatusPictureW + kPictureMargin);
            }
            
        }
    } else {
        
        if (count == 1) {
            
            YBSinglePictureView *picView = self.subviews.firstObject;
            picView.width = self.imageWidth ;
            picView.height = self.imageHeight;
            
            picView.x = 0;
            picView.y = 0;
        } else {
            int maxCols = kStatusPicturesMaxCols(count);
            for (int i = 0; i<count; i++) {
                YBSinglePictureView *picView = self.subviews[i];
                picView.width = kStatusPictureW;
                picView.height = kStatusPictureH;
                picView.x = (i % maxCols) * (kStatusPictureW + kPictureMargin);
                picView.y = (i / maxCols) * (kStatusPictureH + kPictureMargin);
            }
            
        }
    }
    
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    
    int maxCols = kStatusPicturesMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * kStatusPictureW + (totalCols - 1) * kPictureMargin;
    CGFloat photosH = totalRows * kStatusPictureH + (totalRows - 1) * kPictureMargin;
    
    return CGSizeMake(photosW, photosH);
}

//伸缩图片的方法
-(UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size,YES,[[UIScreen mainScreen] scale]);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


@end
