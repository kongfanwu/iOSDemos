//
//  XMHActionCenterCustomerResultVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterCustomerResultVC.h"
#import "JasonSearchView.h"
#import "MsgActivityCenterErrorCell.h"
#import "CommonSubmitView.h"
#import "XMHActionCenterRequest.h"
#import "XMHCouponSendCustomerListModel.h"
@interface XMHActionCenterCustomerResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView * searchView;
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
@property (nonatomic, copy)NSString * search;
@property (nonatomic, strong)NSMutableArray * dataSourceCopy;
@end

@implementation XMHActionCenterCustomerResultVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubViews];
    _dataSourceCopy = [[NSMutableArray alloc] initWithArray:_selectResultArr];
}

- (void)createSubViews
{
    WeakSelf
    [self.navView setNavViewTitle:@"选择顾客" backBtnShow:YES];
    self.navView.NavViewBackBlock = ^{
        if (weakSelf.XMHActionCenterCustomerResultVCBlock) {
            weakSelf.XMHActionCenterCustomerResultVCBlock(weakSelf.dataSourceCopy);
        }
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    self.navView.backgroundColor = kColorTheme;
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.commonSubmitView];
}
- (UIView *)searchView
{
    WeakSelf
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_searchView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"请输入顾客名称或手机号"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_searchView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            weakSelf.search = weakSearchView.searchBar.text;
//            [self requestCustomerData];
            [weakSelf filterDataQ:weakSelf.search];
        };
        //    search.userInteractionEnabled = NO;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _searchView.height);
        btn.userInteractionEnabled = NO;
        [_searchView addSubview:btn];
        _searchView.backgroundColor = [UIColor whiteColor];
    }
    return _searchView;
}
- (void)filterDataQ:(NSString *)q
{
    if (q.length == 0) {
        _selectResultArr = _dataSourceCopy;
    }else{
        NSMutableArray * filterArr = [[NSMutableArray alloc] init];
        for (XMHCouponSendCustomerModel * model in _selectResultArr) {
            if ([model.name containsString:q]||[model.mobile containsString:q]) {
                [filterArr addObject:model];
            }
        }
        _selectResultArr = filterArr;
    }
    [_tbView reloadData];
}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        [_commonSubmitView updateCommonSubmitViewTitle:@"全部删除"];
        _commonSubmitView.CommonSubmitViewBlock = ^{
            [[[MzzHud alloc]initWithTitle:@"" message:@"是否确认全部删除" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
                if (index == 1) {
                    [weakSelf.selectResultArr removeAllObjects];
                    [weakSelf.tbView reloadData];
                    if (weakSelf.XMHActionCenterCustomerResultVCBlock) {
                        weakSelf.XMHActionCenterCustomerResultVCBlock(weakSelf.selectResultArr);
                    }
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } hiddenCancelBtn:YES]show];
        };
    }
   
    return _commonSubmitView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _searchView.bottom - 70) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kMsgActivityCenterErrorCell = @"kMsgActivityCenterErrorCell";
    MsgActivityCenterErrorCell * cell = [tableView dequeueReusableCellWithIdentifier:kMsgActivityCenterErrorCell];
    if (!cell) {
        cell = loadNibName(@"MsgActivityCenterErrorCell");
    }
    cell.MsgActivityCenterErrorCellDelBlock = ^(XMHCouponSendCustomerModel * _Nonnull model) {
        if ([_selectResultArr containsObject:model]) {
            [_selectResultArr removeObject:model];
            [_tbView reloadData];
            [_dataSourceCopy removeObject:model];
        }
    };
    [cell updateCellModel:_selectResultArr[indexPath.row] cellFrom:CellFromResult];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return 10;
    return _selectResultArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
