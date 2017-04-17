//
//  MasatamiDetailTableViewCell.m
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import "MasatamiDetailTableViewCell.h"
#import "YBPictureView.h"
@interface MasatamiDetailTableViewCell ()
@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *contentImage;
@property (nonatomic,strong) UIButton *bottomReply;
@property (nonatomic,strong) UILabel *statusLabel;
@property(nonatomic,strong) YBPictureView *pictureView;
@end

@implementation MasatamiDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(22, 10, 70, 70)];
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = 35;
    self.headImage.image = [UIImage imageNamed:@"dongman.jpg"];
    [self.contentView addSubview:self.headImage];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 20, 100, 30)];
    self.titleLabel.text = @"神雕侠侣";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 30, 80, 30)];
    self.statusLabel.backgroundColor = iCodeNavigationBarColor;
    self.statusLabel.text = @"新增";
    self.statusLabel.textColor = white_color;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.clipsToBounds = YES;
    self.statusLabel.layer.cornerRadius = 5.0;
    self.statusLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.statusLabel];
    
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 40, 150, 30)];
    self.timeLabel.text = @"2017 04-15 12:12";
    self.timeLabel.textColor = gray_color;
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.timeLabel];
    
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.text = @"[环境卫生] 纬二街水管爆裂了";
    self.contentLabel.textColor = black_color;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    
    
    CGSize titleSize = [self.contentLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.contentLabel.frame = CGRectMake(30, 100, SCREEN_WIDTH - 40, titleSize.height);
    
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    
    
    [self.contentView addSubview:self.pictureView];
    
    //    float arrayCount = 9;
    //    int totalColumns = 3;
    //    CGFloat cellW = 100;
    //    CGFloat cellH = 80;
    //    CGFloat margin =(self.contentView.frame.size.width - totalColumns * cellW) / (totalColumns + 1);
    //    for(int index = 0; index < arrayCount; index++) {
    //        UIImageView *contentImage = [[UIImageView alloc]init];
    //        contentImage.image = [UIImage imageNamed:@"yejing.jpg"];
    //        // 计算行号  和   列号
    //        int row = index / totalColumns;
    //        int col = index % totalColumns;
    //        //根据行号和列号来确定 子控件的坐标
    //        CGFloat cellX = margin + col * (cellW + margin);
    //        CGFloat cellY = row * (cellH + margin);
    //        contentImage.frame = CGRectMake(cellX + 30, cellY + self.contentLabel.gt_maxY + 10, cellW, cellH);
    //
    //        // 添加到view 中
    //        [self.contentView addSubview:contentImage];
    //    }
    
    //
    //    CGFloat cellHeight = arrayCount/3;
    //    CGFloat ceilA = ceilf(cellHeight);
    //
    //    //分割线
    //
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ceilA  * cellH + self.contentLabel.bottom + 50, SCREEN_WIDTH, 1)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    //    [self addSubview:view];
    //
    //
    //
    //    //cell高度
    //    CGRect frame = [self frame];
    //    frame.size.height  = view.bottom;
    //    self.frame = frame;
    
    
}

- (void)setCellFrame:(MasatamiFrameViewModel *)cellFrame{
    
    _cellFrame = cellFrame;
    MasatamiModel *model = cellFrame.model;
    
    //头像
    self.headImage.image = [UIImage imageNamed:model.iconName];
    self.headImage.frame = cellFrame.iconViewFrame;
    
    //昵称
    self.titleLabel.text = model.name;
    self.titleLabel.frame = cellFrame.nameBtnFrame;
    
    //时间
    self.timeLabel.text = model.time;
    self.timeLabel.frame = cellFrame.timeLabelFrame;
    
    //正文
    self.contentLabel.text = model.content;
    self.contentLabel.frame = cellFrame.contentLabelFrame;
    
    //相册
    if (model.pictureArray.count) {
        self.pictureView.frame = cellFrame.picViewFrame;
        self.pictureView.pictures = model.pictureArray;
        self.pictureView.hidden = NO;
    } else {
        self.pictureView.hidden = YES;
    }
    
    
    
}
- (YBPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [[YBPictureView alloc] initWithFrame:CGRectZero];
    }
    return _pictureView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierNormal = @"MasatamiDetailTableViewCell";
    MasatamiDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierNormal];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MasatamiDetailTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}@end
