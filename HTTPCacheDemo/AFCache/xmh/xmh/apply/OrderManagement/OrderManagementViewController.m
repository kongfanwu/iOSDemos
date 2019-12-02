//
//  OrderManagementViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#import "OrderManagementViewController.h"
#import "DateHeaderView.h"
#import "DatePickerView.h"
#import "organizationalStructureView.h"
#import "JobSelector.h"
#import "OrderManagementCell.h"
#import <WebKit/WebKit.h>
#import "OrderSellAndServerView.h"
#import "OrderSaleViewController.h"
#import "OrderChoiseView.h"
#import "JasonSearchView.h"
#import "SLRequest.h"
#import "OrderServiceCell.h"
#import "tempModel.h"
#import "SaleListRequest.h"
#import "SalePerformanceViewController.h"
#import "RefundAmountViewController.h"
#import "CooperateCardViewController.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "SATongJiModel.h"
#import "SLGetListModel.h"
#import "LDatePickView.h"
#import "MzzCustomerRequest.h"
#import "MzzLevelModel.h"
#import "SLGetListModel.h"
#import "MzzJiSuanViewController.h"
#import "MzzCustomerDetailsController.h"
#import "SANewDingDanListModel.h"
#import "MzzSaleOrderChoiseView.h"
#import "COrganizeModel.h"
#import "MzzOrderSaleCell.h"
#import "ApproveDetailController.h"
#import "ApproveNativeViewController.h"
#import "baseTableViewCell.h"
#import "ZhuzhiModel.h"
#import "RolesTools.h"
#import "HomePageHeadModel.h"
#import "DateSubViewModel.h"
#import "OrderTopHeardView.h"
#import "CommonHeaderView.h"
#import "GuideView.h"
#import "FWDRecordController.h"
#import "GKGLCustomerDetailVC.h"
#import "GKGLHomeCustomerListModel.h"
//#import "GKGLHomeCustomerModel.h"

#define kOrderManagementViewControllerMargin 40
//用户权限
typedef NS_ENUM(NSUInteger){
    UserManagerType,
    UserSingleYuangongType,
    UserQuanbugekeType,
    UserSaleManagerType,
    UserSaleQuanbugekeType,
}OrderUserType;

@interface OrderManagementViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>{
    DatePickerView * _dp;
//    OrderTopHeardView * createTbHeaderView;
    WKWebView *_webView;
    UITableView *_tbView;
    UIView  *_totalHeaderView;//总头部
    //参数
//    NSString *cjoin_code;
    //    Fram_List *fram_list1;
//    NSString *coneClick;
//    NSString *ctwoClick;
//    NSString *ctwoListId;
//    NSString *cinId;
    NSString *cstartTime;
    NSString *cendTime;
    NSString *cuserID;
    List*clistInfo;
    organizationalStructureView *_organizationHeader;
    
    JobSelector *_jobSelector;
    NSString *_choiseTitle;
    
    BOOL    _isCustomer;
    JasonSearchView    *_searchView;
    OrderChoiseView *_orderMiddleChoiceView;
    MzzSaleOrderChoiseView *_saleOrderChoiceView;
    
    SLGetListModel * _getListModel;
    SANewDingDanListModel * _saleListModel;
    NSString * _zt;
    NSString * _orderType;
    NSInteger clevel;
    
    NSString *_cinIdstr;
    
    UIView *_blankView;
    UIImageView *_blankImageView;
    Join_Code *_sharejoin_code;
    BOOL    _first;
    //观看目标类型
    // 8个显示的 model
    HomePageHeadModel * _headModel;
    NSDictionary * _modelDict;
    OrderSellAndServerView *downView;
    
    NSMutableArray * _dataSource;
}
/** <##> */
@property (nonatomic, strong) OrderTopHeardView * createTbHeaderView;
/** <##> */
@property (nonatomic, copy) NSString *cjoin_code;
/** <##> */
@property (nonatomic, copy) NSString *ctwoClick;
@property (nonatomic, copy) NSString *coneClick;
/** <##> */
@property (nonatomic, copy) NSString *ctwoListId;
/** <##> */
@property (nonatomic, copy) NSString *cinId;
@property (nonatomic ,assign)OrderUserType orderUserType;
@property (nonatomic ,assign)BOOL isSale;
@property (nonatomic ,assign)BOOL isfirst;
@property (nonatomic ,copy)NSString *saleStr;
@property (nonatomic ,copy)NSString *servStr;
@property (nonatomic ,assign)int page;
@property (nonatomic ,assign)BOOL haveOrgnazationData;
@property (nonatomic ,assign)NSInteger framework_function_main_role;
@property (nonatomic ,strong)UIButton *searchButton;
@property (nonatomic ,strong)LDatePickView * dateHeaderView;
@end

@implementation OrderManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _isSale = YES;
    _isfirst = YES;
    _first = YES;
    _page = 1;
    _orderType = @"0";
    
    LolUserInfoModel *usermodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _framework_function_main_role = usermodel.data.join_code[0].framework_function_main_role;
    
    _sharejoin_code = [ShareWorkInstance shareInstance].share_join_code;
//    _cinIdstr = usermodel.data.account;
    
    
    [self.navView setNavViewTitle:@"订单管理" backBtnShow:YES];
    
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    
    //(组织架构 + 时间选择器 + 层级组合)View
    CommonHeaderView * commonView = [[CommonHeaderView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100) module:@"DDGL"];
    __weak typeof(self) _self = self;
    commonView.CommonHeaderViewBlock = ^(COrganizeModel *organizeModel,BOOL isShow) {
        __strong typeof(_self) self = _self;
        if (!isShow) {
            _tbView.frame = CGRectMake(0, 60 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 60 - downView.frame.size.height);
        }else{
            _tbView.frame =CGRectMake(0, 100 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 100 - downView.frame.size.height);
        }
        self.cjoin_code = organizeModel.joinCode;
        self.coneClick = organizeModel.oneClick;
        self.ctwoClick = organizeModel.twoClick;
        self.ctwoListId = organizeModel.twoListId;
        self.cinId = organizeModel.inId;
        clevel = organizeModel.level;
        cuserID = organizeModel.listInfo.ID;
        cstartTime = organizeModel.start;
        cendTime = organizeModel.end;
        clistInfo = organizeModel.listInfo;
        _cinIdstr = self.cinId;
//        cuserID = nil;
        [weakSelf confirmOrg];
        _haveOrgnazationData = true;
    };
    [self.view addSubview:commonView];
    [self initSubviews];
    
    GuideView * guide = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [guide showGuideViewModule:@"DDGL"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ( _haveOrgnazationData) {
        [self requestData];
        [self requestTableViewData];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _haveOrgnazationData = YES;
}
- (void)rightTempEvent{
    ApproveNativeViewController *vc = [[ApproveNativeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark----列表数据请求
- (void)requestTableViewData
{
    __block UITableView *tmptbView = _tbView;
    _page = 1;
    if (_orderUserType == UserManagerType || _orderUserType == UserQuanbugekeType) {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"join_code"] = self.cjoin_code?self.cjoin_code:@"";
        params[@"oneClick"] = self.coneClick?self.coneClick:@"";
        params[@"twoClick"] = self.ctwoClick?self.ctwoClick:@"";
        params[@"twoListId"] = self.ctwoListId?self.ctwoListId:@"";
        params[@"startTime"] = cstartTime?cstartTime:@"";
        params[@"endTime"] = cendTime?cendTime:@"";
        params[@"inId"] = self.cinId?self.cinId:@"";
        params[@"zt"] = _zt?_zt:@"0";
        params[@"q"] = _servStr?_servStr:@"";
        params[@"page"] = [NSString stringWithFormat:@"%d",_page];
        [SLRequest requestGetListParams:params resultBlock:^(SLGetListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [tmptbView.mj_footer endRefreshing];
            if (isSuccess) {
                _getListModel = model;
                [tmptbView reloadData];
            }
        }];
    }else if (_orderUserType == UserSaleQuanbugekeType) {
        
        [SaleListRequest requestNewDingDanListPage:[NSString stringWithFormat:@"%d",_page] orderType:_orderType oneClick: self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId joinCode:self.cjoin_code startTime:cstartTime endTime:cendTime userId:cuserID q:_saleStr inId: _cinIdstr resultBlock:^(SANewDingDanListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                [tmptbView.mj_footer endRefreshing];
                _saleListModel = model;
                [tmptbView reloadData];
            }
        }];
    }else{
        _getListModel = nil;
        _saleListModel = nil;
        [tmptbView reloadData];
    }
}

- (void)appendTableViewData{
    __block UITableView *tmptbView = _tbView;
    _page ++;
    if (_orderUserType == UserManagerType || _orderUserType == UserQuanbugekeType) {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"join_code"] = self.cjoin_code?self.cjoin_code:@"";
        params[@"oneClick"] = self.coneClick?self.coneClick:@"";
        params[@"twoClick"] = self.ctwoClick?self.ctwoClick:@"";
        params[@"twoListId"] = self.ctwoListId?self.ctwoListId:@"";
        params[@"startTime"] = cstartTime?cstartTime:@"";
        params[@"endTime"] = cendTime?cendTime:@"";
        params[@"inId"] = self.cinId?self.cinId:@"";
        params[@"zt"] = _zt?_zt:@"0";
        params[@"q"] = _servStr?_servStr:@"";
        params[@"page"] = [NSString stringWithFormat:@"%d",_page];
        [SLRequest requestGetListParams:params resultBlock:^(SLGetListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [tmptbView.mj_header endRefreshing];
            [tmptbView.mj_footer endRefreshing];
            if (isSuccess) {
                if (_getListModel) {
                    if (model.dList.count >0) {
                        [_getListModel.dList addObjectsFromArray:model.dList];
                        [tmptbView reloadData];
                    }else{
                        [tmptbView.mj_footer endRefreshingWithNoMoreData];
                    }
                }else{
                    _getListModel = model;
                }
            }
        }];
    }else if (_orderUserType == UserSaleQuanbugekeType) {
        
        [SaleListRequest requestNewDingDanListPage:[NSString stringWithFormat:@"%d",_page] orderType:_orderType oneClick: self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId joinCode:self.cjoin_code startTime:cstartTime endTime:cendTime userId:nil q:_saleStr inId: _cinIdstr resultBlock:^(SANewDingDanListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [tmptbView.mj_header endRefreshing];
            [tmptbView.mj_footer endRefreshing];
            if (isSuccess) {
                if (_saleListModel) {
                    if (model.list.count > 0) {
                        [_saleListModel.list addObjectsFromArray:model.list];
                        [tmptbView reloadData];
                    }else{
                        [tmptbView.mj_footer endRefreshingWithNoMoreData];
                    }
                }else{
                    _saleListModel = model;
                }
            }
        }];
    }else{
        _getListModel = nil;
        _saleListModel = nil;
        [tmptbView reloadData];
    }
}

- (void)requestData{
    
    NSString *framid =[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    if (_isfirst) {
        _isfirst = NO;
        
        [SaleListRequest requestFuWuandXiaoShouFuWuJoinCode:self.cjoin_code oneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId startTime:cstartTime endTime:cendTime inId:self.cinId framId:framid resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                downView.frame = CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70);
//                if ([self.ifHiden isEqualToString:@"yes"]) {
//                    _tbView.frame =CGRectMake(0, 100 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 100 - downView.frame.size.height);
//                }else{
//                    _tbView.frame =CGRectMake(0, 60 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 60 - downView.frame.size.height);
//                }
                NSMutableArray *secondArr = [NSMutableArray array];
                [secondArr addObject:[NSString stringWithFormat:@"%.2f",[[model.data objectForKey:@"fuwuyeji"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwudanshu"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwuxiangmushu"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwurenshu"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"xiaoshoudanshu"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"xiaoshoujine"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwuxiangmucishu"] floatValue]]];
                [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"peihe"] floatValue]]];
                
                __weak typeof(self) _self = self;
                [SaleListRequest requestDingDanTongJiOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId joinCode:self.cjoin_code startTime:cstartTime endTime:cendTime userId:cuserID inId:_cinIdstr resultBlock:^(SATongJiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                    if (isSuccess) {
                        NSMutableArray *firstArr = [NSMutableArray array];
                        [firstArr addObject:model.count_a];
                        [firstArr addObject:model.count_d];
                        [firstArr addObject:model.count_pro];
                        [firstArr addObject:model.count_r];
                        [firstArr addObject:model.count_h];
                        [firstArr addObject:model.count_w];
                        [firstArr addObject:model.count_t];
                        [firstArr addObject:model.count_ph];
                        
                        self.createTbHeaderView.touchClick = ^(NSUInteger index, NSUInteger clickNum) {
                            __strong typeof(_self) self = _self;
                            switch (index) {
                                case 0:
                                {
                                    if (clickNum ==0) {
                                        //销售业绩
                                        SalePerformanceViewController *VC = [[SalePerformanceViewController alloc]init];
                                        VC.model = [COrganizeModel createModelWithOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId inId:self.cinId thirdClick:@"" forthClick:@"" joinCode:self.cjoin_code level:1 mainrole:0];
                                        VC.fromStr = @"销售";
                                        [self.navigationController pushViewController:VC animated:NO];
                                    }
                                    if (clickNum ==5) {
                                        //回款业绩
                                        SalePerformanceViewController *VC = [[SalePerformanceViewController alloc]init];
                                        VC.model = [COrganizeModel createModelWithOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId inId:self.cinId thirdClick:@"" forthClick:@"" joinCode:self.cjoin_code level:1 mainrole:0];
                                        VC.fromStr = @"回款";
                                        [self.navigationController pushViewController:VC animated:NO];
                                    }
                                    if (clickNum ==6) {
                                        //退款金额
                                        RefundAmountViewController *vc = [[RefundAmountViewController alloc]init];
                                        vc.model = [COrganizeModel createModelWithOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId inId:self.cinId thirdClick:@"" forthClick:@"" joinCode:self.cjoin_code level:1 mainrole:0];
                                        [self.navigationController pushViewController:vc animated:NO];
                                    }
                                    if (clickNum == 7) {
                                        //配合消费
                                        
                                        if (_framework_function_main_role == 4 ||_framework_function_main_role == 5 ||_framework_function_main_role == 6 ||_framework_function_main_role == 8 ||_framework_function_main_role == 9 ||_framework_function_main_role == 10 ) {
                                            CooperateCardViewController *vc = [[CooperateCardViewController alloc]init];
                                            vc.model = [COrganizeModel createModelWithOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId inId:self.cinId thirdClick:@"" forthClick:@"" joinCode:self.cjoin_code level:1 mainrole:0];
                                            vc.isSale = YES;
                                            [self.navigationController pushViewController:vc animated:NO];
                                        }else{
                                            [MzzHud toastWithTitle:@"提示" message:@"您没有权限操作，若有疑问请联系管理员"];
                                        }
                                    }
                                }
                                    break;
                                case 1:
                                {
                                    if (clickNum ==7) {
                                        //配合耗卡
                                        if (_framework_function_main_role == 4 ||_framework_function_main_role == 5 ||_framework_function_main_role == 6 ||_framework_function_main_role == 8 ||_framework_function_main_role == 9 ||_framework_function_main_role == 10 ) {
                                            CooperateCardViewController *vc = [[CooperateCardViewController alloc]init];
                                            vc.model = [COrganizeModel createModelWithOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId inId:self.cinId thirdClick:@"" forthClick:@"" joinCode:self.cjoin_code level:1 mainrole:0];
                                            vc.isSale = NO;
                                            [self.navigationController pushViewController:vc animated:NO];
                                        }else{
                                            [MzzHud toastWithTitle:@"提示" message:@"您没有权限操作，若有疑问请联系管理员"];
                                        }
                                    }
                                }
                                    break;
                            }
                        };
                        [self.createTbHeaderView setupWithFirstName:@"销售凭证" andFirstTitles:@[@"销售业绩",@"销售单数",@"销售项目数",@"销售人数",@"分期回款单数",@"未还清金额",@"退款金额",@"配合消费"] andFirstDetails:firstArr andSecondName:@"服务凭证" andSecondTitles:@[@"服务业绩",@"服务单数",@"服务项目数",@"服务人数",@"销售服务单数",@"销售服务金额",@"服务项目次数",@"配合耗卡"] andSectondDetails:secondArr ];
                    }
                }];
            }
        }];
    }else{
        if (_isSale) {
            [SaleListRequest requestDingDanTongJiOneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId joinCode:self.cjoin_code startTime:cstartTime endTime:cendTime userId:cuserID inId:_cinIdstr resultBlock:^(SATongJiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    NSMutableArray *firstArr = [NSMutableArray array];
                    [firstArr addObject:model.count_a];
                    [firstArr addObject:model.count_d];
                    [firstArr addObject:model.count_pro];
                    [firstArr addObject:model.count_r];
                    [firstArr addObject:model.count_h];
                    [firstArr addObject:model.count_w];
                    [firstArr addObject:model.count_t];
                    [firstArr addObject:model.count_ph];
                    [self.createTbHeaderView setupWithFirstName:@"销售凭证" andFirstTitles:@[@"销售业绩",@"销售单数",@"销售项目数",@"销售人数",@"回款单数",@"未还清金额",@"退款金额",@"配合消费"] andFirstDetails:firstArr];
                    
                }
            }];
        }
        if (!_isSale) {
            [SaleListRequest requestFuWuandXiaoShouFuWuJoinCode:self.cjoin_code oneClick:self.coneClick twoClick:self.ctwoClick twoListId:self.ctwoListId startTime:cstartTime endTime:cendTime inId:self.cinId framId:framid resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    NSMutableArray *secondArr = [NSMutableArray array];
                    [secondArr addObject:[NSString stringWithFormat:@"%.2f",[[model.data objectForKey:@"fuwuyeji"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwudanshu"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwuxiangmushu"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwurenshu"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"xiaoshoudanshu"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"xiaoshoujine"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"fuwuxiangmucishu"] floatValue]]];
                    [secondArr addObject:[NSString stringWithFormat:@"%.0f",[[model.data objectForKey:@"peihe"] floatValue]]];
                    [self.createTbHeaderView setupWithSecondName:@"服务凭证" andSecondTitles:@[@"服务业绩",@"服务单数",@"服务项目数",@"服务人数",@"销售服务单数",@"销售服务金额",@"服务项目次数",@"配合耗卡"] andSectondDetails:secondArr];
                }
            }];
        }
    }
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
//搜索按钮
-(void)searchButtonAction{
    if (_isSale) {
        _saleStr = _searchView.searchBar.text;
    }else{
        _servStr = _searchView.searchBar.text;
    }
    [self requestTableViewData];
}
-(LDatePickView *)dateHeaderView
{
    WeakSelf;
    if (!_dateHeaderView) {
        _dateHeaderView= [[LDatePickView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, (SCREEN_WIDTH - kOrderManagementViewControllerMargin-15)*3/7, 34)dateBlock:^(NSString *start, NSString *end) {
            cstartTime = start;
            cendTime = end;
            if (_haveOrgnazationData) {
                [weakSelf confirmOrg];
            }
        }];
        _dateHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _dateHeaderView;
}

- (void)initSubviews{
    WeakSelf;
    
    _totalHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _totalHeaderView.backgroundColor = [UIColor whiteColor] ;
    
    self.createTbHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"OrderTopHeardView" owner:nil options:nil] firstObject];
    self.createTbHeaderView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 200);
    //切换销售凭证和服务凭证
    [self.createTbHeaderView setFirstJobOnClick:^{
        _isSale = YES;
        [weakSelf confirmOrg];
    }];
    [self.createTbHeaderView setSecondJobOnClick:^{
        _isSale = NO;
        [weakSelf confirmOrg];
    }];
    //点击更多按钮
    __weak typeof(self) _self = self;
    self.createTbHeaderView.moreJobOnClick = ^(BOOL select) {
        __strong typeof(_self) self = _self;
        if (select) {
            self.createTbHeaderView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 300);
        }else{
            self.createTbHeaderView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 200);
        }
        [self updateHeardView];
    };
    
    [_totalHeaderView addSubview:self.createTbHeaderView];
    downView = [[[NSBundle mainBundle] loadNibNamed:@"OrderSellAndServerView" owner:nil options:nil] firstObject];
    downView.frame = CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70);
    [self.view addSubview:downView];
    [downView.btn1 addTarget:self action:@selector(downViewBtn1Event) forControlEvents:UIControlEventTouchUpInside];
    [downView.btn2 addTarget:self action:@selector(downViewBtn2Event) forControlEvents:UIControlEventTouchUpInside];
    

    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 60 - downView.frame.size.height) style:UITableViewStylePlain];
    _tbView.separatorColor = [UIColor clearColor];
    _tbView.backgroundColor = kBackgroundColor;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    _tbView.tableHeaderView = _totalHeaderView;
    
//    MJRefreshAutoNormalFooter *footer = _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf appendTableViewData];
//    }];
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf appendTableViewData];
    }];
}
//刷新头部视图
-(void)updateHeardView
{
    switch (_orderUserType) {
        case UserManagerType:
        case UserSingleYuangongType:
        case UserSaleManagerType:
        {

            _totalHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _webView.bottom);

        }
            break;
        case UserQuanbugekeType:
        case UserSaleQuanbugekeType:
        {
            _totalHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.createTbHeaderView.bottom + 65 +40);

        }
            break;
    }
    _webView.frame = CGRectMake(0, self.createTbHeaderView.bottom, SCREEN_WIDTH,580);
    _searchView.frame = CGRectMake(0, self.createTbHeaderView.bottom+12, SCREEN_WIDTH-50, 53);
    _searchButton.frame = CGRectMake(SCREEN_WIDTH-65, _searchView.frame.origin.y-10, 50, 53);
    _orderMiddleChoiceView.frame = CGRectMake(0, self.createTbHeaderView.bottom + 65, SCREEN_WIDTH, 40);
    _saleOrderChoiceView.frame = CGRectMake(0, self.createTbHeaderView.bottom + 65, SCREEN_WIDTH, 40);
    _tbView.tableHeaderView = _totalHeaderView;
}
- (void)initWebView{
    if (_orderMiddleChoiceView) {
        [_orderMiddleChoiceView removeFromSuperview];
        _orderMiddleChoiceView = nil;
    }
    if (_saleOrderChoiceView) {
        [_saleOrderChoiceView removeFromSuperview];
        _saleOrderChoiceView = nil;
    }
    if (_searchView) {
        [_searchView removeFromSuperview];
        [_searchButton removeFromSuperview];
        _searchButton = nil;
        _searchView=nil;
    }
    [_webView reload];
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.createTbHeaderView.bottom, SCREEN_WIDTH,580)];
        [_totalHeaderView addSubview:_webView];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _totalHeaderView.frame = CGRectMake(0,0, SCREEN_WIDTH, _webView.bottom);
        _tbView.tableHeaderView = _totalHeaderView;
    }
    if (_isSale) {
        NSString *url = [NSString stringWithFormat:@"%@sales/chart.html",SERVER_H5];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@serv/chart.html",SERVER_H5];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}
- (void)initOrderMiddleView{
    WeakSelf
    if (_webView) {
        [_webView removeFromSuperview];
        _webView = nil;
    }
    if (_saleOrderChoiceView) {
        [_saleOrderChoiceView removeFromSuperview];
        _saleOrderChoiceView = nil;
    }
    if (!_searchView) {
        
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, self.createTbHeaderView.bottom+12, SCREEN_WIDTH-50, 53)withPlaceholder:@"姓名/手机号"];
        _searchView.line1.hidden = YES;
        [_totalHeaderView addSubview:_searchView];
    }
    [_totalHeaderView addSubview: self.searchButton];
    _searchView.searchBar.btnRightBlock = ^{
        if (weakSelf.isSale) {
            _saleStr = _searchView.searchBar.text;
        }else{
            _servStr = _searchView.searchBar.text;
        }
        [weakSelf requestTableViewData];
    };
    
    _searchView.searchBar.btnleftBlock = ^{
    };
    
    if (!_orderMiddleChoiceView) {
        _orderMiddleChoiceView = [[[NSBundle mainBundle] loadNibNamed:@"OrderChoiseView" owner:nil options:nil] firstObject];
        _orderMiddleChoiceView.OrderChoiseViewBlock = ^(NSInteger index) {
            _zt = [NSString stringWithFormat:@"%ld",index];
            [weakSelf requestTableViewData];
        };
        _orderMiddleChoiceView.frame = CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, 40);
        [_totalHeaderView addSubview:_orderMiddleChoiceView];
    }
    _totalHeaderView.frame = CGRectMake(0,0, SCREEN_WIDTH, _orderMiddleChoiceView.bottom);
    _tbView.tableHeaderView = _totalHeaderView;
}

- (void)initSaleOrderMiddleView{
    WeakSelf
    if (_webView) {
        [_webView removeFromSuperview];
        _webView = nil;
    }
    if (_orderMiddleChoiceView) {
        [_orderMiddleChoiceView removeFromSuperview];
        _orderMiddleChoiceView = nil;
    }
    if (!_searchView) {
        _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, self.createTbHeaderView.bottom+12, SCREEN_WIDTH-50, 53)withPlaceholder:@"姓名/手机号"];
        _searchView.line1.hidden = YES;
        [_totalHeaderView addSubview:_searchView];
    }
    [_totalHeaderView addSubview: self.searchButton];
    
    _searchView.searchBar.btnRightBlock = ^{
        
        if (weakSelf.isSale) {
            _saleStr = _searchView.searchBar.text;
        }else{
            _servStr = _searchView.searchBar.text;
        }
        [weakSelf requestTableViewData];
    };
    
    _searchView.searchBar.btnleftBlock = ^{
        
    };
    
    if (!_saleOrderChoiceView) {
        _saleOrderChoiceView = [[[NSBundle mainBundle] loadNibNamed:@"OrderChoiseView" owner:nil options:nil] lastObject];
//        if ([self.from isEqualToString:@"快速开单"]) {
//            _orderType = [NSString stringWithFormat:@"%@",@"10"];
//            [weakSelf requestTableViewData];
//        }
        _saleOrderChoiceView.OrderChoiseViewBlock = ^(NSInteger index) {
            _orderType = [NSString stringWithFormat:@"%ld",index];
            [weakSelf requestTableViewData];
        };
        _saleOrderChoiceView.frame = CGRectMake(0, _searchView.bottom, SCREEN_WIDTH, 40);
        [_totalHeaderView addSubview:_saleOrderChoiceView];
    }
    _totalHeaderView.frame = CGRectMake(0,0, SCREEN_WIDTH, _saleOrderChoiceView.bottom);
    _tbView.tableHeaderView = _totalHeaderView;
}

- (void)confirmOrg{
    
    _servStr = nil;
    _saleStr = nil;
    _page = 1;
    
    if (_isSale) {
        if ((self.ctwoListId.intValue == -1 && [self.ctwoClick isEqualToString:@"all"]) ) {
            //全部顾客
            _orderUserType = UserSaleQuanbugekeType;
            [self  requestOriginData];
            return;
        }
        if ((self.ctwoListId.intValue == -1 && ![self.ctwoClick isEqualToString:@"all"]) ) {
            //单个顾客
            _orderUserType = UserSaleQuanbugekeType;
            cuserID = clistInfo.ID;
            [self  requestOriginData];
            return;
        }
        _orderUserType = UserSaleManagerType;
        [self  requestOriginData];
    }else{
        if (self.ctwoListId.intValue == -1 && ![self.ctwoClick isEqualToString:@"all"]) {
            //单个顾客
            _orderUserType = UserQuanbugekeType;
            [self  requestOriginData];
            return;
        }
        
        if ((self.ctwoListId.intValue == -1 && [self.ctwoClick isEqualToString:@"all"]) ) {
            //全部顾客
            _orderUserType = UserQuanbugekeType;
            [self  requestOriginData];
            return;
        }
        
        if ( self.cinId && ![self.cinId isEqualToString:@""] &&( ![self.ctwoClick isEqualToString:@"all"]) ) {
            //单个员工
            _orderUserType = UserSingleYuangongType;
            [self  requestOriginData];
            return;
        }
        _orderUserType = UserManagerType;
        [self  requestOriginData];
    }
}

-(void)requestOriginData{
    switch (_orderUserType) {
        case UserManagerType:
        {
            [self initWebView];
        }
            break;
        case UserSingleYuangongType:
        {
            [self initWebView];
        }
            break;
        case UserQuanbugekeType:
        {
            [self initOrderMiddleView];
        }
            break;
        case UserSaleManagerType:
        {
            [self initWebView];
        }
            break;
        case UserSaleQuanbugekeType:
        {
            [self initSaleOrderMiddleView];
        }
            break;
    }
    [self requestData];
    [self requestTableViewData];
}
- (void)downViewBtn1Event{
    if (_framework_function_main_role == 7 || _framework_function_main_role ==4 || _framework_function_main_role ==5 || _framework_function_main_role ==6 || _framework_function_main_role == 8 || _framework_function_main_role ==9 || _framework_function_main_role == 10) {
   
        OrderSaleViewController *vc = [[OrderSaleViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        [MzzHud toastWithTitle:@"提示" message:@"您没有制单权限，请进行其他操作"];
    }
}
- (void)downViewBtn2Event{
    if (_framework_function_main_role == 7 || _framework_function_main_role ==4 || _framework_function_main_role ==5 || _framework_function_main_role ==6 || _framework_function_main_role == 8 || _framework_function_main_role ==9 || _framework_function_main_role == 10) {
        OrderSaleViewController *vc = [[OrderSaleViewController alloc]init];
        vc.isService = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        [MzzHud toastWithTitle:@"提示" message:@"您没有制单权限，请进行其他操作"];
    }
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString *token = model.data.token;
    NSString *framid =[NSString stringWithFormat:@"%ld",(long)[ShareWorkInstance shareInstance].share_join_code.fram_id];
    if (_isSale) {
        NSString *js = [NSString stringWithFormat:@"xiaoshouhomeCallJs('%@','%@','%@','%@','%@','%@','%@','%@','%@')",token,[NSString stringWithFormat:@"%d",_page],self.coneClick,self.ctwoClick,self.ctwoListId,self.cjoin_code,cstartTime,cendTime,self.cinId];
        [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
    }else{
        NSString *js = [NSString stringWithFormat:@"fuwuxiaoshouhomeCallJs('%@','%@','%@','%@','%@','%@','%@','%@','%@')",token,self.coneClick,self.ctwoClick,self.ctwoListId,cstartTime,cendTime,self.cjoin_code,self.cinId,framid];
        [XMHWebSignTools loadWebViewJs:webView];
        [_webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableViewCellindentifier = @"TableViewCellindentifier";
    baseTableViewCell *basecell;
    if (!basecell)
    {
        [tableView registerClass:[baseTableViewCell class] forCellReuseIdentifier:TableViewCellindentifier];
        basecell = [[[NSBundle mainBundle] loadNibNamed:@"baseTableViewCell" owner:nil options:nil] firstObject];
    }else{
        basecell  = [tableView dequeueReusableCellWithIdentifier:TableViewCellindentifier];
    }
    WeakSelf;
    switch (_orderUserType) {
        case UserQuanbugekeType:
        {
            static NSString *OrderServiceCellindentifier = @"OrderServiceCellindentifier";
            OrderServiceCell *cell;
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderServiceCell" owner:nil options:nil] firstObject];
            }else{
                cell  = [tableView dequeueReusableCellWithIdentifier:OrderServiceCellindentifier];
            }
            cell.btn4.tag = indexPath.row;
            [cell.btn4 addTarget:self action:@selector(cellBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            [cell setFramework_function_main_role:_framework_function_main_role];
            if (_getListModel.dList.count) {
                cell.listModel = _getListModel.dList[indexPath.row];
                
                [cell setBtn1Click:^(SLDlistModel *dlistModel, NSString *H5str) {
                    [weakSelf jumpToH5WithString:H5str andServeModel:_getListModel.dList[indexPath.row]];
                }];
                [cell setBtn2Click:^(SLDlistModel *dlistModel, NSString *H5str) {
                    [weakSelf jumpToH5WithString:H5str andServeModel:_getListModel.dList[indexPath.row]];
                }];
                [cell setBtn3Click:^(SLDlistModel *dlistModel, NSString *H5str) {
//                    MzzCustomerDetailsController *detailVc = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
//                    [detailVc setUser_id:[NSString stringWithFormat:@"%ld",dlistModel.user_id]];
//                    [detailVc setStore_code:[NSString stringWithFormat:@"%@",dlistModel.store_code]];
//                    [weakSelf.navigationController pushViewController:detailVc animated:NO];
                    GKGLCustomerDetailVC * next = [[GKGLCustomerDetailVC alloc] init];
                    next.userID = [NSString stringWithFormat:@"%ld",(long)dlistModel.user_id];
                    [self.navigationController pushViewController:next animated:NO];
                }];
                [cell setBtn5SaleClick:^(SLDlistModel *saleModel,NSString *H5Str) {
                    FWDRecordController * next = [[FWDRecordController alloc] init];
                    next.ordernum = saleModel.ordernum;
                    [self.navigationController pushViewController:next animated:NO];
                }];
                return cell;
            }
            else{
                return basecell;
            }
        }
            break;
        case UserManagerType:
        {
            if (_getListModel.dList.count) {
                SLDlistModel *model = [_getListModel.dList objectAtIndex:indexPath.row];
                static NSString *Cellindentifier = @"Cellindentifier";
                OrderManagementCell *cell;
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderManagementCell" owner:nil options:nil] firstObject];
                }else{
                    cell  = [tableView dequeueReusableCellWithIdentifier:Cellindentifier];
                }
                [cell setModel:model];
                return cell;
            }
            else{
                return basecell;
            }
        }
            break;
        case UserSingleYuangongType:
        {
            
        }
            break;
        case UserSaleManagerType:
        {
            
        }
            break;
        case UserSaleQuanbugekeType:
        {
            static NSString *OrderServiceCellindentifier = @"MzzOrderSaleCell";
            MzzOrderSaleCell *cell;
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MzzOrderSaleCell" owner:nil options:nil] firstObject];
            }else{
                cell  = [tableView dequeueReusableCellWithIdentifier:OrderServiceCellindentifier];
            }
            cell.btn4.tag = indexPath.row;
            [cell.btn4 addTarget:self action:@selector(cellBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            if (_saleListModel.list.count) {
                SANewDingDanModel *saleModel = _saleListModel.list[indexPath.row];
                cell.framework_function_main_role = _framework_function_main_role;
                cell.saleModel = saleModel;
                
                [cell setBtn1SaleClick:^(SANewDingDanModel *saleModel,NSString *H5Str) {
                    [self jumpToH5WithString:H5Str andSaleModel:saleModel];
                }];
                [cell setBtn2SaleClick:^(SANewDingDanModel *saleModel,NSString *H5Str) {
                    if ([H5Str isEqualToString:@"补齐项目"]) {
                        if ([RolesTools orderReverseFlowPush]) {
                            OrderSaleViewController *next = [[OrderSaleViewController alloc]init];
                            next.isService = NO;
                            next.Dingdanmodel = saleModel;
                            next.from = @"补齐项目";
                            [self.navigationController pushViewController:next animated:NO];
                        }else{
                            //弹窗
                            [XMHProgressHUD showOnlyText:@"您没有制单权限，请进行其他操作"];
                        }
                    }else{
                        [self jumpToH5WithString:H5Str andSaleModel:saleModel];
                    }
                }];
                [cell setBtn3SaleClick:^(SANewDingDanModel *saleModel,NSString *H5Str) {
//                    MzzCustomerDetailsController *detailVc = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
//                    [detailVc setUser_id:[NSString stringWithFormat:@"%ld",saleModel.user_id]];
//                    [detailVc setStore_code:[NSString stringWithFormat:@"%@",saleModel.store_code]];
//                    [weakSelf.navigationController pushViewController:detailVc animated:NO];
                    GKGLCustomerDetailVC * next = [[GKGLCustomerDetailVC alloc] init];
                    next.userID = [NSString stringWithFormat:@"%ld",(long)saleModel.user_id];
                    [self.navigationController pushViewController:next animated:NO];
                }];
                return cell;
            }
            else{
                return basecell;
            }
        }
            break;
    }
    
    return nil;
}
- (void)jumpToH5WithString:(NSString *)H5Str andServeModel:(SLDlistModel *)dlistModel{
    WeakSelf;
    if ([H5Str isEqualToString:@"结算"]) {
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:dlistModel.ordernum andZt:@"2"];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    }else if ([H5Str isEqualToString:@"补签"]){
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:dlistModel.ordernum andZt:@"3"];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    }else if ([H5Str isEqualToString:@"撤销"]){
        NSString *typeName;
        switch (dlistModel.type) {
            case 0:
                typeName = @"服务单";
                break;
            case 1:
                typeName = @"销售服务单";
        }
        [[[MzzHud alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"确定要撤销已开好的%@吗？撤销后将不可恢复！",typeName] leftButtonTitle:@"取消" rightButtonTitle:@"确定撤销" click:^(NSInteger index) {
            if (index ==1) {
                NSMutableDictionary * params = [NSMutableDictionary dictionary];
                params[@"id"] = [NSString stringWithFormat:@"%ld",dlistModel.ID];
                [SLRequest requestServDelParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                    if (model.code == 1) {
                        [MzzHud toastWithTitle:@"提示" message:@"撤销成功" complete:^{
                            [self requestTableViewData];
                        }];
                    }else{
                        [MzzHud toastWithTitle:@"提示" message:@"撤销失败"];
                    }
                }];
            }
        }]show];
    }
}
- (void)jumpToH5WithString:(NSString *)H5Str andSaleModel:(SANewDingDanModel *)saleModel{
    WeakSelf;
    if ([H5Str isEqualToString:@"审批"]) {
        LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        ApproveDetailModel *model = [ApproveDetailModel new];
        model.token = infomodel.data.token;
        model.accountId = saleModel.amount_d;
        model.join_code = saleModel.join_code;
        model.code = saleModel.code;
        model.from = @"-1";
        model.ordernum = saleModel.ordernum;
        model.fromList = YES;
        switch (saleModel.type) {
            case 1: //固定
            {
                model.navTitle = @"固定制单";
                model.urlstr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
            }
                break;
            case 2: //已购置换
            {
                model.navTitle = @"已购置换";
                model.urlstr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
            }
                break;
            case 3: //个性
            {
                model.navTitle = @"个性制单";
                model.urlstr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
            }
                break;
            case 4: //升卡续卡
            {
                model.navTitle = @"升卡续卡";
                model.urlstr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
            }
                break;
        }
        ApproveDetailController *vc = [[ApproveDetailController alloc] init];
        [vc setDetailModel:model];
        vc.store_code = saleModel.store_code;
        [self.navigationController pushViewController:vc animated:NO];
    }else if ([H5Str isEqualToString:@"结算"]){
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianJieSuan andType:saleModel.type andUid:[NSString stringWithFormat:@"%ld",saleModel.uid]withName:H5Str];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    }else if ([H5Str isEqualToString:@"撤销"]){
        NSString *typeName;
        switch (saleModel.type) {
            case 1:
                typeName = @"固定制单";
                break;
            case 2:
                typeName = @"已购置换";
            case 3:
                typeName = @"个性制单";
            case 4:
                typeName = @"升卡续卡";
                
        }
        if (saleModel.order_type != 10) {
            [[[MzzHud alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"确定要撤销已开好的%@吗？撤销后将不可恢复！",typeName] leftButtonTitle:@"取消" rightButtonTitle:@"确定撤销" click:^(NSInteger index) {
                if (index ==1) {
                    [SaleListRequest requestDelSalesId:saleModel.ID resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                        if (isSuccess) {
                            [MzzHud toastWithTitle:@"提示" message:@"撤销成功" complete:^{
                                [self requestTableViewData];
                            }];
                        }else{
                            [MzzHud toastWithTitle:@"提示" message:@"撤销失败"];
                        }
                    }];
                }
            }]show];
        }else{
            [[[MzzHud alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"是否撤销订单？"] leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
                if (index ==1) {
                    [SaleListRequest requestDelSalesOrdernum:saleModel.ordernum withJoinCode:saleModel.join_code resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                        if (isSuccess) {
                            [MzzHud toastWithTitle:@"提示" message:@"撤销成功" complete:^{
                                [self requestTableViewData];
                            }];
                        }else{
                            [MzzHud toastWithTitle:@"提示" message:@"撤销失败"];
                        }
                    }];
                }
            }]show];
        }
    }else if ([H5Str isEqualToString:@"终止"]){
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianZhongZhi andType:saleModel.type andUid:[NSString stringWithFormat:@"%ld",saleModel.uid]withName:H5Str];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    }else if ([H5Str isEqualToString:@"还款"]){
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianHuanKuan andType:saleModel.type andUid:[NSString stringWithFormat:@"%ld",saleModel.uid]withName:H5Str];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    }else if ([H5Str isEqualToString:@"补签"]){
        MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
        [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianBuQian andType:saleModel.type andUid:[NSString stringWithFormat:@"%ld",saleModel.uid]withName:H5Str];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    }
}

- (void)cellBtnEvent:(UIButton *)sender{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if (_isSale) {
        SANewDingDanModel *model = [_saleListModel.list objectAtIndex:indexPath.row];
        model.isShow = !model.isShow;
    }else{
        SLDlistModel *model = [_getListModel.dList objectAtIndex:indexPath.row];
        model.isShow = !model.isShow;
    }
    [_tbView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_orderUserType) {
        case UserQuanbugekeType:
            if (_getListModel.dList.count) {
                return _getListModel.dList.count;
            } else {
                return 1;
            }
            break;
        case UserManagerType:
            if (_getListModel.dList.count) {
                return _getListModel.dList.count;
            } else {
                return 1;
            }
            break;
        case UserSingleYuangongType:
            return  0;
            break;
        case UserSaleManagerType:
            return  0;
            break;
        case UserSaleQuanbugekeType:
            if (_saleListModel.list.count) {
                return _saleListModel.list.count;
            } else {
                return 1;
            }
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_orderUserType) {
        case UserManagerType:
            if (_getListModel.dList.count) {
                return 86;
            } else {
                return 150;
            }
            break;
        case UserQuanbugekeType:
        {
            if (_getListModel.dList.count) {
                SLDlistModel *model = _getListModel.dList[indexPath.row];
                return 55 + 265 *model.isShow;
            } else {
                return 150;
            }
            
        }
            break;
        case UserSingleYuangongType:
        {
            return 0;
        }
            break;
        case UserSaleManagerType:
        {
            return 0;
        }
            break;
        case UserSaleQuanbugekeType:
        {
            
            if (_saleListModel.list.count) {
                SANewDingDanModel *model = _saleListModel.list[indexPath.row];
                return 49 + 225 *model.isShow;
            } else {
                return 150;
            }
        }
            break;
    }
    return 0;//55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf;
    
    switch (_orderUserType) {
        case UserManagerType:
        {
            if (_getListModel.dList.count) {
                SLDlistModel *model = [_getListModel.dList objectAtIndex:indexPath.row];
                self.cinId = model.inId;
                self.ctwoClick = [NSString stringWithFormat:@"%ld",model.fram_id];
                self.ctwoListId = [NSString stringWithFormat:@"%ld",model.fram_name_id];
                
                ZuZhiChoiceModel *zuzhiModel = [[ZuZhiChoiceModel alloc]init];
                zuzhiModel.name = model.name;
                zuzhiModel.fram_id = model.fram_id;
                zuzhiModel.fram_name_id = model.fram_name_id;
                zuzhiModel.inId = model.inId;
                [_organizationHeader freshorganizationalView:zuzhiModel];
                [self confirmOrg];
            }
        }
            break;
        case UserQuanbugekeType:
        {
            if (_getListModel.dList.count) {
                SLDlistModel *model = [_getListModel.dList objectAtIndex:indexPath.row];
                MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
                [vc setOrderNum:model.ordernum andZt:@"1"];
                [weakSelf.navigationController pushViewController:vc animated:NO];
            }
        }
            break;
        case UserSaleQuanbugekeType:
        {
            if (_saleListModel.list.count) {
                SANewDingDanModel *saleModel = [_saleListModel.list objectAtIndex:indexPath.row];
                MzzJiSuanViewController *vc = [[MzzJiSuanViewController alloc] init];
                if (saleModel.order_type != 10){
                    [vc setOrderNum:saleModel.ordernum andYemianStyle:YemianXiangQing andType:saleModel.type andUid:[NSString stringWithFormat:@"%ld",saleModel.uid]withName:@""];
                }else{
                    [vc setOrderDetailNum:saleModel.ordernum andYemianStyle:YemianFenQiXiangQing];
                    vc.Dingdanmodel = saleModel;
                }
                [weakSelf.navigationController pushViewController:vc animated:NO];
            }
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
#pragma clang diagnostic pop
