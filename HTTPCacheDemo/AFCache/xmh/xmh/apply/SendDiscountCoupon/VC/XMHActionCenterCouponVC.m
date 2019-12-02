//
//  XMHActionCenterCouponVC.m
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionCenterCouponVC.h"
#import "JasonSearchView.h"
#import "XMHACSendDiscountCouponCell.h"
#import "CommonSubmitView.h"
#import "XMHActionCenterRequest.h"
#import "XMHCouponListModel.h"
#import "XMHCouponModel.h"
@interface XMHActionCenterCouponVC ()<UITableViewDelegate,UITableViewDataSource>
/** 创建时间按钮 */
@property (nonatomic, strong) UIButton *createTimeBtn;
@property (nonatomic, strong) JasonSearchView *searchView;
/** 投放状态按钮 */
@property (nonatomic, strong) UIButton *statusBtn;
/** 优惠券按钮数组 */
@property (nonatomic, strong) NSMutableArray *couponArr;
/** 下划线 */
@property (nonatomic, strong) UIView *indicatorView;
/** 选中优惠券按钮 */
@property (nonatomic, strong) UIButton *selectBtn;
/** */
@property (nonatomic, strong) UIView *counponBgView;
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic,strong)CommonSubmitView *commonSubmitView;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * search;
/** 现金券数据 */
@property (nonatomic, strong)NSMutableArray *cashArr;
/** 折扣券数据 */
@property (nonatomic, strong)NSMutableArray *discountArr;
/** 礼品券数据 */
@property (nonatomic, strong)NSMutableArray *giftArr;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)NSMutableArray * dataSourceCopy;

@end

@implementation XMHActionCenterCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_selectResultDic) {
        _cashArr = _selectResultDic[kCash];
        _discountArr = _selectResultDic[kDiscount];
        _giftArr = _selectResultDic[kGift];
    }
    [self createSubViews];
    
}

- (void)createSubViews
{
    [self.navView setNavViewTitle:@"优惠券列表" backBtnShow:YES];
    self.navView.backgroundColor = kColorTheme;
    [self createHeaderView];
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.commonSubmitView];

}
- (UIView *)topView
{
    WeakSelf
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0,Heigh_Nav, SCREEN_WIDTH, 63)];
        JasonSearchView * search = [[JasonSearchView alloc] initWithFrame:CGRectMake(15, (_topView.height - 34)/2, SCREEN_WIDTH - 15 - 55, 34) withPlaceholder:@"请输入优惠券名称"];
        search.line1.hidden = YES;
        search.searchBar.frame = search.bounds;
        [_topView addSubview:search];
        search.searchBar.layer.cornerRadius = 3;
        search.searchBar.layer.masksToBounds = YES;
        
        __weak JasonSearchView * weakSearchView = search;
        search.searchBar.btnRightBlock = ^{
            [weakSelf filterDataQ:weakSearchView.searchBar.text];
        };
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(15);
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        btn.frame = CGRectMake(search.right, 0, 55, _topView.height);
        btn.userInteractionEnabled = NO;
        [_topView addSubview:btn];
        _topView.backgroundColor = [UIColor whiteColor];
//        UILabel * line = [[UILabel alloc] init];
//        line.frame = CGRectMake(0, _topView.height - 0.5, SCREEN_WIDTH, 0.5);
//        line.backgroundColor = kColorE5E5E5;
//        _searchView = search;
//        [_topView addSubview:line];
    }
    return _topView;
}
- (void)filterDataQ:(NSString *)q
{
    if (q.length == 0) {
        _dataSource = _dataSourceCopy;
    }else{
        NSMutableArray * filterArr = [[NSMutableArray alloc] init];
        for (XMHCouponModel * model in _dataSourceCopy) {
            if ([model.name containsString:q]) {
                [filterArr addObject:model];
            }
        }
        _dataSource = filterArr;
    }
    [_tbView reloadData];
}
- (void)createHeaderView
{
    [self.view addSubview:self.topView];
    UIView *counponBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom + 0.5, SCREEN_WIDTH, 44)];
    counponBgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:counponBgView];
    
    self.couponArr = [NSMutableArray array];
    CGFloat btnW = SCREEN_WIDTH / 3;
    CGFloat btnH = 41;
    NSArray *titles = @[@"现金券",@"折扣券",@"礼品券"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(counponBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 100;
        [counponBgView addSubview:btn];
        [self.couponArr safeAddObject:btn];
        if (i == 0) {
            [btn setTitleColor:[ColorTools colorWithHexString:@"#EA007A"] forState:UIControlStateNormal];
            [self counponBtnClick:btn];
        }
    }
    
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = [ColorTools colorWithHexString:@"#EA007A"];
    _indicatorView.layer.cornerRadius = 3 * 0.5;
    _indicatorView.bounds = CGRectMake(0, 0, 25 , 3);
    _indicatorView.center = CGPointMake(self.selectBtn.center.x, 43);
    [counponBgView addSubview:_indicatorView];
    self.counponBgView = counponBgView;
}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70);
        [_commonSubmitView updateCommonSubmitViewTitle:@"确定"];
        _commonSubmitView.CommonSubmitViewBlock = ^{
            weakSelf.selectResultDic = [[NSMutableDictionary alloc] init];
            if (weakSelf.cashArr) {
                [weakSelf.selectResultDic setObject:weakSelf.cashArr forKey:kCash];
            }
            if (weakSelf.discountArr) {
                [weakSelf.selectResultDic setObject:weakSelf.discountArr forKey:kDiscount];
            }
            if (weakSelf.giftArr) {
                [weakSelf.selectResultDic setObject:weakSelf.giftArr forKey:kGift];
            }
            if (weakSelf.XMHActionCenterCouponVCBlock) {
                weakSelf.XMHActionCenterCouponVCBlock(weakSelf.selectResultDic);
            }
            [weakSelf.navigationController popViewControllerAnimated:NO];
        };
    }
    return _commonSubmitView;
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _counponBgView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _counponBgView.bottom - 70) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
    }
    return _tbView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kXMHACSendDiscountCouponCell = @"kXMHACSendDiscountCouponCell";
    XMHACSendDiscountCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:kXMHACSendDiscountCouponCell];
    if (!cell) {
        cell = loadNibName(@"XMHACSendDiscountCouponCell");
    }
    [cell updateCellModel:_dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCouponModel * model = _dataSource[indexPath.row];
    model.selected = !model.selected;
    [_tbView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)counponBtnClick:(UIButton *)sender
{
    /** 清楚搜索文字 */
    _searchView.searchBar.text = @"";
    _search = @"";
    for (UIButton *btn in self.couponArr ) {
        if (sender.tag == btn.tag) {
            [btn setTitleColor:[ColorTools colorWithHexString:@"#EA007A"] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:kColor6 forState:UIControlStateNormal];
        }
    }
    self.selectBtn = sender;
    [UIView animateWithDuration:(0.05) animations:^{
        _indicatorView.center = CGPointMake(self.selectBtn.center.x, 43);
    }];

    if (sender.tag == 100) {
        if (_cashArr.count == 0) {
            _type = @"3";
            [self requestListData];
        }else{
          _dataSource = _cashArr;
        }
        
    }else if (sender.tag == 101){
        if (_discountArr.count == 0) {
            _type = @"4";
            [self requestListData];
        }else{
            _dataSource = _discountArr;
        }
        
    }else if (sender.tag == 102){
        if (_giftArr.count == 0) {
            _type = @"5";
            [self requestListData];
        }else{
            _dataSource = _giftArr;
        }
        
    }
     _type = [NSString stringWithFormat:@"%ld",sender.tag - 100 + 3];
    
     [_tbView reloadData];
    
     _dataSourceCopy = [[NSMutableArray alloc] initWithArray:_dataSource];
}
#pragma mark ---网络请求
/** 列表数据 */
- (void)requestListData
{
    NSString * search = _search?_search:@"";
    NSString * type = _type?_type:@"3";
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:search forKey:@"name"];
    [param setValue:type forKey:@"type"];
    [XMHActionCenterRequest requestCommonUrl:kCOUPON_SEND_ADDCOUPONLIST_URL Param:param resultBlock:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            XMHCouponListModel *model = [XMHCouponListModel yy_modelWithDictionary:resultDic];
            _dataSource = [[NSMutableArray alloc] initWithArray:model.list];
            
            if (type.integerValue == 3) {
                _cashArr = [[NSMutableArray alloc] initWithArray:model.list];
                _dataSource = _cashArr;
            }else if (type.integerValue == 4){
                _discountArr = [[NSMutableArray alloc] initWithArray:model.list];
                _dataSource = _discountArr;
            }else if (type.integerValue == 5){
                _giftArr = [[NSMutableArray alloc] initWithArray:model.list];
                _dataSource = _giftArr;
            }else{}
            _dataSourceCopy = [[NSMutableArray alloc] initWithArray:_dataSource];
            [self filterAllCouponData];
            
            [_tbView reloadData];
        }
    }];
    
}
/**  过滤数据 选的优惠券设置为选中 */
- (void)filterAllCouponData
{
    NSMutableArray * cashArr = _selectResultDic[kCash];
    NSMutableArray * discountArr = _selectResultDic[kDiscount];
    NSMutableArray * giftArr = _selectResultDic[kGift];
    if (cashArr.count > 0) {
        [cashArr enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            [_cashArr enumerateObjectsUsingBlock:^(XMHCouponModel * model1, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.selected && [model.uid isEqualToString:model1.uid]) {
                    model1.selected = YES;
                }
            }];
        }];
    }
    if (discountArr.count > 0) {
        [discountArr enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            [_discountArr enumerateObjectsUsingBlock:^(XMHCouponModel * model1, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.selected && [model.uid isEqualToString:model1.uid]) {
                    model1.selected = YES;
                }
            }];
        }];
    }
    if (giftArr.count > 0) {
        [giftArr enumerateObjectsUsingBlock:^(XMHCouponModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
            [_giftArr enumerateObjectsUsingBlock:^(XMHCouponModel * model1, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.selected && [model.uid isEqualToString:model1.uid]) {
                    model1.selected = YES;
                }
            }];
        }];
    }
}
@end
