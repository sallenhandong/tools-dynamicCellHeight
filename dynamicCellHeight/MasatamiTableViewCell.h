//
//  MasatamiTableViewCell.h
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/13.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasatamiFrameViewModel.h"
@interface MasatamiTableViewCell : UITableViewCell

@property (nonatomic,strong) MasatamiFrameViewModel *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
