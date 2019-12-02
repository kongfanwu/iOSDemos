//
//  CustomerManageViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/24.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerManageViewController.h"
#import "CustomerTableHeaderView.h"
#import "CustomerSectionView.h"
#import "CustomerTableViewCell.h"
#import "WKwebViewCell.h"
#import "JobSelectorModel.h"
#import <WebKit/WebKit.h>
#import "FilterViewController.h"
#import "SearchCell.h"
#import "AddCustomerViewController.h"
#import "CustomerCell.h"
#import "MzzCustomerInfoController.h"
#import "CustomerListModel.h"
#import "CustomerFrameModel.h"
#import "MzzCustomerDetailsController.h"
#import "AddCustomerViewController.h"
#import "MzzCustomerRequest.h"
#import "FilterViewController.h"
#import "DatePickerView.h"
#import "DateHeaderView.h"
//#import "BaseModel.h"
#import "YYModel.h"
#import "MzzFilterCommitModel.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "MzzLevelModel.h"
#import "MzzOrganizationCell.h"
#import "MzzInsertCustomerController.h"
#import "DateView.h"
#import "MzzManageModel.h"
#import "ZuZhiChoiceModel.h"

#import "CustomerTbHeader.h"
#import "DateSubViewModel.h"
#import "CommonHeaderView.h"
#import "RolesTools.h"
#import "GuideView.h"
#import "BookRequest.h"
#import "CustomerMessageModel.h"
#import "XMHRefreshGifHeader.h"
//用户权限
typedef NS_ENUM(NSUInteger){
    UserNotGukeType,
    UserGukeType,
    UserYuangongType
}UserType;

@interface CustomerManageViewController ()<UITableViewDelegate,UITableViewDataSource,CustomerSectionViewDelegate,WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong)UITableView * customerView;
@property(nonatomic ,strong)WKwebViewCell *wkcell;
@property(nonatomic ,strong)SearchCell *searchcell;
@property(nonatomic,strong)FilterViewController *filterVc;
@property(nonatomic,strong)UITapGestureRecognizer *gr;
@property(nonatomic,assign)UserType userType;
@property(nonatomic ,strong)ManageData *manageData;
@property(nonatomic ,strong)CustomerListModel *customerListModel;
@property(nonatomic ,strong)CustomerTableHeaderView* headView;
@property(nonatomic ,assign)NSInteger  currentPage;
@property(nonatomic ,strong)LevelData *levelData;
@property (nonatomic ,copy)NSString *start_date;
@property (nonatomic ,copy)NSString *end_date;
@property (nonatomic ,copy)NSString *list_type;
@property (nonatomic, assign) NSInteger framework_function_main_role;
@property (nonatomic ,assign)BOOL haveOrgnazationData;
@property (nonatomic ,strong)MzzFilterCommitModel * commitModel;
@property (nonatomic ,strong)UIView * cover;
@property (nonatomic ,assign)CGFloat webHeight;
@property (nonatomic ,strong)MzzTitleAndDetailView * selectedTitleAndDetailView;
@property (nonatomic ,strong)CustomerTbHeader * tbHeader;
@property (nonatomic ,strong)NSArray * shouqianarr;
@property (nonatomic ,strong)NSArray * shouhouarr;
@property (nonatomic, strong)NSDictionary * nameTypeDict;
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation CustomerManageViewController
{
    DatePickerView *_dp;
    NSInteger _specialCellCount ;
    NSString *cjoin_code;
    NSString *ctoken;
    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
    NSInteger clevel;
    NSString *cuserId;
    NSInteger cmain_role;
    NSInteger _titleIndex;
    
    /** 0售前售后、1售前 、2售后*/
    CGFloat  _titleTag;
    
    BOOL _isFirst;
    
    BOOL _isFirstAllCustomer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirst = YES;
    _isFirstAllCustomer = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    WeakSelf
    //初始化数据
    _shouqianarr = [[NSArray alloc] init];
    _shouhouarr = [[NSArray alloc] init];
    _titleIndex = 100;
    _nameTypeDict = @{@"会员保有":@"by",@"休眠顾客":@"xm",@"流失顾客":@"ls",@"新增顾客":@"xz",@"待续卡顾客":@"dxk",@"标准顾客":@"bz",@"调店顾客":@"td",@"扫码顾客":@"sm",@"扫码":@"sm",@"激活":@"jh",@"激活":@"jh",@"试做":@"sz",@"试做":@"sz",@"成交":@"cj",@"成交":@"cj",@"承接":@"jd",@"转化":@"zh"};
    
    //获取登录信息
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _framework_function_main_role = infomodel.data.join_code[0].framework_function_main_role;
    ctoken = infomodel.data.token;
    
    //组织提交model
    _commitModel = [[MzzFilterCommitModel alloc] init];
    _commitModel.page = 0;
    
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    
    //(组织架构 + 时间选择器 + 层级组合)View
    CommonHeaderView * commonView = [[CommonHeaderView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100) module:@"GKGL"];
    commonView.CommonHeaderViewBlock = ^(COrganizeModel *organizeModel,BOOL isShow) {
        if (!isShow) {
            _customerView.frame = CGRectMake(0, 60 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 60);
        }else{
            _customerView.frame = CGRectMake(0, 100 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 100);
        }
        _start_date = organizeModel.start ;
        _end_date = organizeModel.end ;
        cjoin_code = organizeModel.joinCode;
        coneClick = organizeModel.oneClick;
        ctwoClick =  organizeModel.twoClick;
        ctwoListId =  organizeModel.twoListId;
        cinId =  organizeModel.inId;
        _commitModel.page = 0;
        clevel =  organizeModel.level;
        cuserId =  organizeModel.listInfo.ID;
        /** lol 20190222 临时解决方案 */
        if (_isFirst) {
           cmain_role = [RolesTools getUserMainRole];
            _isFirst = NO;
        }else{
           cmain_role =  organizeModel.main_role;
            
        }
//         cmain_role =  organizeModel.main_role;
        if ([organizeModel.twoClick isEqualToString:organizeModel.oneClick]) { //lol
            ctwoClick = @"all";
        }
        [self confirmOrg];
        if (_userType == UserGukeType){
            [_tbHeader updateCustomerSelectStateCanSelect:YES];
        }else{
            [_tbHeader updateCustomerSelectStateCanSelect:NO];
        }
        [self Updatelimit];
        
    };
    [self.view addSubview:commonView];
    
    //判断权限是否展示添加顾客按钮
    if ([RolesTools customerShowBtnQuanxian]) {
        [self.navView setNavViewTitle:@"顾客管理" backBtnShow:YES rightBtnTitle:@"添加顾客"];
        self.navView.NavViewRightBlock = ^{//跳转添加顾客
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MzzInsertCustomerController" bundle:nil];
            MzzInsertCustomerController *addvc = sb.instantiateInitialViewController;
            [weakSelf.navigationController pushViewController:addvc animated:NO];
        };
    }else{
        [self.navView setNavViewTitle:@"顾客管理" backBtnShow:YES rightBtnTitle:nil];
    }
    
    //创建TableView
    [self creatCustomerView];
    
    //创建筛选控制器
    [self creatFilterVc];
    
    GuideView * guide = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [guide showGuideViewModule:@"GKGL"];
    
}
/** 是否显示 售前 售后 按钮根据点击到那个人走  如果点击是全部顾客按照登录人的为准是否显示 */
- (void)Updatelimit
{
    NSArray * roles = @[@"1",@"2",@"3",@"4",@"5",@"7"];
    NSString * role = [NSString stringWithFormat:@"%ld",cmain_role];
    if ([roles containsObject:role]) {
        _titleTag = 0;
      
    }
    /** 售前店长  售前美容师 售中美容师 导购*/
    if ([role isEqualToString:@"9"]||[role isEqualToString:@"10"]||[role isEqualToString:@"11"]||[role isEqualToString:@"6"]) {
        _titleTag = 1;
    }
    if ([role isEqualToString:@"8"]) {
        _titleTag = 2;
    }
    if (_titleTag == 0) {
        _tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }
    if (_titleTag == 1 || _titleTag == 2) {
        _tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    }
    _customerView.tableHeaderView = _tbHeader;
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)creatCustomerView
{
    WeakSelf
    _wkcell = [self setupWKcell];
    _searchcell = [self setupSearchCell];
    _customerView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav -100) style:UITableViewStylePlain];
    _customerView.delegate = self;
    _customerView.dataSource = self;
    _customerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _customerView.estimatedRowHeight = 0;
    _customerView.estimatedSectionHeaderHeight = 0;
    _customerView.estimatedSectionFooterHeight = 0;
    [_customerView registerNib:[UINib nibWithNibName:@"MzzOrganizationCell" bundle:nil] forCellReuseIdentifier:@"MzzOrganizationCell"];
    
    if (!_tbHeader) {
       _tbHeader = loadNibName(@"CustomerTbHeader");
    }
    if (_titleTag == 0) {
        _tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }
    if (_titleTag == 1 || _titleTag == 2) {
        _tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    }
    
    __weak CustomerTbHeader * weaktbHeaderView = _tbHeader;
    
    _tbHeader.CustomerTbHeaderMoreBlock = ^(BOOL isSelect) {
        if (isSelect) {
            if (_titleTag == 0) {
                weaktbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
            }
            if (_titleTag == 1 || _titleTag == 2) {
                weaktbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
            }
        }else{
            if (_titleTag == 0) {
               weaktbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
            }
            if (_titleTag == 1 || _titleTag == 2) {
                weaktbHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
            }
            
        }
        weakSelf.customerView.tableHeaderView = weaktbHeaderView;
    };
    
    _tbHeader.CustomerTbHeaderTitleBlock = ^(NSInteger index) {
        _titleIndex = index;
        if (index == 100) {
            [weaktbHeaderView updateCustomerTbHeaderModel:weakSelf.shouhouarr];
        }else if (index == 101){
            [weaktbHeaderView updateCustomerTbHeaderModel:weakSelf.shouqianarr];
        }else{}
    };
   
    _tbHeader.CustomerTbHeaderContentBlock = ^(NSInteger index, NSString *name) {
        if (_userType == UserGukeType){
            weakSelf.commitModel.page =0;
            _list_type = _nameTypeDict[name];
            [weakSelf requestCotomerData];
        }
    };
    _customerView.tableHeaderView = _tbHeader;
    [self.view addSubview:_customerView];

    _customerView.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf requestNetData];
//    }];
    _customerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreNetData];
        
    }];
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            [self requestNetData];
        }];
    }
    return _gifHeader;
}
-(void)creatFilterVc{
    if (_filterVc == nil) {
        WeakSelf;
        _filterVc = [[FilterViewController alloc] init];
        _filterVc.FilterViewControllerBlock = ^(MzzFilterCommitModel *model) {
            _commitModel = model;
            weakSelf.commitModel.page = 0;
            //顾客列表
            [MzzCustomerRequest requestCustomerListParams:[weakSelf.commitModel yy_modelToJSONObject] resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
                if (listModel) {
                    weakSelf.customerListModel = listModel;
                    [weakSelf.customerView reloadData];
                }
                [weakSelf slipDownFilterVc];
            }];
        };
        _filterVc.view.x = SCREEN_WIDTH;
        _filterVc.view.bounds = self.view.bounds;
        [self.view addSubview:_filterVc.view];
    }
}

- (void)confirmOrg{

    if (ctwoListId.intValue == -1 && ![ctwoClick isEqualToString:@"all"]) {
        if ([ctwoClick isEqualToString:coneClick]) { //lol
            return;
        }
        MzzCustomerDetailsController *detailsVc = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        [param setValue:cuserId forKey:@"user_id"];
        [BookRequest requestCustomerMessageParams:param resultBlock:^(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                [detailsVc setUser_id:cuserId];
                detailsVc.store_code = customerMessageModel.store_code;
                [self.navigationController pushViewController:detailsVc animated:NO];
            }
        }];
       
        return;
    }
    /** lol 20190222 临时解决方案 */
    if (!_isFirstAllCustomer) {
        if( cmain_role == 8 || cmain_role == 9 || cmain_role == 10 || cmain_role == 11) {
            _userType = UserYuangongType;
            [self  requestOriginData];
            return;
        }
        _isFirstAllCustomer = NO;
    }
    
    if ((ctwoListId.intValue == -1 && [ctwoClick isEqualToString:@"all"]) ) {
        _userType =UserGukeType;
         [self  requestOriginData];
        return;
    }
    
    _userType =UserNotGukeType;
    [self  requestOriginData];
    return;
}
- (void)requestCotomerData{
    //顾客列表
    _commitModel.oneClick = coneClick;
    _commitModel.twoClick = ctwoClick;
    _commitModel.inId = cinId;
    _commitModel.twoListId = ctwoListId;
    _commitModel.join_code = cjoin_code;
    _commitModel.start_date = _start_date;
    _commitModel.end_date = _end_date;
    _commitModel.list_type = _list_type;
    
    [MzzCustomerRequest requestCustomerListParams:[_commitModel yy_modelToJSONObject] resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _customerListModel = listModel;
        [_customerView reloadData];
        [self endRefreshing];
    }];
}
//请求原始数据
-(void)requestOriginData{
    _commitModel.page =0;
    _list_type = nil;
    [_headView.jobSelector clearColor];
    switch (_userType) {
        case UserGukeType:
        {
            //设定显示样式
               _specialCellCount = 1;
            //一级页面前面8块数据
            [self requestTbHeaderViewData];
            //更改jobselector样式
            if (_framework_function_main_role ==6) {
                //售前店长
                [_headView.jobSelector updateStyleOnlyFirstBtn];
            }
            if (_framework_function_main_role ==8) {
                //售后美容师
                [_headView.jobSelector updateStyleOnlySecondBtn];
            }
            if (_framework_function_main_role ==9 || _framework_function_main_role ==10 || _framework_function_main_role ==11) {
                
                [_headView.jobSelector updateStyleOnlyFirstBtn];
            }
//            [self end];
            [self requestCotomerData];
        }
            break;
            case UserYuangongType:
        {
            //设定显示样式
            _specialCellCount = 1;
            //一级页面前面8块数据
            [self requestTbHeaderViewData];
                //更改jobselector样式
            if (_framework_function_main_role ==6) {
                //售前店长
                [_headView.jobSelector updateStyleOnlyFirstBtn];
            }
            if (_framework_function_main_role ==8) {
                //售后美容师
                [_headView.jobSelector updateStyleOnlySecondBtn];
            }
            if (_framework_function_main_role ==9 || _framework_function_main_role ==10 || _framework_function_main_role ==11) {
                
                [_headView.jobSelector updateStyleOnlyFirstBtn];
            }
//            [self end];
            
            //刷新图表
            [_wkcell reloadWkWithMainrole:cmain_role];
            _levelData = nil;
            _customerListModel = nil;
            [_customerView reloadData];
        }
            break;
        default:
        {
            //设定显示样式
            _specialCellCount = 1;
            //一级页面前面8块数据
            
            [self requestTbHeaderViewData];

            //更改jobselector样式
            if (_framework_function_main_role ==6) {
                //售前店长
                [_headView.jobSelector updateStyleOnlyFirstBtn];
            }
            if (_framework_function_main_role ==8) {
                //售后美容师
                [_headView.jobSelector updateStyleOnlySecondBtn];
            }
            if (_framework_function_main_role ==9 || _framework_function_main_role ==10 || _framework_function_main_role ==11) {
                
                [_headView.jobSelector updateStyleOnlyFirstBtn];
            }
//             [self end];
            NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
            parmas[@"oneClick"] =coneClick;
            parmas[@"twoClick"] = ctwoClick;
            parmas[@"inId"] = cinId;
            parmas[@"twoListId"] =ctwoListId;
            parmas[@"join_code"] = cjoin_code;
            parmas[@"start_date"] = _start_date;
            parmas[@"end_date"] = _end_date;
            //信息列表
            parmas[@"page"] = [NSString stringWithFormat:@"%ld",_commitModel.page];
            [MzzCustomerRequest requestManageGroupListParams:parmas resultBlock:^(LevelData *listModel, BOOL isSuccess, NSDictionary *errorDic) {
                _levelData = listModel;
                [_customerView reloadData];
                 [self endRefreshing];
            }];
            //刷新图表
            [_wkcell reloadWkWithMainrole:cmain_role];
        }
            break;
    }
   
   
}
//刷新数据
- (void)requestNetData{
    //顾客列表
    [self requestOriginData];
    
}

//加载更多
- (void)requestMoreNetData{
    //数据保存工作
    _commitModel.page ++;
    //
    switch (_userType) {
        case UserGukeType:
        {
            //顾客列表
            [MzzCustomerRequest requestCustomerListParams:[_commitModel yy_modelToJSONObject] resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
                [_customerListModel.list addObjectsFromArray:listModel.list];
                [_customerView reloadData];
                 [self endRefreshing];
                if (listModel.list.count ==0) {
                    _commitModel.page --;
                }
            }];
        }
            break;
            
        default:
        {
            NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
            parmas[@"oneClick"] =coneClick;
            parmas[@"twoClick"] = ctwoClick;
            parmas[@"inId"] = cinId;
            parmas[@"twoListId"] =ctwoListId;
            parmas[@"join_code"] = cjoin_code;
            parmas[@"start_date"] = _start_date;
            parmas[@"end_date"] = _end_date;
            parmas[@"page"] = [NSString stringWithFormat:@"%ld",_commitModel.page];
            //信息列表
            [MzzCustomerRequest requestManageGroupListParams:parmas resultBlock:^(LevelData *listModel, BOOL isSuccess, NSDictionary *errorDic) {
                [_levelData.group_list addObjectsFromArray: listModel.group_list];
                [_customerView reloadData];
                 [self endRefreshing];
                if (_levelData.group_list.count ==0) {
                  _commitModel.page --;
                }
            }];
        }
            break;
    }
    
}


- (void)endRefreshing{
    [_customerView.mj_header endRefreshing];
    [_customerView.mj_footer endRefreshing];
}

//初始化图表页
- (WKwebViewCell *)setupWKcell{
    WeakSelf;
    _wkcell = [[[NSBundle mainBundle]loadNibNamed:@"WKwebViewCell" owner:nil options:nil] firstObject];
    _wkcell.WKDelegate = self;
//    [_wkcell loadRequestwith:[NSString stringWithFormat:@"%@gk/callios.html",SERVER_H5]];
    [_wkcell setWebHeight:^(CGFloat height) {
        weakSelf.webHeight = height + 10;
//        [weakSelf.customerView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.customerView reloadData];
    }];
    return _wkcell;
}

//初始化搜索cell
-(SearchCell * )setupSearchCell{
    _searchcell = [[[NSBundle mainBundle]loadNibNamed:@"SearchCell" owner:nil options:nil] firstObject];
    WeakSelf;
        _searchcell.filter = ^(UIButton *sender) {
        [weakSelf slipUpFilterVc];
    };
        _searchcell.search = ^(NSString *searchBarTest) {
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.view endEditing:YES];
        }];
            weakSelf.commitModel.q =searchBarTest;
            weakSelf.commitModel.page = 0;
            //顾客列表
            [MzzCustomerRequest requestCustomerListParams:[weakSelf.commitModel yy_modelToJSONObject] resultBlock:^(CustomerListModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
                if (listModel) {
                    weakSelf.customerListModel = listModel;
                    [weakSelf.customerView reloadData];
                }
            }];
    };
    return _searchcell;
}
/*
 //注入js
 */
- (void)addScript:(NSString *)js{
    
    [_wkcell evaluatJs:js];
}
- (void)slipUpFilterVc{
    [_filterVc setCommitModel:nil];
    _cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _cover.backgroundColor = [UIColor blackColor];
    _cover.alpha = 0.5;
    [self.view addSubview:_cover];
    _gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slipDownFilterVc)];
    [_cover addGestureRecognizer:_gr];
    [self.view bringSubviewToFront:_filterVc.view];
    [UIView animateWithDuration:0.3 animations:^{
        _filterVc.view.x = 75;
    }];
}
- (void)slipDownFilterVc{
    [_cover removeGestureRecognizer:_gr];
    [_cover removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _filterVc.view.x = SCREEN_WIDTH;
    }];
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *js = [NSString stringWithFormat:@"guke('%@','%@','%@','%@','%@','%@','%@','%@')",ctoken,coneClick,ctwoClick,ctwoListId,_start_date,_end_date,cjoin_code,cinId];
    [XMHWebSignTools loadWebViewJs:webView];
    [self addScript:js];
  
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{

}
//wk被terminate时调用
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}
#pragma mark - WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler{


}
#pragma mark - CustomerSectionViewDelegate
-(void)choiceIndex:(NSInteger)index andCollectionIndexpath:(NSIndexPath *) indexpath{
    NSLog(@"%ld and %tu,%tu",index,indexpath.section,indexpath.row);
}



#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomerSectionView *view = [[[NSBundle mainBundle] loadNibNamed:@"CustomerSectionView" owner:nil options:nil] firstObject];
    view.delegate = self;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_userType) {
        case UserNotGukeType:
            //管理权限
        {
            if (indexPath.row ==0) {
                return _webHeight;
            }else{
                return 100;
            }
        }
            break;
        case UserGukeType:
            //顾客管理权限
        {
            if (indexPath.row == 0) {
                return 50;
            }
            CustomerModel *model = [_customerListModel.list objectAtIndex:indexPath.row -_specialCellCount];
            CustomerFrameModel *frameM = [[CustomerFrameModel alloc] init];
            [frameM setCustomerModel:model];
            return frameM.rowHeight;
        }
            break;
            case UserYuangongType:
        {
            if (indexPath.row == 0) {
                return _webHeight;
            }
            return 0;
        }
            break;
    }
    return 0;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 195;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_customerView deselectRowAtIndexPath:indexPath animated:NO];
    //TODO
    if (indexPath.row < _specialCellCount ) {
        return;
    }
    switch (_userType) {
        case UserNotGukeType:
           
        {
            MzzCustomerLevelModel *model = [_levelData.group_list objectAtIndex:indexPath.row - _specialCellCount];
            if (model.inId && ![model.inId isEqual:@""]) {
                cinId = model.inId;
            }else{
                LolUserInfoModel *usermodel =  [UserManager getObjectUserDefaults:userLogInInfo];
                cinId = usermodel.data.account;
            }
            
            ctwoClick = [NSString stringWithFormat:@"%ld",model.fram_id];
            ctwoListId = [NSString stringWithFormat:@"%ld",model.fram_name_id];
            clevel = model.level;
            cmain_role = model.main_role;
            ZuZhiChoiceModel *zuzhiModel = [[ZuZhiChoiceModel alloc]init];
            zuzhiModel.name = model.name;
            zuzhiModel.fram_id = model.fram_id;
            zuzhiModel.fram_name_id = model.fram_name_id;
            zuzhiModel.inId = model.inId;
            [_headView.organizationHeader freshorganizationalView:zuzhiModel];
            [self confirmOrg];
        }
            break;
        case UserGukeType:
            //顾客管理权限
        {
            MzzCustomerDetailsController *detailsVc = [UIStoryboard storyboardWithName:@"MzzCustomerDetails" bundle:nil].instantiateInitialViewController;
            CustomerModel *model = [_customerListModel.list objectAtIndex:indexPath.row - _specialCellCount];
            [detailsVc setUser_id:[NSString stringWithFormat:@"%ld",model.uid]];
            [detailsVc setStore_code:[NSString stringWithFormat:@"%@",model.store_code]];
            [self.navigationController pushViewController:detailsVc animated:NO];
        }
            break;
            case UserYuangongType:
        {
            
        }
            break;
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_userType) {
        case UserGukeType:
            //顾客管理权限
        {
            NSInteger countRow =_customerListModel.list.count + _specialCellCount;
           return countRow;
        }
            break;
        case UserYuangongType:
            //顾客员工权限
        {
            return 1;
        }
            break;
        default:
        {
            NSInteger countRow =_levelData.group_list.count + _specialCellCount;
            return countRow;
        }
    }
      return 0 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    switch (_userType) {
        case UserGukeType:
            //顾客管理权限
        {

            if (indexPath.row == 0) {
                return _searchcell;
            }
            CustomerModel *model = [_customerListModel.list objectAtIndex:indexPath.row - _specialCellCount];
            CustomerFrameModel *frameM = [[CustomerFrameModel alloc] init];
            [frameM setCustomerModel:model];
            
            CustomerCell *cuscell = [CustomerCell tableView:tableView CellWithCustomerFrame:frameM];
            cuscell.btnclick = ^(UIButton *btn) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"addCustomerViewController" bundle:nil];
                AddCustomerViewController *addvc = sb.instantiateInitialViewController;
                addvc.customerModel = model;
                [weakSelf.navigationController pushViewController:addvc animated:NO];
            };
            return cuscell;
        }
            break;
            case UserYuangongType:
        {
            if (indexPath.row == 0) {
                return _wkcell;
            }
        }
            break;
        default:
        {
            if (indexPath.row == 0) {
                return _wkcell;
            }
            MzzCustomerLevelModel *model = [_levelData.group_list objectAtIndex:indexPath.row - _specialCellCount];
            MzzOrganizationCell *cuscell = [tableView dequeueReusableCellWithIdentifier:@"OrganizationCell"];
            if (cuscell == nil) {
                cuscell = [[NSBundle mainBundle] loadNibNamed:@"MzzOrganizationCell" owner:nil options:nil].firstObject;
            }
            [cuscell setData:model];
            return cuscell;
        }
            break;
    }
    return nil;
}
//更新头部数据
- (void)requestTbHeaderViewData
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"oneClick"] =coneClick;
    parmas[@"twoClick"] = ctwoClick;
    parmas[@"inId"] = cinId;
    parmas[@"twoListId"] =ctwoListId;
    parmas[@"join_code"] = cjoin_code;
    parmas[@"start_date"] = _start_date;
    parmas[@"end_date"] = _end_date;
    [MzzCustomerRequest requestManagerParams:parmas resultBlock:^(ManageData *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        _manageData = listModel;
        ShouqianModel *shouqian = _manageData.shouqian;
        ShouhouModel *shouhou = _manageData.shouhou;
        
        DateSubViewModel * model1 = [DateSubViewModel createModelIconName:@"stgkgl_huiyuanbaoyou" textName:@"会员保有" textValue:[NSString stringWithFormat:@"%ld",shouhou.by] isShow:NO];
        DateSubViewModel * model2 = [DateSubViewModel createModelIconName:@"stgkgl_xiumian" textName:@"休眠顾客" textValue:[NSString stringWithFormat:@"%ld",shouhou.xm] isShow:NO];
        DateSubViewModel * model3 = [DateSubViewModel createModelIconName:@"stgkgl_liushi" textName:@"流失顾客" textValue:[NSString stringWithFormat:@"%ld",shouhou.ls] isShow:NO];
        DateSubViewModel * model4 = [DateSubViewModel createModelIconName:@"stgkgl_xinzeng" textName:@"新增顾客" textValue:[NSString stringWithFormat:@"%ld",shouhou.xz] isShow:NO];
        DateSubViewModel * model5 = [DateSubViewModel createModelIconName:@"stgkgl_daixuka" textName:@"待续卡顾客" textValue:[NSString stringWithFormat:@"%ld",shouhou.xk] isShow:NO];
        DateSubViewModel * model6 = [DateSubViewModel createModelIconName:@"stgkgl_biaozhuo" textName:@"标准顾客" textValue:[NSString stringWithFormat:@"%ld",shouhou.bz] isShow:NO];
        DateSubViewModel * model7 = [DateSubViewModel createModelIconName:@"tstgkgl_tiaodian" textName:@"调店顾客" textValue:[NSString stringWithFormat:@"%ld",shouhou.td] isShow:NO];
        _shouhouarr = @[model1,model2,model3,model4,model5,model6,model7];
        
        DateSubViewModel * model11 = [DateSubViewModel createModelIconName:@"stgkgl_saoma" textName:@"扫码" textValue:[NSString stringWithFormat:@"%ld",shouqian.sm] isShow:NO];
        DateSubViewModel * model22 = [DateSubViewModel createModelIconName:@"stgkgl_jihuo" textName:@"激活" textValue:[NSString stringWithFormat:@"%ld",shouqian.jh] isShow:NO];
        DateSubViewModel * model33 = [DateSubViewModel createModelIconName:@"stgkgl_shizuo" textName:@"试做" textValue:[NSString stringWithFormat:@"%ld",shouqian.sz] isShow:NO];
        DateSubViewModel * model44 = [DateSubViewModel createModelIconName:@"stgkgl_chengjiao" textName:@"成交" textValue:[NSString stringWithFormat:@"%ld",shouqian.cj] isShow:NO];
        DateSubViewModel * model55 = [DateSubViewModel createModelIconName:@"stgkgl_chengjie" textName:@"承接" textValue:[NSString stringWithFormat:@"%ld",shouqian.jd] isShow:NO];
        DateSubViewModel * model66 = [DateSubViewModel createModelIconName:@"stgkgl_zhuanhua" textName:@"转化" textValue:[NSString stringWithFormat:@"%ld",shouqian.zh] isShow:NO];
        DateSubViewModel * model77 = [DateSubViewModel createModelIconName:@"tstgkgl_tiaodian" textName:@"调店" textValue:[NSString stringWithFormat:@"%ld",shouqian.td] isShow:NO];
        _shouqianarr = @[model11,model22,model33,model44,model55,model66,model77];

        if (_titleTag == 0) {
            [_tbHeader updateCustomerTbHeaderTitle:@[@"售后",@"售前"]];
            if (_titleIndex == 100) {
                [_tbHeader updateCustomerTbHeaderModel:_shouhouarr];
            }
            if (_titleIndex == 101) {
                [_tbHeader updateCustomerTbHeaderModel:_shouqianarr];
            }
        }
        if (_titleTag == 1) {
            [_tbHeader updateCustomerTbHeaderTitle:nil];
            [_tbHeader updateCustomerTbHeaderModel:_shouqianarr];
        }
        if (_titleTag == 2) {
            [_tbHeader updateCustomerTbHeaderTitle:nil];
            [_tbHeader updateCustomerTbHeaderModel:_shouhouarr];
        }
        
        
    }];
}
@end
