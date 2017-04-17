//
//  MasatamiFrameViewModel.h
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasatamiModel.h"
@interface MasatamiFrameViewModel : NSObject
@property(nonatomic,assign) CGRect iconViewFrame;

@property(nonatomic,assign) CGRect nameBtnFrame;

@property(nonatomic,assign) CGRect timeLabelFrame;

@property(nonatomic,assign) CGRect contentLabelFrame;

@property(nonatomic,assign) CGRect picViewFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat allCellheight;

@property (nonatomic,strong) MasatamiModel *model;

@property(nonatomic,assign) CGRect frame;

//id
@property(nonatomic,copy,readonly) NSString *identifier;
@end
