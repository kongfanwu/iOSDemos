//
//  LanternHomeVC.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternHomeVC.h"
#import "LanternHomeCell.h"
#import "MineCellModel.h"
#import "LanternRecommendVC.h"
@interface LanternHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSArray * dataSource;
@end

@implementation LanternHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorE;
    _dataSource = @[[MineCellModel createModelWithTitle:@"智能追踪" icon:@"aidengshen_zhinengzhuizong"],[MineCellModel createModelWithTitle:@"智能推荐" icon:@"ai_shendeng_zhinengtuijian"]];
    [self.navView setNavViewTitle:@"AI灯神"];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.tbView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kLanternHomeCell = @"kLanternHomeCell";
    LanternHomeCell * lanternHomeCell = [tableView dequeueReusableCellWithIdentifier:kLanternHomeCell];
    if (!lanternHomeCell) {
        lanternHomeCell = loadNibName(@"LanternHomeCell");
        
    }
    [lanternHomeCell updateLanternHomeCellModel:_dataSource[indexPath.row]];
    return lanternHomeCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 141;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCellModel * model = _dataSource[indexPath.row];
    if ([model.title isEqualToString:@"智能追踪"]) {
        [SVProgressHUD showInfoWithStatus:@"正在开发建设中，敬请期待"];
    }
    if ([model.title isEqualToString:@"智能推荐"]) {
        LanternRecommendVC * lanternRecommendVC = [[LanternRecommendVC alloc] init];
        [self.navigationController pushViewController:lanternRecommendVC animated:NO];
    }
}
@end
