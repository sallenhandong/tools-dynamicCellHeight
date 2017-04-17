//
//  MasatamiFrameViewModel.m
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import "MasatamiFrameViewModel.h"
#import "YBPictureView.h"
@implementation MasatamiFrameViewModel

- (instancetype)init{

    self = [super init];
    if (self) {
        
        _identifier = [self setIdentifier];
    }

    return self;
}

- (NSString *)setIdentifier{
    static NSInteger count = 0;
    return [NSString stringWithFormat:@"cellHeight_id_%@",@(count++)];

}

- (void)setModel:(MasatamiModel *)model{

    _model = model;
    
    //头像
    CGFloat iconX = 22;
    CGFloat iconY = 10;
    CGFloat iconW = 70;
    CGFloat iconH = 70;
    self.iconViewFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame) + 20;
    NSString *name = model.name;
    CGSize nameSize = [name sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
    CGFloat nameY = iconY + iconH * 0.5 - nameSize.height * 0.5 - 10;
    self.nameBtnFrame = (CGRect){{nameX,nameY}, nameSize};
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    //时间
    CGFloat timeX = nameX;
    CGSize timeSize = [model.time sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] ];
    CGFloat timeY = iconY + iconH * 0.5 - timeSize.height * 0.5 + 20;
    self.timeLabelFrame = (CGRect){{timeX,timeY}, timeSize};
    
    //正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconViewFrame) + 10;
    CGFloat maxW = cellWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor colorWithWhite:0.263 alpha:1.000]};
    CGSize textSize = [model.content boundingRectWithSize:maxSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributes
                                                   context:nil].size;
    CGSize richTextSize = CGSizeMake(textSize.width, textSize.height + 2);
    self.contentLabelFrame = (CGRect){{textX,textY}, richTextSize};
    
    //配图
     self.cellHeight = 0;
    if (model.pictureArray.count == 1) {
        CGFloat picturesX = iconX;
        CGFloat picturesY = CGRectGetMaxY(self.contentLabelFrame) + 10;
        
        NSString *picName = _model.pictureArray.firstObject;
        UIImage *image = [UIImage imageNamed:picName];
        float scale = image.size.width/image.size.height;
        
        CGFloat picViewW;
        CGFloat picViewH;
        
        CGFloat pictureFixedWidth = cellWidth - 2 * 40;
        CGFloat pictureFixedHeight = pictureFixedWidth * 0.5;
        
        if (scale >= 1.0) {
            picViewW = pictureFixedWidth;
            picViewH = picViewW / scale;
        } else {
            picViewH = pictureFixedHeight;
            picViewW = picViewH / scale;
        }
        
        CGSize pictureSize = CGSizeMake(picViewW, picViewH);
        
        self.picViewFrame = (CGRect){{picturesX,picturesY}, pictureSize};
        
        self.cellHeight  = CGRectGetMaxY(self.picViewFrame);
        
    } else if(model.pictureArray.count > 1){
        CGFloat picturesX = textX;
        CGFloat picturesY = CGRectGetMaxY(self.contentLabelFrame) + 10;
        CGSize picturesSize = [YBPictureView sizeWithPhotosCount:(int)model.pictureArray.count];
        self.picViewFrame = (CGRect){{picturesX,picturesY}, picturesSize};
        
        self.cellHeight  = CGRectGetMaxY(self.picViewFrame);
    } else {
        self.cellHeight  = CGRectGetMaxY(self.contentLabelFrame);
    }
    

    //cell的高度
    self.cellHeight = self.cellHeight + 10;
    NSLog(@"####计算的--------%f",self.picViewFrame.size.height);
    
    //cell的frame
    self.frame = CGRectMake(0, 0, cellWidth, self.cellHeight);
    
    

}

@end
