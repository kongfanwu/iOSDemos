//
//  WorkViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WorkViewController.h"
#import "workHome.h"
#import "workHome2.h"
#import "workBtnChoice.h"
#import "workSecondBtnChoice.h"
#import "workCell1.h"
#import "messageCell.h"
#import "MessageCellNote.h"
#import "ShareWorkInstance.h"
#import "BtnChioceType.h"
#import "DaiFuWuCell.h"
#import "workCell2.h"
#import "WorkChoiceView.h"
#import "UserManager.h"
#import "WorkRequest.h"
#import "WorkModel.h"
#import <YYWebImage/YYWebImage.h>
#import "JYCWindow.h"
#import "LolUserInfoModel.h"
#import "OneStepBookViewController.h"
#import "FWDController.h"
#import "OrderBillViewController.h"
#import "ApproveDetailController.h"
#import "MzzGenjinViewController.h"
#import "BookDetailsViewController.h"
#import "LolSkipToDetailMode.h"
#import "SaleServiceViewController.h"
#import "organizationalStructureView.h"
#import "BeautyChoiceJishi.h"
#import "UpdateRequest.h"

#import "WorkTbHeader.h"
#import "LTabBarView.h"
#import "LTabTwoView.h"
#import "WorkCommonCell.h"
#import "WorkCommonCell1.h"
#import "WorkCommonCell2.h"
#import "WorkCommonCell3.h"
#import "WorkTbDgHeader.h"
#import "LTabThreeView.h"
#import "WorkTopView.h"
#import "WorkCommonManagerCell.h"
#import "MzzWordManagerModel.h"
#import "WHScrollAndPageView.h"
#import "WorkGreetListModel.h"
#import "GuangGaoVC.h"
#import "LLWPlusPopView.h"
#import "RolesTools.h"
#import "ApproveRequest.h"
#import "OrderSaleViewController.h"
#import "LClearCardController.h"
#import "ChoiseCustomerViewController.h"
#import "MzzBillReviseController.h"
#import "LMemberFreezeViewController.h"
#import "LClearCardController.h"
#import "MzzTDViewController.h"
#import "MzzInsertCustomerController.h"
#import "BookFastVC.h"
#import "BookParamModel.h"
#import "SuggestViewController.h"
#import "OrderReverseViewController.h"

#import "GKGLAddCustomerVC.h"
#import "XMHRefreshGifHeader.h"


#import "XMHWorkToolView.h"
#import "XMHSalesOrderVC.h"
#import "XMHServiceOrderVC.h"
#import "BookFastVC.h"
#import "GKGLAddCustomerVC.h"
#import "ApproveController.h"
#import "BeautyCustomersVC.h"
#pragma mark ------- 判断展示页面-------
//1管理层、3店经理、4技术店长、5销售店长、6售前店长、7前台、8售后美容师、9售前美容师、10售中美容师、11导购


typedef NS_ENUM(NSUInteger, WorkTabClass){
    WorkTabClassJinRi,        //今日
    WorkTabClassDaiYuYue,     // 待预约
    WorkTabClassDaiShenPi,    //待审批
    WorkTabClassDaiFuWu,      //待服务
    WorkTabClassDaiGenJin,    //待跟进
};
typedef NS_ENUM(NSUInteger, WorkTabTwoClass){
    WorkTabTwoClassFuWuNeiRong,
    WorkTabTwoClassXiaoShouNeiRong,
    WorkTabTwoClassShouQianGenJin,
    WorkTabTwoClassKaiFaGuanKong,
    WorkTabTwoClassKeQingWeiHu
};

#define kCommonCellHeight 86
#define kCommonCell1Height 140
#define kCommonCell2Height 135
#define kCommonCell3Height 86
#define kCommonManagerCellHeight 175
#define NUM 3

@interface WorkViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,WHcrollViewViewDelegate>{
    
    __block UITableView *_tbWork;
    __block workBtnChoiceType _choiceType;
    __block secondChoiceType _secondChoiceType;
    __block ThirdChoiceType  _thirdChoiceType;
    
//    customNav *nav;
    //判断是不是导购 UI展示不同
//    BOOL _isDaoGou;
    //判断是否点击头部视图更多按钮
//    BOOL _selectMore;
    UIButton *suspensionBtn;
}
/** <##> */
@property (nonatomic) BOOL selectMore;
@property (nonatomic) BOOL isDaoGou;

@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString * joinCode;
@property (nonatomic, strong) NSString * framId;
@property (nonatomic, strong) NSString * functionId;
@property (nonatomic, strong) WorkModel * workModel;
@property (nonatomic, strong) workHome * workHome;
@property (nonatomic, strong) customNav *nav;
@property (nonatomic, strong) BeautyChoiceJishi    *beautyChoiceJishi;
@property (nonatomic) NSInteger allPage;
@property (nonatomic) BOOL touchLeft;
@property (nonatomic) BOOL isFisrt;
@property (nonatomic, strong) WHScrollAndPageView *whView;
@property (nonatomic, strong) WorkGreetListModel *greetListModel;
//标识加载更多
@property (nonatomic) BOOL isMore;
@property (nonatomic, strong) WorkChoiceView *workChoiceview;
@property (nonatomic, strong) NSArray * tabTitles;
@property (nonatomic, strong) NSDictionary * tabTwoTitleDic;
@property (nonatomic) BOOL isHaveTwoClass;
@property (nonatomic, copy) NSString * tabTitle;
@property (nonatomic, strong) UIView * coverWindow;

//model
@property (nonatomic ,strong)MzzDaiYuYueModel *daiyuyueModel;
@property (nonatomic ,strong)MzzDaiShenPiModel *daishenpiModel;
@property (nonatomic ,strong)MzzDaiFuWuModel *daifuwuModel;
@property (nonatomic ,strong)MzzDaiGenJinModel *daigenjinModel;
@property (nonatomic ,strong)MzzWorkListModel *worklistModel;
@property (nonatomic ,strong)MzzWordManagerModel *workDayModel;//今日，本月，本季度
@property (nonatomic ,strong)NSMutableArray *workDayArray;

@property (nonatomic, strong)UITableView * tbWorkView;

@property (nonatomic, strong)WorkTbHeader * tbHeader;
@property (nonatomic, strong)WorkTbHeader * tbtouchHeader;

@property (nonatomic, strong)LTabBarView * tabbarView;

@property (nonatomic, assign)WorkTabClass workTabClass;
@property (nonatomic, assign)WorkTabTwoClass workTabTwoClass;
@property (nonatomic, strong)LTabTwoView * tabbarTwoView;
@property (nonatomic, strong)LTabThreeView * tabbarThreeView;

@property (nonatomic, strong)WorkTbDgHeader * tbDgHeader;

@property(nonatomic,strong)NSString *chooseStr; //选择的排序名称

@property(nonatomic,strong)NSString *type;//点击升降续
@property(nonatomic,strong)UIView *sectionView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@property (nonatomic, strong)LLWPlusPopView * pushPopView;
@end

@implementation WorkViewController
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MzzLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _workDayArray = [[NSMutableArray alloc]init];
    _allPage = 1;
    _isMore = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClickWorkBTN) name:@"Work_AddBtnClick" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TapWork) name:@"TapWork" object:nil];
    [self initBaseData];
    [self requestTableHeaderData];
    [self initSubViewsNew];
    [self suspensionButton];
    [self requestGuangGaoData];
}

/**
 悬浮按钮
 */
-(void)suspensionButton
{
    suspensionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    suspensionBtn.frame = CGRectMake(SCREEN_WIDTH-76, SCREEN_HEIGHT-200, 46, 46);
    [suspensionBtn setBackgroundImage:[UIImage imageNamed:@"yijianfankui"] forState:UIControlStateNormal];
    [suspensionBtn addTarget:self action:@selector(suspensionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tbWorkView addSubview:suspensionBtn];
    [self.tbWorkView bringSubviewToFront:suspensionBtn];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    suspensionBtn.frame = CGRectMake(SCREEN_WIDTH-76, SCREEN_HEIGHT-200 +
                                     self.tbWorkView.contentOffset.y, 46, 46);
    [self.tbWorkView bringSubviewToFront:suspensionBtn];
    
}
-(void)suspensionButtonAction
{
    SuggestViewController * next = [[SuggestViewController alloc] init];
    [self.navigationController pushViewController:next animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_workDayArray removeAllObjects];
    [self refreshPageAllData];
}
- (void)requestGuangGaoData
{
    NSMutableArray *tempAry = [NSMutableArray array];
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [WorkRequest requestWorkGuangGaoParams:param resultBlock:^(WorkGreetListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _greetListModel = model;
            if (model.list.count == 0) {
                
                
                
            }else{
                for (int i= 0; i<model.list.count; i++) {
                    UIImageView *imageView = [[UIImageView alloc] init];
                    WorkGreetModel * greetModel = model.list[i];
                    [imageView yy_setImageWithURL:URLSTR(greetModel.pic) placeholder:nil];
                    [tempAry addObject:imageView];
                }
//                [_whView setImageViewAry:tempAry];
                _whView = [[WHScrollAndPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//                _whView.backgroundColor = [UIColor cyanColor];
                [_whView setImageViewAry:tempAry];
                //把图片展示的view加到当前页面
                UIWindow * window = [UIApplication sharedApplication].keyWindow;
                [window addSubview:_whView];
                
                //开启自动翻页
                [_whView shouldAutoShow:NO];
                
                //遵守协议
                _whView.delegate = self;
            }
        }
    }];
}
#pragma mark 协议里面方法，点击某一页
-(void)didClickPage:(WHScrollAndPageView *)view atIndex:(NSInteger)index
{
    _whView.hidden = YES;
    NSLog(@"点击了第%ld页",index);
    WorkGreetModel * greetModel = _greetListModel.list[index-1];
    GuangGaoVC * guangGaoVC = [[GuangGaoVC alloc] init];
       guangGaoVC.model = greetModel;
    if (greetModel.url.length > 0 && !([greetModel.url isEqualToString:@"http://www.baidu.com"])) {
        [self presentViewController:guangGaoVC animated:NO completion:nil];
    }
}
- (void)didClickCancel
{
    _whView.hidden = YES;
}
#pragma mark 界面消失的时候，停止自动滚动
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_whView shouldAutoShow:NO];
}

#pragma mark    ------UI------
- (void)initSubViewsNew
{
    WeakSelf
    //Nav
    LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
    Join_Code * info = model.data.join_code[0];
    [self.navView setNavViewTitle:info.name titleImage:@"pinpai_xiala"];
    //导航栏左按钮
    self.navView.NavViewBlock = ^{
        [weakSelf btnLetEvent];
        [weakSelf TapWork];
    };
    
    //TableView
    [self.view addSubview:self.tbWorkView];
    _tabTwoTitleDic = @{@"待服务":@[@"服务内容",@"销售内容"],@"待跟进":@[@"售前跟进",@"开发管控",@"客情维护"]};
}

//初始化tableView
- (UITableView *)tbWorkView
{
    WeakSelf
    if (!_tbWorkView) {
        _tbWorkView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,Heigh_View) style:UITableViewStylePlain];
        _tbWorkView.delegate = self;
        _tbWorkView.dataSource = self;
        _tbWorkView.backgroundColor = [UIColor clearColor];
        _tbWorkView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbWorkView.tableFooterView = [UIView new];
        _tbWorkView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            if (!_isDaoGou) {
//                [weakSelf refreshPageAllData];
//            }else{
//                [weakSelf endRefreshing];
//            }
//        }];
        _tbWorkView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!weakSelf.isDaoGou) {
                [weakSelf requestMoreNetData];
            }
        }];
    }
    return _tbWorkView;
}
- (XMHRefreshGifHeader *)gifHeader {
    WeakSelf
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            if (!weakSelf.isDaoGou) {
                [weakSelf refreshPageAllData];
            }else{
                [weakSelf endRefreshing];
            }
        }];
    }
    return _gifHeader;
}

-(UIView *)sectionView
{
    if (!_sectionView) {
        _sectionView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    }
    return _sectionView;
}
#pragma mark ---------初始化一级tab---------
- (LTabBarView *)tabbarView
{
    WeakSelf
    if (!_tabbarView) {
        _tabbarView = [[LTabBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _tabbarView.tag = 10010;
        _tabbarView.TabBarViewBlock = ^(NSString *title) {
            if ([title isEqualToString:@"待服务"]||[title isEqualToString:@"待跟进"]) {
                weakSelf.isHaveTwoClass = YES;
                weakSelf.tabTitle = title;
            }else if ([title isEqualToString:@"今日"]||[title isEqualToString:@"本月"]||[title isEqualToString:@"本季度"]){
                weakSelf.isHaveTwoClass = YES;
                weakSelf.tabTitle = title;
                weakSelf.chooseStr = @"按业绩排序";
                weakSelf.type = @"1";
                weakSelf.allPage = 1;
                weakSelf.isMore = NO;
            }
            else{
                weakSelf.isHaveTwoClass = NO;
            }
            [weakSelf convertStringToClass:title];
            //            [weakSelf.tbWorkView reloadData];
        };
        [_tabbarView updateTabBarViewTitles:_tabTitles];
        
    }
    return _tabbarView;
}
#pragma mark -------初始化二级tab-------
- (LTabTwoView *)tabbarTwoView
{
    WeakSelf
    if (!_tabbarTwoView) {
        _tabbarTwoView = [[LTabTwoView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 44)];
        _tabbarTwoView.TabTwoViewBlock = ^(NSString *title) {
            [weakSelf convertStringToClass:title];
        };
    }
    return _tabbarTwoView;
}
#pragma mark -------初始化管理层、店长二级tab-------
-(LTabThreeView *)tabbarThreeView
{
    if (!_tabbarThreeView) {
        WeakSelf
        _tabbarThreeView =[[LTabThreeView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 44)];
        //选择排序
        _tabbarThreeView.btnChoose = ^{
            [weakSelf creatTopChooseView];
            [weakSelf.beautyChoiceJishi refreshWorkChoose];
            weakSelf.beautyChoiceJishi.chooseBlock = ^(NSString *choose) {
                weakSelf.chooseStr = choose;
                [weakSelf convertStringToClass:weakSelf.tabTitle];
            };
        };
        //点击最高
        _tabbarThreeView.btnGaoButton = ^{
            weakSelf.type = @"1";
            weakSelf.allPage = 1;
            weakSelf.isMore = NO;
            [weakSelf requestDayData];
        };
        //点击最低
        _tabbarThreeView.btnDiButton = ^{
            weakSelf.type = @"2";
            weakSelf.allPage = 1;
            weakSelf.isMore = NO;
            [weakSelf requestDayData];
        };
    }
    return _tabbarThreeView;
}

#pragma mark -------tab字符串转枚举斌请求数据------------
- (void)convertStringToClass:(NSString *)string
{
    if ([string isEqualToString:@"待预约"]) {
        _workTabClass = WorkTabClassDaiYuYue;
        [self requestDaiYuYueData];
    }else if([string isEqualToString:@"待审批"]){
        [self requestDaiShenPiData];
        _workTabClass = WorkTabClassDaiShenPi;
    }else if([string isEqualToString:@"待服务"]){
        [self.tabbarTwoView updateTabTwoViewTitles:_tabTwoTitleDic[_tabTitle]];
        [self requestDaiFuWuData];
        _workTabClass = WorkTabClassDaiFuWu;
        _workTabTwoClass = WorkTabTwoClassFuWuNeiRong;
    }else if([string isEqualToString:@"待跟进"]){
        [self.tabbarTwoView updateTabTwoViewTitles:_tabTwoTitleDic[_tabTitle]];
        [self requestDaiGenJinData];
        _workTabClass = WorkTabClassDaiGenJin;
        _workTabTwoClass = WorkTabTwoClassShouQianGenJin;
    }else if([string isEqualToString:@"售前跟进"]){
        [self requestDaiGenJinData];
        _workTabTwoClass = WorkTabTwoClassShouQianGenJin;
    }else if([string isEqualToString:@"开发管控"]){
        [self requestDaiGenJinData];
        _workTabTwoClass = WorkTabTwoClassKaiFaGuanKong;
    }else if([string isEqualToString:@"客情维护"]){
        [self requestDaiGenJinData];
        _workTabTwoClass = WorkTabTwoClassKeQingWeiHu;
    }else if([string isEqualToString:@"服务内容"]){
        [self requestDaiFuWuData];
        _workTabTwoClass = WorkTabTwoClassFuWuNeiRong;
    }else if([string isEqualToString:@"销售内容"]){
        [self requestDaiFuWuData];
        _workTabTwoClass = WorkTabTwoClassXiaoShouNeiRong;
    }else if ([string isEqualToString:@"今日"]||[string isEqualToString:@"本月"]||[string isEqualToString:@"本季度"]){
        [self.tabbarThreeView updateTabThreeViewTitles:_chooseStr withType:_type];
        _workTabClass = WorkTabClassJinRi;
        [self requestDayData];
    }else{
    }
}
#pragma mark --------初始化tableViewHeader--------
- (WorkTbHeader *)tbHeader
{
    if (!_tbHeader) {
        if ([_workModel.role isEqualToString:@"7"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170) withType:7 andHeadArray:_workModel.data];
        }else if ([_workModel.role isEqualToString:@"1"]||[_workModel.role isEqualToString:@"3"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325) withType:[_workModel.role integerValue] andHeadArray:_workModel.data];
        }else if ([_workModel.role isEqualToString:@"4"]||[_workModel.role isEqualToString:@"6"]||[_workModel.role isEqualToString:@"10"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) withType:[_workModel.role integerValue] andHeadArray:_workModel.data];
        }else if ([_workModel.role isEqualToString:@"5"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400) withType:5 andHeadArray:_workModel.data];
        }else if ([_workModel.role isEqualToString:@"8"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325) withType:8 andHeadArray:_workModel.data];
        }else if ([_workModel.role isEqualToString:@"10"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325) withType:10 andHeadArray:_workModel.data];
        }else if ([_workModel.role isEqualToString:@"9"]||[_workModel.role isEqualToString:@"2"]){
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320) withType:[_workModel.role integerValue] andHeadArray:_workModel.data];
        }else{
            //导购
            _tbHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320) withType:11 andHeadArray:_workModel.data];
        }
        //点击更多按钮
        __weak WorkViewController *weakSelf = self;
        __block BOOL  blockSelf = _isDaoGou;
        self.tbHeader.btnMoreButton = ^(BOOL select) {
            weakSelf.selectMore = select;
            [weakSelf refreshTableHeaderView];
            if (!blockSelf) {
                [weakSelf.tbWorkView reloadData];
            }else{
                [weakSelf endRefreshing];
            }
        };
    }
    return _tbHeader;
}
-(void)touchHeader
{
    if ([_workModel.role isEqualToString:@"7"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170) withType:7 andHeadArray:_workModel.data];
    }else if ([_workModel.role isEqualToString:@"1"]||[_workModel.role isEqualToString:@"3"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325) withType:[_workModel.role integerValue] andHeadArray:_workModel.data];
    }else if ([_workModel.role isEqualToString:@"4"]||[_workModel.role isEqualToString:@"6"]||[_workModel.role isEqualToString:@"10"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) withType:[_workModel.role integerValue] andHeadArray:_workModel.data];
    }else if ([_workModel.role isEqualToString:@"5"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400) withType:5 andHeadArray:_workModel.data];
    }else if ([_workModel.role isEqualToString:@"8"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325) withType:8 andHeadArray:_workModel.data];
    }else if ([_workModel.role isEqualToString:@"10"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325) withType:10 andHeadArray:_workModel.data];
    }else if ([_workModel.role isEqualToString:@"9"]||[_workModel.role isEqualToString:@"2"]){
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320) withType:[_workModel.role integerValue] andHeadArray:_workModel.data];
    }else{
        //导购
        _tbtouchHeader = [[WorkTbHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320) withType:11 andHeadArray:_workModel.data];
    }
    //点击更多按钮
    __weak WorkViewController *weakSelf = self;
    __block BOOL  blockSelf = _isDaoGou;
    self.tbtouchHeader.btnMoreButton = ^(BOOL select) {
        weakSelf.selectMore = select;
        [weakSelf tableViewHeardHight];
        if (!blockSelf) {
            [weakSelf.tbWorkView reloadData];
        }else{
            [weakSelf endRefreshing];
        }
    };
}
#pragma mark ---------刷新头部数据--------
- (void)refreshTableHeaderView
{
    if (_touchLeft) {
        [self touchHeader];
        _selectMore = NO;
        _tbWorkView.tableHeaderView = self.tbtouchHeader;
    }else{
        _tbWorkView.tableHeaderView = self.tbHeader;
    }
    [self.tbHeader updateView:[_workModel.role integerValue] withModel:_workModel.data withSelect:_selectMore];
    [self tableViewHeardHight];
    [self.tbWorkView reloadData];
    
}
//默认高度
-(void)tableViewHeardHight
{
    if ([_workModel.role isEqualToString:@"7"]){
        if (_selectMore) {
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 170+120);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 170+120);
            }
        }else{
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 170);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 170);
            }
        }
    }else if ([_workModel.role isEqualToString:@"1"]||[_workModel.role isEqualToString:@"3"]){
        if (_selectMore) {
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325+120);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325+120);
            }
        }else{
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325);
            }
        }
        
    }else if ([_workModel.role isEqualToString:@"4"]||[_workModel.role isEqualToString:@"10"]||[_workModel.role isEqualToString:@"6"]){
        if (_selectMore) {
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250+120);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250+120);
            }
        }else{
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
            }
        }
    }else if ([_workModel.role isEqualToString:@"5"])
    {
        if (_selectMore) {
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400+120);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400+120);
            }
        }else{
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
            }
        }
    }else if ([_workModel.role isEqualToString:@"8"]){
        if (_selectMore) {
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325+120);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325+120);
            }
        }else{
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 325);
            }
        }
    }else if ([_workModel.role isEqualToString:@"9"]||[_workModel.role isEqualToString:@"2"]){
        if (_selectMore) {
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320+120);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320+120);
            }
        }else{
            if (_touchLeft) {
                self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320);
            }else{
                self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320);
            }
        }
    }else{
        //导购
        if (_touchLeft) {
            self.tbtouchHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }else{
            self.tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
    }
    suspensionBtn.frame = CGRectMake(SCREEN_WIDTH-76, SCREEN_HEIGHT-200 +
                                     self.tbWorkView.contentOffset.y, 46, 46);
    [self.tbWorkView bringSubviewToFront:suspensionBtn];
}

- (void)creatTopChooseView{
    if (!_beautyChoiceJishi) {
        _beautyChoiceJishi = [[[NSBundle mainBundle]loadNibNamed:@"BeautyChoiceJishi" owner:nil options:nil] firstObject];
        _beautyChoiceJishi.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_beautyChoiceJishi];
    }else{
        _beautyChoiceJishi.hidden = !_beautyChoiceJishi.hidden;
    }
}
#pragma mark ---------点击导航栏左按钮----------
- (void)btnLetEvent{
    [self creatTopChooseView];
    [_beautyChoiceJishi refreshWorkChoicePinPai];
    WeakSelf;
    _beautyChoiceJishi.workChoicePinPaiViewBlock = ^(NSString *pinPaiStr) {
        [weakSelf.navView setNavViewTitle:pinPaiStr titleImage:@"huigongzuo_qiehuanmendian"];
        if (pinPaiStr) {
            [UserManager setObjectUserDefaults:pinPaiStr key:@"pinPaiStrkey"];
            //选择的时候存上
            NSString *_pinpaistr = [UserManager getObjectUserDefaults:@"pinPaiStrkey"];
            LolUserInfoModel *model = [UserManager getObjectUserDefaults:userLogInInfo];
            
            [weakSelf initOrganizeMethod];
            for (Join_Code *join_code in model.data.join_code) {
                if ([join_code.name isEqualToString:_pinpaistr]) {
                    weakSelf.touchLeft = YES;
                    [weakSelf.tbHeader removeFromSuperview];
                    [weakSelf.tbtouchHeader removeFromSuperview];
                    [ShareWorkInstance shareInstance].share_join_code = join_code;
                    [ShareWorkInstance shareInstance].join_code = join_code.code;
                    [ShareWorkInstance shareInstance].fram_id = join_code.fram_id;
                    break;
                }
            }
            if (![ShareWorkInstance shareInstance].share_join_code) {
                Join_Code *join_code = model.data.join_code[0];
                [ShareWorkInstance shareInstance].share_join_code = join_code;
                [ShareWorkInstance shareInstance].join_code = join_code.code;
                [ShareWorkInstance shareInstance].fram_id = join_code.fram_id;
            }
        }
        [weakSelf initBaseData];
        [weakSelf requestTableHeaderData];
    };
}
//刷新整个页面数据
- (void)refreshPageAllData
{
    _isMore = NO;
    _allPage = 1;
    [self requestTableHeaderData];
}
- (void)initOrganizeMethod{
    organizationalStructureView *_organizationHeader;
    _organizationHeader = [[organizationalStructureView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 49)];
    _organizationHeader.organizationalStructureViewBlock = ^(NSString *join_code, NSString *oneClick, NSString *twoClick, NSString *twoListId, NSString *inId,NSInteger level,NSInteger main_role,List*listInfo) {
    };
}

- (void)endRefreshing{
    [_tbWorkView.mj_header endRefreshing];
    [_tbWorkView.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark    ------UITableViewDelegate------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCommonCell = @"kCommonCell";
    static NSString *kCommonCell1 = @"kCommonCell1";
    static NSString *kCommonCell2 = @"kCommonCell2";
    static NSString *kCommonCell3 = @"kCommonCell3";
    static NSString *kCommonCell4 = @"kCommonCell4";
    
    switch (_workTabClass) {
        case WorkTabClassJinRi:{
            WorkCommonManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell4];
            if (!cell)
            {
                cell = loadNibName(@"WorkCommonManagerCell");
            }
            [cell updateWorkCommonCellDataModel:[_workDayArray objectAtIndex:indexPath.row] andChooseStr:_chooseStr];
            return cell;
        }
        case WorkTabClassDaiYuYue:{
            WorkCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell];
            if (!cell)
            {
                cell = loadNibName(@"WorkCommonCell");
            }
            MzzDaiYuYue *daiyuyue =[_daiyuyueModel.data objectAtIndex:indexPath.row];
            [cell updateWorkCommonCellDyyModel:daiyuyue];
            return cell;
        }
        case WorkTabClassDaiShenPi:{
            
            WorkCommonCell1 *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell1];
            if (!cell)
            {
                cell = loadNibName(@"WorkCommonCell1");
            }
            MzzDaiShenPi *daishenpi = [_daishenpiModel.data objectAtIndex:indexPath.row];
            [cell updateWorkCommonCellDspModel:daishenpi];
            return cell;
        }
        case WorkTabClassDaiFuWu:{
            WorkCommonCell2 *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell2];
            if (!cell)
            {
                cell = loadNibName(@"WorkCommonCell2");
            }
            switch (_workTabTwoClass) {
                    
                case WorkTabTwoClassFuWuNeiRong:{
                    MzzFwnr *fwnr = [_daifuwuModel.data.fwnr objectAtIndex:indexPath.row];
                    [cell updateWorkCommonCellFwnrModel:fwnr];
                    return cell;
                }
                case WorkTabTwoClassXiaoShouNeiRong:{
                    MzzXsnr *xsnr = [_daifuwuModel.data.xsnr objectAtIndex:indexPath.row];
                    [cell updateWorkCommonCellXsnrModel:xsnr];
                    return cell;
                }
                default:
                    break;
            }
        }
            break;
        case WorkTabClassDaiGenJin:{
            
            switch (_workTabTwoClass) {
                case WorkTabTwoClassShouQianGenJin:{
                    WorkCommonCell3 *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell3];
                    if (!cell)
                    {
                        cell = loadNibName(@"WorkCommonCell3");
                    }
                    MzzSqgk *sqgk = [_daigenjinModel.data.sqgk objectAtIndex:indexPath.row];
                    [cell updateWorkCommonCellSqgjModel:sqgk];
                    return cell;
                }
                    break;
                case WorkTabTwoClassKaiFaGuanKong:{
                    WorkCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell];
                    if (!cell)
                    {
                        cell = loadNibName(@"WorkCommonCell");
                    }
                    MzzKfgk *kfgk =[_daigenjinModel.data.kfgk objectAtIndex:indexPath.row];
                    [cell updateWorkCommonCellKfgkModel:kfgk];
                    return cell;
                }
                    break;
                case WorkTabTwoClassKeQingWeiHu:{
                    WorkCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommonCell];
                    if (!cell)
                    {
                        cell = loadNibName(@"WorkCommonCell");
                    }
                    MzzKqwh *kqwh =[_daigenjinModel.data.kqwh objectAtIndex:indexPath.row];
                    [cell updateWorkCommonCellKqwhModel:kqwh];
                    return cell;
                }
                    break;;
                    
                default:
                    break;
            }
        }
            break;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_isDaoGou) {
        return UIView.new;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, self.sectionView.height + 113)];
    headerView.backgroundColor = kColorF5F5F5;;
    NSInteger role = [_workModel.role integerValue];
    
    if (_isHaveTwoClass) {
        self.tabbarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [self.sectionView addSubview:self.tabbarView];
        
        if ([_tabTitle isEqualToString:@"待服务"]||[_tabTitle isEqualToString:@"待跟进"]) {
            [self.sectionView addSubview:self.tabbarTwoView];
        }else if([_tabTitle isEqualToString:@"今日"]||[_tabTitle isEqualToString:@"本月"]||[_tabTitle isEqualToString:@"本季度"]){
            [self.sectionView addSubview:self.tabbarThreeView];
        }
        
        headerView.height = self.sectionView.height + 113;
        [headerView addSubview:self.sectionView];
        self.sectionView.bottom = headerView.height;

    }else{
        headerView.height = self.tabbarView.height + 113;
        [headerView addSubview:self.tabbarView];
        self.tabbarView.bottom = headerView.height;
    }
    
    XMHWorkToolView *toolView = [[XMHWorkToolView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, 103)];
    toolView.role = role;
    [headerView addSubview:toolView];
    __weak typeof(self) _self = self;
    toolView.didSelectBlock = ^(XMHWorkToolViewItemModel * _Nonnull model) {
        __strong typeof(_self) self = _self;
        [self toolDidSelectClickModel:model];
    };
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (_isDaoGou) {
//        return 0;
//    }
//    if (_isHaveTwoClass) {
//        return 88;
//    }else{
//        return 44;
//    }
    CGFloat height = 0;
    if (_isDaoGou) {
        height = 0;
    }
    if (_isHaveTwoClass) {
        height = 88 + 113;
    }else{
        height = 44 + 113;
    }
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isDaoGou) {
        return 0;
    }
    switch (_workTabClass) {
        case WorkTabClassJinRi:{
            return _workDayArray.count;
        }
        case WorkTabClassDaiYuYue:{
            return _daiyuyueModel.data.count;
        }
        case WorkTabClassDaiShenPi:{
            return _daishenpiModel.data.count;
        }
        case WorkTabClassDaiFuWu:{
            switch (_workTabTwoClass) {
                case WorkTabTwoClassFuWuNeiRong:{
                    return _daifuwuModel.data.fwnr.count;
                }
                case WorkTabTwoClassXiaoShouNeiRong:{
                    return _daifuwuModel.data.xsnr.count;
                }
                default:
                    return 0;
            }
        }
        case WorkTabClassDaiGenJin:{
            switch (_workTabTwoClass) {
                case WorkTabTwoClassShouQianGenJin:{
                    return _daigenjinModel.data.sqgk.count;
                }
                case WorkTabTwoClassKaiFaGuanKong:{
                    return _daigenjinModel.data.kfgk.count;
                }
                case WorkTabTwoClassKeQingWeiHu:{
                    return _daigenjinModel.data.kqwh.count;
                }
                default:
                    return 0;
            }
        }
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isDaoGou) {
        return kCommonCell3Height;
    }
    switch (_workTabClass) {
        case WorkTabClassJinRi:{
            return kCommonManagerCellHeight;
        }
        case WorkTabClassDaiYuYue:{
            return kCommonCellHeight;
        }
        case WorkTabClassDaiShenPi:{
            return kCommonCell1Height;;
        }
        case WorkTabClassDaiFuWu:{
            return kCommonCell2Height;
        }
        case WorkTabClassDaiGenJin:{
            
            return kCommonCell3Height;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_workTabClass) {
        case WorkTabClassDaiYuYue:
        {
            MzzDaiYuYue *model = [_daiyuyueModel.data objectAtIndex:indexPath.row];
            //            OneStepBookViewController *vc = [[OneStepBookViewController alloc] init];
            //            vc.userId = [NSString stringWithFormat:@"%ld",model.user_id];
            //
            //            [self.navigationController pushViewController:vc animated:NO];
            
            BookFastVC * bookFastVC= [[BookFastVC alloc] init];
            BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"修改预约" type:@"xgyy" orderNum:nil userID:[NSString stringWithFormat:@"%ld",model.user_id]];
            bookFastVC.paramModel = paramModel;
            [self.navigationController pushViewController:bookFastVC animated:YES];
        }
            break;
        case WorkTabClassDaiShenPi:
        {
            MzzDaiShenPi *shenpimodel =[_daishenpiModel.data objectAtIndex:indexPath.row];
            
            LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
            ApproveDetailModel *model = [ApproveDetailModel new];
            model.token = infomodel.data.token;
            model.accountId =  [NSString stringWithFormat:@"%ld",infomodel.data.ID];
            model.join_code = [ShareWorkInstance shareInstance].join_code;
            model.code = shenpimodel.code;
            if (shenpimodel.next_person ==infomodel.data.ID) {
                model.from = @"-1";
            }else{
                if (shenpimodel.fq_id ==infomodel.data.ID) {
                    model.from = @"0";
                }else{
                    model.from = @"1";
                }
            }
            model.ordernum = shenpimodel.ordernum;
            NSString * navTitle = nil;
            NSString * urlStr = nil;
            BOOL isFromList = NO;
            if (shenpimodel.ptype == 1) { //会员冻结
                navTitle = @"会员冻结审批";
                urlStr = [NSString stringWithFormat:@"%@approval/dongjie.html",SERVER_H5];
            }else if (shenpimodel.ptype ==2){//会员调店
                navTitle = @"会员调店审批";
                urlStr = [NSString stringWithFormat:@"%@approval/tiaodian.html",SERVER_H5];
            }else if (shenpimodel.ptype ==3){ //顾客清卡
                navTitle = @"清卡审批";
                urlStr = [NSString stringWithFormat:@"%@approval/qingka.html",SERVER_H5];
            }else if (shenpimodel.ptype ==4){ //账单校正
                navTitle = @"账单校正审批";
                urlStr = [NSString stringWithFormat:@"%@approval/jiaozheng.html",SERVER_H5];
            }else if (shenpimodel.ptype ==5){//完善信息
                navTitle = @"完善信息";
                urlStr = [NSString stringWithFormat:@"%@approval/wanshan.html",SERVER_H5];
            }else if (shenpimodel.ptype ==6){//个性制单
                navTitle = @"个性制单";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }else if (shenpimodel.ptype ==7){//已购置换
                navTitle = @"已购置换";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }else if (shenpimodel.ptype ==8){//升卡续卡
                navTitle = @"升卡续卡";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }else if (shenpimodel.ptype ==9){ //添加顾客
                navTitle = @"添加顾客";
                urlStr = [NSString stringWithFormat:@""];
                return;
            }else{//奖赠审批
                navTitle = @"奖赠审批";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }
            model.urlstr =  urlStr;
            model.navTitle = navTitle;
            model.fromList = isFromList;
            ApproveDetailController *vc = [[ApproveDetailController alloc] init];
            [vc setDetailModel:model];
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case WorkTabClassDaiFuWu:
        {
            switch (_workTabTwoClass) {
                case WorkTabTwoClassFuWuNeiRong:
                {
                    MzzFwnr *model = [_daifuwuModel.data.fwnr objectAtIndex:indexPath.row];
                    SaleServiceViewController *vc = [[SaleServiceViewController alloc] init];
                    [vc setUser_id:model.user_id];
                    [vc setName:model.user_name];
                    [vc setMobile:model.user_mobile];
                    [vc setStore_code:model.store_code];
                    [vc setIsSale:NO];
                    [vc setBillType:1];
                    [self.navigationController pushViewController:vc animated:NO];
                }
                    break;
                case WorkTabTwoClassXiaoShouNeiRong:
                {
                    MzzXsnr *model = [_daifuwuModel.data.xsnr objectAtIndex:indexPath.row];
                    SaleServiceViewController *vc = [[SaleServiceViewController alloc] init];
                    [vc setUser_id:model.user_id];
                    [vc setName:model.user_name];
                    [vc setMobile:model.user_mobile];
                    [vc setStore_code:model.store_code];
                    [vc setIsSale:YES];
                    [vc setBillType:6];
                    [self.navigationController pushViewController:vc animated:NO];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case WorkTabClassDaiGenJin:
        {
            switch (_workTabTwoClass) {
                case WorkTabTwoClassShouQianGenJin:
                {
                    MzzSqgk *model = [_daigenjinModel.data.sqgk objectAtIndex:indexPath.row];
                    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.mobile];
                    UIWebView * callWebview = [[UIWebView alloc] init];
                    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                    [self.view addSubview:callWebview];
                }
                    break;
                case WorkTabTwoClassKaiFaGuanKong:
                {
//                    MzzKfgk *model = [_daigenjinModel.data.kfgk objectAtIndex:indexPath.row];
//                    MzzGenjinViewController *vc = [[MzzGenjinViewController alloc] init];
//                    [vc setJis:model.jis andUser_id:[NSString stringWithFormat:@"%ld",model.user_id] andUname:model.user_name andFromWork:YES];
//                    [self.navigationController pushViewController:vc animated:NO];
                }
                    break;
                case WorkTabTwoClassKeQingWeiHu:
                {
//                    MzzKqwh *model = [ _daigenjinModel.data.kqwh objectAtIndex:indexPath.row];
//                    MzzGenjinViewController *vc = [[MzzGenjinViewController alloc] init];
//                    [vc setJis:model.jis andUser_id:[NSString stringWithFormat:@"%ld",model.user_id] andUname:model.user_name andFromWork:YES];
//                    [self.navigationController pushViewController:vc animated:NO];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark ------初始化常规数据-------
- (void)initBaseData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _uid = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    _functionId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].function_id];
    _account = infomodel.data.account;
    if (_touchLeft) {
        _framId = [NSString stringWithFormat:@"%ld", [ShareWorkInstance shareInstance].fram_id];
        
    }else{
        _framId = [NSString stringWithFormat:@"%ld",infomodel.data.join_code[0].fram_id];
        [ShareWorkInstance shareInstance].join_code = [NSString stringWithFormat:@"%@",infomodel.data.join_code[0].code];
    }
    _joinCode = [ShareWorkInstance shareInstance].join_code;
    
}
#pragma mark -------请求先行接口数据---------
- (void)requestTableHeaderData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _account =  infomodel.data.account;
    _framId = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
    [WorkRequest requestWorkHeard:@"" framId:_framId account:_account resultBlock:^(WorkModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _workModel = model;
            if ([_workModel.role isEqualToString:@"11"]) {
                _isDaoGou = YES;
                _tbWorkView.scrollEnabled = NO;
                [_tbWorkView reloadData];
                
            }else if ([_workModel.role isEqualToString:@"1"]){
                _tabTitles = @[@"今日",@"本月",@"本季度"];
                _workTabClass = WorkTabClassJinRi;
                _isHaveTwoClass = YES;
                [_tabbarView updateTabBarViewTitles:_tabTitles];
                [self.tabbarThreeView updateTabThreeViewTitles:_chooseStr withType:_type];
                
            }else{
                _tabTitles = @[@"待预约",@"待审批",@"待服务",@"待跟进"];
                _workTabClass = WorkTabClassDaiYuYue;
                _isHaveTwoClass = YES;
                [_tabbarView updateTabBarViewTitles:_tabTitles];
            }
            [self refreshTableHeaderView];
        }
        
    }];
}
#pragma mark --------加载每日,每月，本季度的数据-------
-(void)requestDayData
{
    NSString * page = [NSString stringWithFormat:@"%ld",_allPage];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = _joinCode;
    params[@"fram_id"] = _framId;
    params[@"account"] = _account;
    if ([_tabTitle isEqualToString:@"今日"]) {
        [params setObject:@(1) forKey:@"state"];
    }else if ([_tabTitle isEqualToString:@"本月"]){
        [params setObject:@(2) forKey:@"state"];
    }else{
        [params setObject:@(3) forKey:@"state"];
    }
    if ([_chooseStr containsString:@"业绩"]) {
        [params setObject:@"ach" forKey:@"order"];
    }else if ([_chooseStr containsString:@"消耗"]){
        [params setObject:@"exp" forKey:@"order"];
    }else if ([_chooseStr containsString:@"预约"]){
        [params setObject:@"appo" forKey:@"order"];
    }else if ([_chooseStr containsString:@"引流"]){
        [params setObject:@"drai" forKey:@"order"];
    }else if ([_chooseStr containsString:@"客次"]){
        [params setObject:@"num" forKey:@"order"];
    }else if ([_chooseStr containsString:@"项目"]){
        [params setObject:@"pro" forKey:@"order"];
    }else if ([_chooseStr containsString:@"有效客"]){
        [params setObject:@"vali" forKey:@"order"];
    }else if ([_chooseStr containsString:@"客均项目"]){
        [params setObject:@"pro_p" forKey:@"order"];
    }else if ([_chooseStr containsString:@"客均消耗"]){
        [params setObject:@"exp_p" forKey:@"order"];
    }else if ([_chooseStr containsString:@"人均接待"]){
        [params setObject:@"admit" forKey:@"order"];
    }else{
        [params setObject:@"handl" forKey:@"order"];
    }
    [params setObject:_type?_type:@"" forKey:@"type"];
    [params setObject:page forKey:@"page"];
    [WorkRequest requestJinRiWithParams:params resultBlock:^(MzzWordManagerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [_tbWorkView.mj_header endRefreshing];
        [_tbWorkView.mj_footer endRefreshing];
        if (isSuccess) {
            if (model) {
                if (model.list >0) {
                    if (_isMore) {
                       [_workDayArray addObjectsFromArray:model.list];
                    }else{
                        [_workDayArray removeAllObjects];
                        [_workDayArray addObjectsFromArray:model.list];
                    }
                    if (model.list.count == 0) {
                        [_tbWorkView.mj_footer endRefreshingWithNoMoreData];
                    }
                    [_tbWorkView reloadData];
                }else{
                    [_tbWorkView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }
        
    }];
    
}
-(void)requestMoreNetData
{
    _allPage ++;
    [self requestDayData];
    _isMore = YES;
}
#pragma mark --------加载待预约数据----------
- (void)requestDaiYuYueData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = _joinCode;
    params[@"function_id"] =  _functionId;
    params[@"fram_id"] = _framId;
    params[@"id"] = _uid;
    params[@"account"] = _account;
    //    params[@"role"] = _workModel.role;
    [WorkRequest requestDaiYuYueWithParams:params resultBlock:^(MzzDaiYuYueModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _daiyuyueModel = model;
        [_tbWorkView reloadData];
        [self endRefreshing];
    }];
}
#pragma mark --------加载待审批数据----------
- (void)requestDaiShenPiData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = _joinCode;
    params[@"function_id"] =  _functionId;
    params[@"fram_id"] = _framId;
    params[@"id"] = _uid;
    params[@"account"] = _account;
    //    params[@"role"] = _workModel.role;
    [WorkRequest requestDaiShenPiWithParams:params resultBlock:^(MzzDaiShenPiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _daishenpiModel = model;
        [_tbWorkView reloadData];
        [self endRefreshing];
    }];
}
#pragma mark --------加载待服务数据----------
- (void)requestDaiFuWuData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = _joinCode;
    params[@"function_id"] =  _functionId;
    params[@"fram_id"] = _framId;
    params[@"id"] = _uid;
    params[@"account"] = _account;
    //    params[@"role"] = _workModel.role;
    [WorkRequest requestDaiFuWuWithParams:params resultBlock:^(MzzDaiFuWuModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _daifuwuModel = model;
        [_tbWorkView reloadData];
        [self endRefreshing];
    }];
}
#pragma mark --------加载待跟进数据----------
- (void)requestDaiGenJinData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = _joinCode;
    params[@"function_id"] =  _functionId;
    params[@"fram_id"] = _framId;
    params[@"id"] = _uid;
    params[@"account"] = _account;
    //    params[@"role"] = _workModel.role;
    [WorkRequest requestDaiGenJinWithParams:params resultBlock:^(MzzDaiGenJinModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _daigenjinModel = model;
        [_tbWorkView reloadData];
        [self endRefreshing];
    }];
}
- (void)ClickWorkBTN
{
    NSArray * images = @[@"kuaijierukou_meilidingzhi",@"kuaijierukou_huiyuandongjie",@"kuaijierukou_shenqingtuikuan",@"kuaijierukou_huiyuantiaodian",@"kuaijierukou_yijianyuyue",@"kuaijierukou_tianjiaguke"];
    NSArray * titles = @[@"美丽定制",@"会员冻结",@"申请退款",@"会员调店",@"一键预约",@"添加顾客"];//@"账单矫正"产品要求本期去掉 ,@"kuaijierukou_zhangdanjiaozheng"
    [LLWPlusPopView showWithImages:images titles:titles selectBlock:^(NSInteger index) {
        [self workPushNextVCIndex:index];
    }];
}
- (void)workPushNextVCIndex:(NSInteger)index
{
    
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    NSArray * role = [ShareWorkInstance shareInstance].share_join_code.framework_function_role;
    switch (index) {
        case 0:{//美丽定制
            if ([RolesTools workPushMLDZVC]) {
                BeautyCustomersVC *next = [[BeautyCustomersVC alloc] init];
                [self.navigationController pushViewController:next animated:NO];
            }else{
                [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
            }
        }
            break;
        case 1:{//账单矫正
            
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"4" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        MzzBillReviseController * next = [[MzzBillReviseController alloc] init];
                        [self.navigationController pushViewController:next animated:NO];
                    }else{
                        [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
                    }
                }
            }];
        }
            break;
        case 2:{//会员冻结
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"1" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        LMemberFreezeViewController * next = [[LMemberFreezeViewController alloc] init];
                        [self.navigationController pushViewController:next animated:NO];
                    }else{
                        [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
                    }
                }
            }];
        }
            break;
        case 3:{//申请退款
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"3" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        LClearCardController * next = [[LClearCardController alloc] init];
                        [self.navigationController pushViewController:next animated:NO];
                    }else{
                        [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
                    }
                }
            }];
        }
            
            break;
//        case 4:{//开服务单
//            if ([RolesTools workPushToKFWDVC]) {
//                OrderSaleViewController *next = [[OrderSaleViewController alloc]init];
//                next.isService = YES;
//                [self.navigationController pushViewController:next animated:NO];
//            }else{
//                //弹窗
//                [SVProgressHUD showErrorWithStatus:@"您没有制单权限，请进行其他操作"];
//            }
//        }
//
//            break;
//        case 5:{//开销售单
//            if ([RolesTools workPushToKFWDVC]) {
//                OrderSaleViewController *next = [[OrderSaleViewController alloc]init];
//                next.isService = NO;
//                [self.navigationController pushViewController:next animated:NO];
//            }else{
//                //弹窗
//                [SVProgressHUD showErrorWithStatus:@"您没有制单权限，请进行其他操作"];
//            }
//        }
//            break;
        case 4:{//会员调店
            [ApproveRequest requestPowerJoinCode:joinCode functionRole:role ptype:@"2" resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if ([NSString stringWithFormat:@"%@",model.data[@"is"]].intValue == 1) {
                        MzzTDViewController *next = [[MzzTDViewController alloc] init];
                        [self.navigationController pushViewController:next animated:NO];
                    }else{
                        [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
                    }
                }
            }];
        }
            break;
//        case 7:{//开单
//            if ([RolesTools orderReverseFlowPush]) {
//                OrderReverseViewController * nextVC = [[OrderReverseViewController alloc] init];
//                [self presentViewController:nextVC animated:NO completion:nil];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"您没有查看此功能权限"];
//            }
//        }
//            break;
        case 5:{//一键预约
            if ([RolesTools workPushToYJYYVC]) {
                BookFastVC *next = [[BookFastVC alloc]init];
                [self.navigationController pushViewController:next animated:NO];
            }else{
                //弹窗
                [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
            }
        }
            break;
        case 6:{//添加顾客
            if ([RolesTools workPushToTJGKVC]) {
//                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MzzInsertCustomerController" bundle:nil];
//                MzzInsertCustomerController *next = sb.instantiateInitialViewController;
                GKGLAddCustomerVC * next = [[GKGLAddCustomerVC alloc] init];
                [self.navigationController pushViewController:next animated:NO];
            }else{
                //弹窗
                [XMHProgressHUD showOnlyText:kNOTICE_WORK_MODULELIMIT_MSG];
            }
        }
            
            break;
        default:
            break;
    }
}
- (void)TapWork
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = _joinCode;
    [WorkRequest requestJoinStateParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (model.code == 1) {
            [_coverWindow removeFromSuperview];
        }
        if (model.code == 0) {
            [self createCoverWindow];
            [XMHProgressHUD showOnlyText:model.msg];
        }
    }];
}
- (void)createCoverWindow
{
    _coverWindow = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,SCREEN_HEIGHT)];
    _coverWindow.backgroundColor = kLabelText_Commen_Color_3;
    _coverWindow.alpha = 0.7;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_coverWindow];
}

/**
快速入口事件
 */
- (void)toolDidSelectClickModel:(XMHWorkToolViewItemModel *)model {
    switch (model.type) {
            // 销售制单
        case XMHWorkToolViewTypeSales:{
            XMHSalesOrderVC *vc = [[XMHSalesOrderVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            // 服务制单
        case XMHWorkToolViewTypeService:{
            XMHServiceOrderVC *vc = XMHServiceOrderVC.new;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            // 一键预约
        case XMHWorkToolViewTypeYuYue:{
            BookFastVC * fastVC = [[BookFastVC alloc] init];
            [self.navigationController pushViewController:fastVC animated:NO];
            break;
        }
            // 添加顾客 点击添加顾客进入添加顾客页
        case XMHWorkToolViewTypeAddUser:{
            GKGLAddCustomerVC * addCustomerVC = [[GKGLAddCustomerVC alloc] init];
            [self.navigationController pushViewController:addCustomerVC animated:NO];
            break;
        }
            // 审批应用
        case XMHWorkToolViewTypeShenPi:{
            ApproveController * nextVC = [[ApproveController alloc] init];
            [self.navigationController pushViewController:nextVC animated:NO];
            break;
        }
            // 会员调店
        case XMHWorkToolViewTypeTiaoDian:{
            MzzTDViewController *tdVc = [[MzzTDViewController alloc] init];
            [self.navigationController pushViewController:tdVc animated:NO];
            break;
        }
            // 快速收款 点击快速收款进入逆向开单页 也叫快速开单
        case XMHWorkToolViewTypeShouKuan:{
            if ([RolesTools orderReverseFlowPush]) {
                OrderReverseViewController *vc = [[OrderReverseViewController alloc]init];
                [self presentViewController:vc animated:YES completion:nil];
            }else{
                //弹窗
                [XMHProgressHUD showOnlyText:@"您没有制单权限，请进行其他操作"];
            }
            break;
        }
        default:
            break;
    }
}
@end
