//
//  YBSinglePictureView.m
//
//  Created by lightman on 16/2/20.
//  Copyright © 2016年 YCTime. All rights reserved.
//

#import "YBSinglePictureView.h"

@implementation YBSinglePictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}



@end
