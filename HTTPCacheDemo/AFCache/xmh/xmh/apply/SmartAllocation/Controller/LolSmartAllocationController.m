//
//  LolSmartAllocationController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolSmartAllocationController.h"
#import "JasonSearchView.h"
#import "LSmartDetailController.h"
#import "LSmartCell.h"
#import "LSmartAllocationCell.h"
#import "OneStepView.h"
#import "LSmartSelectResultView.h"
#import "LSmartAllocationSelectCell.h"
#import "ZFRequest.h"
#import "ZFUserListModel.h"
#import "LolUserInfoModel.h"
#import "ShareWorkInstance.h"
#import "MzzHud.h"
#import "XMHBadgeLabel.h"
#import "LSADaiFenPeiModel.h"
#import "LSmartAllocationStandardController.h"
#import "BaseModel.h"
#import "LTempModel.h"
#import "XMHRefreshGifHeader.h"
typedef NS_ENUM (NSInteger, SCType){
    SCTypeAll,
    SCTypeDaiFenPei
};
@interface LolSmartAllocationController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *searchButton;
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation LolSmartAllocationController
{
    JasonSearchView     *_searchView;
    UIButton * _selectBtn;
    UITableView * _tb;
    SCType _type;
    UIView * _containerView;
    OneStepView * _oneView;
    LSmartSelectResultView * _resultView;
    BOOL _isOneStepAllocation;
    ZFUserListModel * _userListModel;
    UISegmentedControl * _sc;
    NSInteger _allPage;
    NSMutableArray * _allArr;
    NSInteger _DaiFenPeiPage;
    NSMutableArray * _DaiFenPeiArr;
    LSADaiFenPeiModel * _daiFenPeiModel;
    NSMutableArray * _selectArr;
    BOOL _noMoreData;
    UIView * _scContainerView;
    
    
    NSInteger  _pageType;
    customNav * _nav;
    BOOL _isSearch;
    XMHBadgeLabel * scTitleOne;
    XMHBadgeLabel * scTitleTwo;
    UIView *redLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _allArr = [[NSMutableArray alloc] init];
    _DaiFenPeiArr = [[NSMutableArray alloc] init];
    _selectArr = [[NSMutableArray alloc] init];
    _allPage = 0;
    _DaiFenPeiPage = 0;
    _noMoreData = NO;
    [self initSubViews];
   
}
//加载待分配数据
- (void)loadDaiFenPeiData{
     WeakSelf
    NSString * fram_id  = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSString * level = [ShareWorkInstance shareInstance].share_join_code.fram_id_level;
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    NSString * type = [NSString stringWithFormat:@"%ld",_selectBtn.tag + 1];
    NSString * page = [NSString stringWithFormat:@"%ld",_DaiFenPeiPage];
    NSString * q = _searchView.searchBar.text?_searchView.searchBar.text:@"";
    [ZFRequest requerstDaiFenPeiFramId:fram_id level:level type:type page:page pageSize:nil joinCode:joinCode q:q resultBlock:^(LSADaiFenPeiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (model.list ==0) {
                [_tb.mj_footer endRefreshingWithNoMoreData];
                _noMoreData = YES;
            }
            _daiFenPeiModel = model;
            [_DaiFenPeiArr addObjectsFromArray:model.list];
            [weakSelf refreshDaiFenPei];
        }else{

        }
    }];
}
// 刷新待分配数据
- (void)refreshDaiFenPei
{
    NSArray * dataArr = [[NSArray alloc] init];
    if (_type == SCTypeDaiFenPei) {
        dataArr = @[[NSString stringWithFormat:@"%ld",(long)_daiFenPeiModel.type1],[NSString stringWithFormat:@"%ld",(long)_daiFenPeiModel.type2],[NSString stringWithFormat:@"%ld",(long)_daiFenPeiModel.type3],[NSString stringWithFormat:@"%ld",(long)_daiFenPeiModel.type4]];
    }
    for (int i = 0; i < _containerView.subviews.count; i++) {
        UIView * view = _containerView.subviews[i];
        if ([view isKindOfClass:[XMHBadgeLabel class]]) {
            XMHBadgeLabel * lb = (XMHBadgeLabel *)view;
            if (dataArr.count > lb.tag) {
                lb.text = dataArr[lb.tag];
                if ([dataArr[lb.tag] isEqualToString:@"0"]) {
                    lb.hidden = YES;
                }else{
                    lb.hidden = NO;
                }
            }
        }
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.selected) {
                btn.layer.borderColor = kBtn_Commen_Color.CGColor;
            }else{
                btn.layer.borderColor = kColorC.CGColor;
            }
        }
    }
    [_tb reloadData];
}
//加载全部数据
- (void)loadData{
    NSString * level = [ShareWorkInstance shareInstance].share_join_code.fram_id_level;
    NSString * fram_id  = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"fram_id"] = fram_id?fram_id:@"";
    params[@"level"] = level?level:@"";
    params[@"type"] = [NSString stringWithFormat:@"%ld",_selectBtn.tag + 1];
    params[@"page"] = [NSString stringWithFormat:@"%ld",_allPage];
    params[@"q"] = _searchView.searchBar.text?_searchView.searchBar.text:@"";
    WeakSelf
    [ZFRequest requestUserListParams:params resultBlock:^(ZFUserListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _userListModel = model;
            if (model.list.count == 0) {
                if (_allPage == 0) {
                    [_tb reloadData];
                    [self endRefreshing];
                }else{
                    [_tb.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                _userListModel = model;
                [_allArr addObjectsFromArray:model.list];
                [weakSelf refreshUI];
                [self endRefreshing];
            }
            [weakSelf refreshUI];
        }
    }];
}
// 刷新UI
- (void)refreshUI{
    scTitleOne.text = [NSString stringWithFormat:@"%ld",(long)_userListModel.quabnbu];
    scTitleTwo.text = [NSString stringWithFormat:@"%ld",(long)_userListModel.daifenpei];
    NSArray * dataArr = [[NSArray alloc] init];
    if (_type == SCTypeAll) {
        dataArr = @[[NSString stringWithFormat:@"%ld",(long)_userListModel.type1],[NSString stringWithFormat:@"%ld",(long)_userListModel.type2],[NSString stringWithFormat:@"%ld",(long)_userListModel.type3]];
    }else{
        
    }
    for (int i = 0; i < _containerView.subviews.count; i++) {
        UIView * view = _containerView.subviews[i];
        if ([view isKindOfClass:[XMHBadgeLabel class]]) {
            XMHBadgeLabel * lb = (XMHBadgeLabel *)view;
            if (dataArr.count > lb.tag) {
                lb.text = dataArr[lb.tag];
                if ([dataArr[lb.tag] isEqualToString:@"0"]) {
                    lb.hidden = YES;
                }else{
                    lb.hidden = NO;
                }
            }
        }
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.selected) {
                btn.layer.borderColor = kBtn_Commen_Color.CGColor;
            }else{
                btn.layer.borderColor = kColorC.CGColor;
            }
        }
    }
    [_tb reloadData];
}
-(UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _searchButton.frame = CGRectMake(SCREEN_WIDTH-65, _searchView.frame.origin.y-10, 50, 53);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
- (void)initSubViews
{
    _type = SCTypeAll;
    _isOneStepAllocation = NO;
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"智能分配" withleftImageStr:@"stgkgl_fanhui" withRightStr:@"指标说明" commenColor:YES];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.lineImageView.hidden = YES;
    [nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nav.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [nav.btnRight addTarget:self action:@selector(oneStep) forControlEvents:UIControlEventTouchUpInside];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    _nav = nav;

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, nav.bottom, SCREEN_WIDTH, 55)];
    view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl * sc = [[UISegmentedControl alloc] initWithItems:@[@"全部顾客",@"待分配"]];
    sc.selectedSegmentIndex = 0;
    _sc = sc;
    [sc addTarget:self action:@selector(choice:) forControlEvents:UIControlEventValueChanged];
    // 去掉颜色,现在整个segment偶看不到,可以相应点击事件
    sc.tintColor = [UIColor clearColor];
    // 正常状态下
    NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName : [UIColor grayColor]};
    [sc setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    // 选中状态下
    NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0f],NSForegroundColorAttributeName : kBtn_Commen_Color};
    [sc setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
    
    sc.frame = CGRectMake(60, 14, SCREEN_WIDTH - 120, 35);
    [view addSubview:sc];
    [self.view addSubview:view];
    scTitleOne = [XMHBadgeLabel defaultBadgeLabel];
    scTitleOne.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    scTitleOne.left = sc.frame.size.width/2-38;
    scTitleOne.bottom = sc.top + sc.height/2 -12;
    scTitleOne.height = 14;
    [sc addSubview:scTitleOne];
    scTitleTwo = [XMHBadgeLabel defaultBadgeLabel];
    scTitleTwo.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    scTitleTwo.left = sc.frame.size.width-45;
    scTitleTwo.bottom = sc.top + sc.height/2 -12;
    scTitleTwo.height = 14;
    [sc addSubview:scTitleTwo];
    UIView *redView = [[UIView alloc]init];
//    redView.frame = CGRectMake(0, sc.bottom, 40, 2);
//    redView.left = scTitleOne.left + 40;
    redView.backgroundColor = kColorTheme;
    [sc addSubview:redView];
    redLine = redView;
    redView.frame = CGRectMake((sc.width / 2.f - 40) / 2.f, sc.height, 40, 2);
    
    UIView *scLineView = [[UIView alloc]initWithFrame:CGRectMake(0, sc.bottom + 2, SCREEN_WIDTH, kSeparatorHeight)];
    scLineView.backgroundColor = kBackgroundColor;
    [view addSubview:scLineView];
    
     [self choice:sc];
    UIView * line1 = [[UIView alloc] init];
    line1.frame = CGRectMake(0, _containerView.bottom , SCREEN_WIDTH, 10);
    line1.backgroundColor = kBackgroundColor;
    [self.view addSubview:line1];
    
    WeakSelf
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0,line1.bottom+12  , SCREEN_WIDTH - 50, 43)withPlaceholder:@"搜索顾客姓名或手机号"];
    _searchView.line1.hidden = YES;
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
        [weakSelf requestNetData];
    };
    UIView *searchLineView = [[UIView alloc]initWithFrame:CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, 1)];
    searchLineView.backgroundColor = kBackgroundColor;
    [self.view addSubview:_searchView];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:searchLineView];
    [self createTableView];
}
//搜索按钮
-(void)searchButtonAction{
    [self requestNetData];
}
//根据内容创建tap
- (void)createTabViewWithArr:(NSArray *)titles
{
    NSInteger count = titles.count;
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, _nav.bottom + 55 + 1, SCREEN_WIDTH, 44)];
    }
    _containerView.backgroundColor = [UIColor redColor];
    [_containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:_containerView];
    CGFloat  x =  (SCREEN_WIDTH - 80 * count)/(count + 1);
    for (int i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(12);
        [btn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
        btn.frame = CGRectMake((i + 1)* x + 80 * i, 10, 80, 25);
        btn.tag = i;
        [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = kSeparatorHeight;
        btn.layer.cornerRadius = btn.height / 2.f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = kColorC.CGColor;
        [_containerView addSubview:btn];
        XMHBadgeLabel * lb = [XMHBadgeLabel defaultBadgeLabel];
        lb.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
        lb.left = btn.right-lb.width;
        lb.bottom = btn.top + btn.height/2;
        lb.height = 14;
        lb.tag = i;
        lb.hidden = YES;

        [_containerView addSubview:lb];
        if(i == 0){
            [self tap:btn];
        }
    }
    _containerView.backgroundColor = [UIColor whiteColor];
}
#pragma mark ------------切换顶部标题事件------------
- (void)choice:(UISegmentedControl *)sc
{
    if (sc.selectedSegmentIndex ==0) {
        _type = SCTypeAll;
//        redLine.left = sc.left + 40;
        redLine.frame = CGRectMake((sc.width / 2.f - 40) / 2.f, sc.height, 40, 2);
    }else{
        _type = SCTypeDaiFenPei;
//        redLine.left = SCREEN_WIDTH/2 + 40;
        redLine.frame = CGRectMake((sc.width / 2.f - 40) / 2.f + (sc.width / 2.f), sc.height, 40, 2);
    }
    _searchView.searchBar.text = @"";
    NSArray * titlesArr = nil;
    if (_type == SCTypeAll) {
        titlesArr = @[@"售前顾客",@"售后顾客",@"冻结顾客"];
        _tb.frame = CGRectMake(0, _searchView.bottom + 2 , SCREEN_WIDTH, SCREEN_HEIGHT - (_searchView.bottom + 2 ));
        _oneView.hidden = YES;
    }else{
        titlesArr = @[@"流转承接",@"优化分配",@"技师调离",@"永久调店"];
        [self createOneSmartAllocation];
    }
    [self createTabViewWithArr:titlesArr];
}
- (void)createOneSmartAllocation
{
    _tb.frame = CGRectMake(0, _searchView.bottom + 0.5 , SCREEN_WIDTH, SCREEN_HEIGHT - (_searchView.bottom + 0.5  + 70 + kSafeAreaBottom));
    if (!_oneView) {
        _oneView = [[[NSBundle mainBundle]loadNibNamed:@"OneStepView" owner:nil options:nil] firstObject];
    }
    _tb.tableFooterView = [[UIView alloc] init];
    [_oneView.btn setTitle:@"一键分配" forState:UIControlStateNormal];
    [_oneView.btn addTarget:self action:@selector(oneSmart) forControlEvents:UIControlEventTouchUpInside];
    _oneView.hidden = NO;
    _oneView.frame = CGRectMake(0, SCREEN_HEIGHT - 70 - kSafeAreaBottom, SCREEN_WIDTH, 70);
    _oneView.btn.layer.cornerRadius = 3;
    _oneView.btn.layer.masksToBounds = YES;
    [self.view addSubview:_oneView];
}
- (void)oneSmart
{
    _oneView.hidden = YES;
    if (!_resultView) {
        _resultView = [[[NSBundle mainBundle]loadNibNamed:@"LSmartSelectResultView" owner:nil options:nil] firstObject];
    }
    _isOneStepAllocation = YES;
    _resultView.hidden = NO;
    _resultView.frame =  CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    _tb.frame = CGRectMake(0, _searchView.bottom + 0.5 , SCREEN_WIDTH, SCREEN_HEIGHT - (_searchView.bottom + 0.5  + 50));
    [_resultView.btn2 addTarget:self action:@selector(smartCommit) forControlEvents:UIControlEventTouchUpInside];
    [_resultView.btn1 addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
    [_tb reloadData];
    [self.view addSubview:_resultView];
}
- (void)selectAll:(UIButton *)btn
{
    [_selectArr removeAllObjects];
    btn.selected = !btn.selected;
    for (LSAUserModel * model in _DaiFenPeiArr) {
        model.isSelect = btn.selected;
    }
    if (btn.selected) {
        [_selectArr addObjectsFromArray:_DaiFenPeiArr];
        
    }else{
        [_selectArr removeAllObjects];
    }
    _resultView.lbNum.text = [NSString stringWithFormat:@"已选择%ld个",_selectArr.count];
    [_tb reloadData];
}
#pragma mark ------------一键分配提交------------
-(void)smartCommit
{
    _oneView.hidden = NO;
    _resultView.hidden = YES;
    _isOneStepAllocation = NO;
    [_tb reloadData];
    //TODO: 提交数据接口
    NSMutableArray *submitArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<_selectArr.count; i++) {
        LSAUserModel * model = _selectArr[i];
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        dict[@"user_id"] = [NSString stringWithFormat:@"%ld",model.user_id];
        dict[@"jis"] = model.jis;
        dict[@"join_code"] = model.join_code;
        [submitArr addObject:dict];
    }
    [ZFRequest requestYiJianFenPeiParams:[@{@"data":submitArr.jsonData}mutableCopy] resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (model.code == 1) {
            [self requestNetData];
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    }];
}
#pragma mark -- Tap 切换
- (void)tap:(UIButton *)btn
{
    _allPage = 0;
    _DaiFenPeiPage = 0;
    [_allArr removeAllObjects];
    [_DaiFenPeiArr removeAllObjects];
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    _searchView.searchBar.text = @"";
    
    if (_type == SCTypeAll) {
        [self loadData];
    }else{
        [self loadDaiFenPeiData];
    }
    [self clearData];
}
- (void)clearData
{
    [_selectArr removeAllObjects];
    _resultView.btn1.selected = NO;
    _resultView.lbNum.text = [NSString stringWithFormat:@"已选择%ld个",_selectArr.count];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark --------进入指标说明-----------
- (void)oneStep
{
    LSmartAllocationStandardController * standard = [[LSmartAllocationStandardController alloc] init];
    [self.navigationController pushViewController:standard animated:NO];
}

- (void)textFieldDidChange:(UITextField *) TextField
{
    //动态搜索
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom + 0.5 , SCREEN_WIDTH, SCREEN_HEIGHT - (_searchView.bottom + 0.5 ) )];
    _tb.dataSource = self;
    _tb.tableFooterView = [[UIView alloc] init];
    _tb.delegate = self;
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;

    WeakSelf;
    _tb.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf requestNetData];
//    }];
    _tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestMoreNetData];
    }];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    _tb.mj_footer.automaticallyHidden = YES;
#pragma clang diagnostic pop
    [self.view addSubview:_tb];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            [self requestNetData];
        }];
    }
    return _gifHeader;
}
#pragma mark ------------加载数据------------
- (void)requestNetData
{
    if (_type ==SCTypeAll) {
        _allPage = 0;
        [_allArr removeAllObjects];
        [self loadData];
    }else{
        [_DaiFenPeiArr removeAllObjects];
        _DaiFenPeiPage = 0;
        if (_resultView.btn1.selected) {
            [self selectAll:_resultView.btn1];
        }
        [self loadDaiFenPeiData];
    }
}
#pragma mark ------------加载更多数据------------
- (void)requestMoreNetData{
    if (_type == SCTypeAll) {
        _allPage++;
        [self loadData];
    }else{
        _DaiFenPeiPage++;
        [self loadDaiFenPeiData];
    }
}
- (void)endRefreshing
{
    [_tb.mj_header endRefreshing];
    [_tb.mj_footer endRefreshing];
}
#pragma mark ------------TableViewDelegate------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == SCTypeAll) {
        return _allArr.count;
    }else{
        return _DaiFenPeiArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    static NSString * cellNameAll = @"LSmartCell";
    static NSString * cellNameDaiFenPei = @"LSmartAllocationCell";
    static NSString * cellNameOneStep = @"LSmartAllocationSelectCell";
    if (_type == SCTypeAll) {
        LSmartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNameAll];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LSmartCell" owner:nil options:nil]lastObject];
        }
        if (_allArr.count > indexPath.row) {
          cell.model =  _allArr[indexPath.row];
        }
        NSString * title = @"";
        switch (_selectBtn.tag) {
            case 0:
                title = @"流转";
                break;
            case 1:
                title = @"回收";
                break;
            case 2:
                title = @"激活";
                break;
            case 3:
                
                break;
                
            default:
                break;
        }
        cell.LSmartCellBlock = ^(ZFUserModel *model) {
            NSString * str = [NSString stringWithFormat:@"亲,你确定要%@%@顾客吗? %@后,该顾客需要重新分配技师哟",title,model.uname,title];
            MzzHud * hub = [[MzzHud alloc] initWithTitle:title message:str leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
                if (index == 1) {
                    NSMutableDictionary * params = [NSMutableDictionary dictionary];
                    params[@"state"] = [NSString stringWithFormat:@"%ld",model.del];
                    params[@"utype"] = [NSString stringWithFormat:@"%ld",model.utype];
                    params[@"user_id"] = [NSString stringWithFormat:@"%ld",model.uid];;
                    NSString * fram_id  = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
                    params[@"fram_id"] = fram_id;
                    params[@"join_code"] = model.join_code;
                    if (model.utype == 3) {
                        params[@"del"] = @"1";
                    }
                    [ZFRequest requestDistriParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                        if (isSuccess) {
                            [weakSelf tap:_selectBtn];
                        }
                    }];
                }
            
            }];
            [hub show];
            
        };
        [cell.btn1 setTitle:title forState:UIControlStateNormal];
        return cell;
    }else{
        if (_isOneStepAllocation) {
            LSmartAllocationSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNameOneStep];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"LSmartAllocationSelectCell" owner:nil options:nil]lastObject];
            }
            if (_DaiFenPeiArr.count > indexPath.row) {
               cell.model = _DaiFenPeiArr[indexPath.row];
            }
            return cell;
        }else{
            LSmartAllocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNameDaiFenPei];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"LSmartAllocationCell" owner:nil options:nil]lastObject];
            }
            cell.btn1.tag = indexPath.row;
            [cell.btn1 addTarget:self action:@selector(smartAllocation:) forControlEvents:UIControlEventTouchUpInside];
            if (_DaiFenPeiArr.count > indexPath.row) {
                cell.model = _DaiFenPeiArr[indexPath.row];
            }
            return cell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == SCTypeAll) {
        return;
    }
    LSAUserModel * model;
    if (_DaiFenPeiArr.count > indexPath.row) {
        model = _DaiFenPeiArr[indexPath.row];
    }
    if (_isOneStepAllocation) {
        if (_DaiFenPeiArr.count < indexPath.row) {
            return;
        }
        if ([_selectArr containsObject:model]) {
            [_selectArr removeObject:model];
        }else{
            [_selectArr addObject:model];
        }
        model.isSelect = !model.isSelect;
        [_tb reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        _resultView.lbNum.text = [NSString stringWithFormat:@"已选择%ld个",_selectArr.count];
        if (_selectArr.count == _DaiFenPeiArr.count) {
            _resultView.btn1.selected = YES;
        }else{
            _resultView.btn1.selected = NO;
        }
    }else{
        LSmartDetailController * detail = [[LSmartDetailController alloc] init];
        NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
        //TODO: 真是数据
        LTempModel * model1 =  [LTempModel tempModelWithUserid:[NSString stringWithFormat:@"%ld",model.user_id] jis:model.jis joincode:joinCode];
        detail.model = model1;
        [self.navigationController pushViewController:detail animated:NO];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == SCTypeAll) {
        return 115;
    }else{
        return 115;
    }
}
#pragma mark ------------点击单个分配------------
- (void)smartAllocation:(UIButton *)btn
{
    LSAUserModel * model = _DaiFenPeiArr[btn.tag];
    MzzHud * hub = [[MzzHud alloc]initWithTitle:@"" message:@"亲,你确定分配吗？" leftButtonTitle:@"取消" rightButtonTitle:@"确认" click:^(NSInteger index) {
       if (index ==1) {
           NSMutableDictionary * params = [NSMutableDictionary dictionary];
           NSMutableDictionary *ujDic = [NSMutableDictionary dictionary];
           ujDic[@"user_id"] = [NSString stringWithFormat:@"%ld",model.user_id];
           ujDic[@"jis"] = model.jis;
           params[@"data"]  = [NSArray arrayWithObjects:ujDic, nil].jsonData;
           [ZFRequest requestYiJianFenPeiParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
               
               if (isSuccess) {
                   [self requestNetData];
               }else{
                   
               }
           }];
       }
    }];
    [hub show];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_type == SCTypeDaiFenPei) {
         [self requestNetData];
    }
}
@end
