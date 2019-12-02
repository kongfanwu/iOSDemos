//
//  BeautyCFBiaoCustomerVC.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoCustomerVC.h"
#import "BeautyCFBiaoSelectView.h"
#import "JasonSearchView.h"
#import "BeautyCFBiaoTotalView.h"
#import "BeautyCFBiaoCommonCell.h"
#import "BookRequest.h"
#import "ActionSheetStringPicker.h"
#import "QFDatePickerView.h"
@interface BeautyCFBiaoCustomerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)BeautyCFBiaoSelectView * topSelectView;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)BeautyCFBiaoTotalView * totalView;
/** 弹窗 技师 名字数据源 */
@property (nonatomic, strong)NSMutableArray * jisNameArr;
/** 选择的技师 */
@property (nonatomic, strong)NSMutableDictionary * selectJisParam;
/** 检索条件 */
@property (nonatomic, copy)NSString * q;
@end

@implementation BeautyCFBiaoCustomerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorF5F5F5;
    _dataSource = [[NSMutableArray alloc] init];
    _jisNameArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _jisDataSoucre.count; i++) {
        NSMutableDictionary * dic = _jisDataSoucre[i];
        [_jisNameArr addObject:dic[@"jis_name"]];
    }
    [self initSubViews];
    [self requestCFBiaoCustomerData];
    
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:@"处方表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.topSelectView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.totalView];
    [self.view addSubview:self.tbView];
}
- (BeautyCFBiaoSelectView *)topSelectView
{
    WeakSelf
    if (!_topSelectView) {
        _topSelectView = loadNibName(@"BeautyCFBiaoSelectView");
        _topSelectView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44);
        [_topSelectView updateBeautyCFBiaoSelectViewLeftTitle:_param[@"jis_name"]];
        [_topSelectView updateBeautyCFBiaoSelectViewDate:_selectDate];
        _topSelectView.BeautyCFBiaoSelectViewStoreBlock = ^{
             [ActionSheetStringPicker showPickerWithTitle:nil rows:weakSelf.jisNameArr initialSelection:0 target:weakSelf successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:weakSelf.topSelectView];
        };
        _topSelectView.BeautyCFBiaoSelectViewDateBlock = ^{
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString * date) {
                weakSelf.selectDate = date;
                [weakSelf.topSelectView updateBeautyCFBiaoSelectViewDate:date];
                [weakSelf requestCFBiaoCustomerData];
            }];
            [datePickerView show];
        };
       
    }
    return _topSelectView;
}
- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element
{
    _selectJisParam = _jisDataSoucre[selectedIndex.integerValue];
    [_topSelectView updateBeautyCFBiaoSelectViewLeftTitle:_selectJisParam[@"jis_name"]];
    [self requestCFBiaoCustomerData];
}
- (void)actionPickerCancelled:(id)sender
{
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}
- (UIView *)topView
{
    WeakSelf
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, _topSelectView.bottom + 10, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_topView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"搜索顾客"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_topView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.q = weakSearchView.searchBar.text;
            [weakSelf requestCFBiaoCustomerData];
            //            weakSelf.q = weakSearchView.searchBar.text;
            //            [weakSelf refreshTbData];
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
- (BeautyCFBiaoTotalView *)totalView
{
    if (!_totalView) {
        _totalView = loadNibName(@"BeautyCFBiaoTotalView");
        _totalView.frame = CGRectMake(0, _topView.bottom, SCREEN_WIDTH, 120);
    }
    return _totalView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, _totalView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _totalView.bottom) style:UITableViewStylePlain];
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
    [cell updateCellCustomerParam:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------网络请求----------
/** 处方表 顾客数据 */
- (void)requestCFBiaoCustomerData
{
//    NSString * account = @"18600005555";//_param[@"account"];
//    NSString * q = @"";
//    NSString * date = @"2019-2";
    NSString * account = @"";
    if (_selectJisParam) {
        account = _selectJisParam[@"account"];
    }else{
        account = _param[@"account"];
    }
    //_selectJisParam[@"account"];//_param[@"account"];
    NSString * q = _q;
    NSString * date = _selectDate;
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:account?account:@"" forKey:@"account"];
    [param setValue:q?q:@"" forKey:@"q"];
    [param setValue:date?date:@"" forKey:@"date"];
    [BookRequest requestCommonUrl:kBEAUTY_CFBIAOCustomer_URL Param:param resultBlock:^(NSDictionary *resultDic, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:resultDic[@"list"]];
            [_tbView reloadData];
            [_totalView updateViewParam:[[NSMutableDictionary alloc]initWithDictionary:resultDic]];
        }else{};
    }];
}
@end
