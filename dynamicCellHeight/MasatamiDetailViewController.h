//
//  MasatamiDetailViewController.h
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasatamiFrameViewModel.h"
#import "MasatamiModel.h"
@interface MasatamiDetailViewController : UIViewController
@property (nonatomic,strong) MasatamiFrameViewModel *detailFrameModel;
@property (nonatomic,strong) MasatamiModel *detailModel;
@end
