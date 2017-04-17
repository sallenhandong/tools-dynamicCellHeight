//
//  MasatamiDetailViewController.m
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/14.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import "MasatamiDetailViewController.h"
#import "MasatamiDetailTableViewCell.h"
@interface MasatamiDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTab;
@property (nonatomic,strong) NSArray *statuses;
@property (nonatomic,strong) NSMutableArray *statusFrames;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,assign) CGFloat topCellheight;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation MasatamiDetailViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildView];
}
-(void)addChildView{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.mainTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT - 74) style:UITableViewStylePlain];
    self.mainTab.delegate = self;
    self.mainTab.dataSource = self;
    self.mainTab.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTab];
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topCellheight, SCREEN_WIDTH, SCREEN_HEIGHT - 74 - self.topCellheight)];
    self.bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.mainTab addSubview:self.bottomView];
    
    
    UIView *bottomWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    bottomWhiteView.backgroundColor = white_color;
    [self.bottomView addSubview:bottomWhiteView];
    
    
    UIButton *replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replyButton.frame = CGRectMake(40, 0, 120, 40);
    [replyButton setTitle:@"官方回复(4)" forState:UIControlStateNormal];
    [replyButton setTitleColor:iCodeNavigationBarColor forState:UIControlStateNormal];
    replyButton.titleLabel.font  = H15;
    [bottomWhiteView addSubview:replyButton];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(40, 40, 120, 2)];
    self.lineView.backgroundColor = iCodeNavigationBarColor;
    [self.bottomView addSubview:self.lineView];
    
    

 
    
}
#pragma mark tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MasatamiFrameViewModel *statusFrame = self.detailFrameModel;
    
    CGFloat cellHeight = [tableView getCellHeightCacheWithCacheKey:statusFrame.identifier];
    NSLog(@"从缓存取出来的-----%f",cellHeight);
    
    if(!cellHeight){
        statusFrame.model = self.detailModel;
        cellHeight = statusFrame.cellHeight;
        [tableView setCellHeightCacheWithCellHeight:cellHeight cacheKey:statusFrame.identifier];
    }
    
    self.topCellheight = cellHeight;
    return cellHeight;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MasatamiDetailTableViewCell *cell = [MasatamiDetailTableViewCell cellWithTableView:tableView];
    
    
    MasatamiFrameViewModel *statusFrame = self.detailFrameModel;
    
    cell.cellFrame = statusFrame;
    return cell;
    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
