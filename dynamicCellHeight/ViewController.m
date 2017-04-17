//
//  MasatamiViewController.m
//  safeYuzhong
//
//  Created by jefactoria on 2017/4/11.
//  Copyright © 2017年 sallen. All rights reserved.
//

#import "ViewController.h"
#import "MasatamiTableViewCell.h"
#import "MasatamiModel.h"
#import "MasatamiFrameViewModel.h"
#import "MasatamiDetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTab;
@property(nonatomic,strong) NSArray *statuses;
@property(nonatomic,strong) NSMutableArray *statusFrames;
@end
@implementation ViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (NSArray *)statuses
{
    if (!_statuses) {
        MasatamiModel *status1 = [[MasatamiModel alloc] init];
        status1.name = @"神雕侠侣";
        status1.iconName = @"dongman.jpg";
        status1.content = @"纬二街水管爆裂 没人管吗";
        //        status1.pictureArray = @[@"test_status"];
        status1.time = @"1分钟前";
        
        
        MasatamiModel *status2 = [[MasatamiModel alloc] init];
        status2.name = @"你微笑时很美";
        status2.iconName = @"dongman.jpg";
        status2.content = @"这是测试内容乐视电竞撒第六届萨达是脑出血，承诺项目组，插卡火车卡山东省狂欢节小菜鸟，才能，新农村，你行政村，注册，环信查询差点上的历史记录手机登录见识到了撒娇的拉萨惊呆了撒娇的拉萨惊呆了撒娇的迫切的片尾曲配千万片尾曲；可千万；可千万；得空；打瞌睡；的卡萨；的卡萨；的卡萨；的卡萨；的卡萨；的卡萨；的卡萨；的卡萨；";
        status2.pictureArray = @[@"yejing",@"yejing",@"yejing"];
        status2.time = @"10分钟前";
        
        
        MasatamiModel *status3 = [[MasatamiModel alloc] init];
        status3.name = @"SALLEN";
        status3.iconName = @"dongman.jpg";
        status3.content = @"三个字";
        status3.pictureArray = @[@"yejing",@"yejing",@"yejing",@"yejing"];
        status3.time = @"1个小时前";
        
        MasatamiModel *status4 = [[MasatamiModel alloc] init];
        status4.name = @"爱很简单";
        status4.iconName = @"dongman.jpg";
        status4.content = @"我很帅";
        status4.pictureArray = @[@"yejing",@"yejing",@"yejing",@"yejing",@"yejing"];
        status4.time = @"1分钟前";
        
        
        
        _statuses = @[@[status1],@[status2],@[status3],@[status4]];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFrameModel];
    [self addChildView];
    
}



- (void)setupFrameModel
{
    for (int i = 0; i < self.statuses.count; ++i) {
        MasatamiFrameViewModel *statusFrame = [[MasatamiFrameViewModel alloc] init];
        [self.statusFrames addObject:statusFrame];
        
    }
}

-(void)addChildView{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.mainTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT - 74) style:UITableViewStylePlain];
    self.mainTab.delegate = self;
    self.mainTab.dataSource = self;
    self.mainTab.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTab];
    
    
}
#pragma mark tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = self.statuses[section];
    return array.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.statuses.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MasatamiFrameViewModel *statusFrame = self.statusFrames[indexPath.section];
    NSArray *statusArr = self.statuses[indexPath.section];
    MasatamiModel *status = statusArr.firstObject;
    
    CGFloat cellHeight = [tableView getCellHeightCacheWithCacheKey:statusFrame.identifier];
    NSLog(@"从缓存取出来的-----%f",cellHeight);
    
    if(!cellHeight){
        statusFrame.model = status;
        cellHeight = statusFrame.cellHeight;
        [tableView setCellHeightCacheWithCellHeight:cellHeight cacheKey:statusFrame.identifier];
    }
    
    return cellHeight;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MasatamiTableViewCell *cell = [MasatamiTableViewCell cellWithTableView:tableView];
    
    
    MasatamiFrameViewModel *statusFrame = self.statusFrames[indexPath.section];
    
    cell.cellFrame = statusFrame;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MasatamiDetailViewController *vc = [[MasatamiDetailViewController alloc]init];
    vc.detailFrameModel = self.statusFrames[indexPath.section];
    NSArray *statusArr = self.statuses[indexPath.section];
    MasatamiModel *status = statusArr.firstObject;
    vc.detailModel = status;
    [self presentViewController:vc animated:YES completion:nil];
    
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
