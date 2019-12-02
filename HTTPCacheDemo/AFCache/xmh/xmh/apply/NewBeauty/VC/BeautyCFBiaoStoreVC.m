//
//  BeautyCFBiaoStoreVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoStoreVC.h"
#import "JasonSearchView.h"
#import "BeautyCFBiaoCommonCell.h"
#import "BookRequest.h"
#import "ShareWorkInstance.h"
@interface BeautyCFBiaoStoreVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, copy)NSString *q;
@end

@implementation BeautyCFBiaoStoreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    _dataSource = [[NSMutableArray alloc] init];
    [self initSubViews];
    [self requestCFBiaoTopData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"处方表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tbView];
}
- (UIView *)topView
{
    WeakSelf
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_topView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"搜索店铺"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_topView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.q = weakSearchView.searchBar.text;
            [weakSelf requestCFBiaoTopData];
        };
        //    search.userInteractionEnabled = NO;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _topView.height);
        btn.userInteractionEnabled = NO;
        [_topView addSubview:btn];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.bottom) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorF5F5F5;
    }
    return _tbView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 10;
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kBeautyCFBiaoCommonCell = @"kBeautyCFBiaoCommonCell";
    BeautyCFBiaoCommonCell * cell = [tableView dequeueReusableCellWithIdentifier:kBeautyCFBiaoCommonCell];
    if (!cell) {
        cell = loadNibName(@"BeautyCFBiaoCommonCell");
    }
    [cell updateCellStoreParam:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_BeautyCFBiaoStoreVCBlock) {
        _BeautyCFBiaoStoreVCBlock(_dataSource[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -------网络请求----------
/** 处方表 门店数据 */
- (void)requestCFBiaoTopData
{
    NSString * framID = [NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
//    NSString * framID = @"";
    NSString * q = _q;
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:framID?framID:@"" forKey:@"fram_id"];
    [param setValue:q?q:@"" forKey:@"q"];
    [BookRequest requestCommonUrl:kBEAUTY_CFBIAOSTORET_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource removeAllObjects];
            
            if([[resultDic objectForKey:@"list"] isEqual:[NSNull null]]){
                return ;
            }
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            [_tbView reloadData];
        }else{};
    }];
}
@end
