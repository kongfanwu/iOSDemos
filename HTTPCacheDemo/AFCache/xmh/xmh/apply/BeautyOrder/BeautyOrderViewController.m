//
//  BeautyOrderViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyOrderViewController.h"
#import "LDatePickView.h"
#import "StateNumView.h"
#import "BeautyCell1.h"
#import "BeautyCell2.h"
#import "BeautyCell3.h"
#import "organizationalStructureView.h"
#import "ChoiseCustomerViewController.h"
#import "MzzTitleAndDetailView.h"
#import "BeautyRequest.h"
#import "BeautyGuihuaModel.h"
#import "BeautyShijiModel.h"
#import "BeautyHomeListModel.h"
#import "BeautyHomeDModel.h"
#import "BeautyHomeUModel.h"
#import "JasonSearchView.h"
#import "TheOneCustomerViewController.h"
#import "ShareWorkInstance.h"
#import "LolUserInfoModel.h"
#import "MJRefreshFooter.h"
#import "RolesTools.h"
#import "CommonHeaderView.h"
#import "CustomerTbHeader.h"
#import "DateSubViewModel.h"
#import "CommonSubmitView.h"
#import "BeautyAskViewController.h"
#import "XMHRefreshGifHeader.h"
@interface BeautyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tbView;
    UIView  *_totalHeaderView;//总头部
    organizationalStructureView *_organizationHeader;
    BeautyRequest *_guihuazhixingRequest;
    BeautyRequest *_shijizhixingRequest;
    BeautyRequest *_homeGetListRequest;
    UIButton * _selectBtn;
    UILabel * _lbColor;
    CGFloat _headerHeight;
    Join_Code *_join_code;
    NSMutableArray *_arrone;
    NSMutableArray *_arrtwo;
    BOOL    _selectone;
    BOOL    _selecttwo;
    JasonSearchView    *_searchView;
    NSString *_keyWords;
    
    //参数
    NSString *cjoin_code;
    Fram_List *fram_list1;
    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
    NSString *cstartTime;
    NSString *cendTime;
    UIButton *_tempBtn;
    //数据源
    NSMutableArray  *_sourceArr;

    NSInteger _modelType;
    
    __block UIButton *tempbtn;
    
    LDatePickView *_datePickView;
    
    NSInteger _page;
    
    NSString *tmpTwoClick;
    NSString *tmpTwoListId;
    
    NSInteger _firstNum;
    
    NSInteger _YuanGong;
    
    List*_OrgnaizelistInfo;
    
    UIView *_searchHeaderView;
    
    NSInteger _selectIndex;
    

}
@property (nonatomic ,strong)CustomerTbHeader * tbHeader;
@property (nonatomic ,strong)NSArray * leftarr;
@property (nonatomic ,strong)NSArray * rightarr;
@property (nonatomic, strong)CommonSubmitView * dingZhiChuFangView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation BeautyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WeakSelf
    _selectIndex = 100;
    _leftarr = [[NSArray alloc] init];
    _rightarr = [[NSArray alloc] init];
    _arrone = [[NSMutableArray alloc]init];
    _arrtwo = [[NSMutableArray alloc]init];
    _join_code = [ShareWorkInstance shareInstance].share_join_code;
    _sourceArr = [[NSMutableArray alloc]init];
    _firstNum = 0;
    //设置头部底图
    self.logoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
    self.logoView.image = UIImageName(@"stgkgl_ditu");
    
    //导航栏
    [self.navView setNavViewTitle:@"美丽定制" backBtnShow:YES rightBtnTitle:nil];
    
    
    //(组织架构 + 时间选择器 + 层级组合)View
    CommonHeaderView * commonView = [[CommonHeaderView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 100) module:@"MLDZ"];
    commonView.CommonHeaderViewBlock = ^(COrganizeModel *organizeModel,BOOL isShow) {
        if (!isShow) {
            _tbView.frame = CGRectMake(0, 60 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 60);
        }else{
            _tbView.frame = CGRectMake(0, 100 + Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav - 100);
        }
        cjoin_code = organizeModel.joinCode;
        coneClick = organizeModel.oneClick;
        ctwoClick = organizeModel.twoClick;
        ctwoListId = organizeModel.twoListId;
        cinId = organizeModel.inId;
        cstartTime = organizeModel.start;
        cendTime = organizeModel.end;
        _OrgnaizelistInfo = organizeModel.listInfo;
        
        if ([organizeModel.twoClick isEqualToString:@"-100"]) {
            TheOneCustomerViewController *vc = [[TheOneCustomerViewController alloc]init];
            vc.uid = organizeModel.listInfo.ID;
            vc.join_code =organizeModel.joinCode;
            [weakSelf.navigationController pushViewController:vc animated:NO];
        } else {
            
            if ([[ShareWorkInstance shareInstance].share_join_code.fram_id_level isEqualToString:@"-2"]) {
                if (_firstNum == 0) {
                    tmpTwoClick = @"all";
                    tmpTwoListId = @"-1";
                }else{
                    tmpTwoClick = ctwoClick;
                    tmpTwoListId = ctwoListId;
                }
                
            } else {
                tmpTwoClick = ctwoClick;
                tmpTwoListId = ctwoListId;
            }
            [weakSelf clickSwitch:_selectBtn];
        }
        
    };
    [self.view addSubview:commonView];
    
    [self initSubviews];
    
    
    if ([RolesTools beautyOrderShowBtnQuanxian]) {
        [self.view addSubview:self.dingZhiChuFangView];
        _tbView.frame = CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,Heigh_View_normal - 69);
    }else{
       
    }
    
    
    
    
//    [self creatNav];
//    [self initSubviews];
//    _guihuazhixingRequest = [[BeautyRequest alloc]init];
//    _shijizhixingRequest = [[BeautyRequest alloc]init];
//    [self requestTopData];
}

- (CommonSubmitView *)dingZhiChuFangView
{
    WeakSelf
    if (!_dingZhiChuFangView) {
        _dingZhiChuFangView = loadNibName(@"CommonSubmitView");
        _dingZhiChuFangView.frame = CGRectMake(0, SCREEN_HEIGHT - 69, SCREEN_WIDTH, 69);
        [_dingZhiChuFangView updateCommonSubmitViewTitle:@"定制处方"];
        _dingZhiChuFangView.CommonSubmitViewBlock = ^{
            ChoiseCustomerViewController *vc = [[ChoiseCustomerViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:NO];
        };
    }
    return _dingZhiChuFangView;
}
- (void)requestTopDataSJZX
{
     [_shijizhixingRequest requestBeautyShiJiZhiXing:cjoin_code oneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime resultBlock:^(BeautyShijiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
         DateSubViewModel * model1 = [DateSubViewModel createModelIconName:@"stgkgl_huiyuanbaoyou" textName:@"处方执行次数" textValue:[NSString stringWithFormat:@"%ld",model.cfzxcs] isShow:NO];
         DateSubViewModel * model2 = [DateSubViewModel createModelIconName:@"stgkgl_xiumian" textName:@"处方执行项目数" textValue:[NSString stringWithFormat:@"%ld",model.cfzxxms] isShow:NO];
         DateSubViewModel * model3 = [DateSubViewModel createModelIconName:@"stgkgl_liushi" textName:@"处方消耗金额" textValue:[NSString stringWithFormat:@"%ld",model.cfxhje] isShow:NO];
         DateSubViewModel * model4 = [DateSubViewModel createModelIconName:@"stgkgl_xinzeng" textName:@"处方接待人数" textValue:[NSString stringWithFormat:@"%ld",model.cfjdrs] isShow:NO];
         DateSubViewModel * model5 = [DateSubViewModel createModelIconName:@"stgkgl_daixuka" textName:@"规划内执行" textValue:[NSString stringWithFormat:@"%ld",model.ghnzx] isShow:NO];
         DateSubViewModel * model6 = [DateSubViewModel createModelIconName:@"stgkgl_biaozhuo" textName:@"规划内未执行" textValue:[NSString stringWithFormat:@"%ld",model.ghnwzx] isShow:NO];
         DateSubViewModel * model7 = [DateSubViewModel createModelIconName:@"stgkgl_daixuka" textName:@"规划外执行" textValue:[NSString stringWithFormat:@"%ld",model.ghwzx] isShow:NO];
         DateSubViewModel * model8 = [DateSubViewModel createModelIconName:@"stgkgl_biaozhuo" textName:@"未到店执行" textValue:[NSString stringWithFormat:@"%ld",model.wddwzx] isShow:NO];
         _rightarr = @[model1,model2,model3,model4,model5,model6,model7,model8];
         [_tbHeader updateCustomerTbHeaderModel:_rightarr];
     }];
}
- (void)requestTopDataGHTJ
{
     [_guihuazhixingRequest requestBeautyGuiHuaiZhiXing:cjoin_code oneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime resultBlock:^(BeautyGuihuaModel *model, BOOL isSuccess, NSDictionary *errorDic) {
         DateSubViewModel * model1 = [DateSubViewModel createModelIconName:@"stgkgl_huiyuanbaoyou" textName:@"规划总处方数" textValue:[NSString stringWithFormat:@"%ld",model.ghzcfs] isShow:NO];
         DateSubViewModel * model2 = [DateSubViewModel createModelIconName:@"stgkgl_xiumian" textName:@"规划总次数" textValue:[NSString stringWithFormat:@"%ld",model.ghzcs] isShow:NO];
         DateSubViewModel * model3 = [DateSubViewModel createModelIconName:@"stgkgl_liushi" textName:@"规划总金额" textValue:[NSString stringWithFormat:@"%.2f",model.ghzje] isShow:NO];
         DateSubViewModel * model4 = [DateSubViewModel createModelIconName:@"stgkgl_xinzeng" textName:@"规划总项目数" textValue:[NSString stringWithFormat:@"%ld",model.ghzxms] isShow:NO];
         DateSubViewModel * model5 = [DateSubViewModel createModelIconName:@"stgkgl_daixuka" textName:@"已开处方数" textValue:[NSString stringWithFormat:@"%ld",model.ykcfrs] isShow:NO];
         DateSubViewModel * model6 = [DateSubViewModel createModelIconName:@"stgkgl_biaozhuo" textName:@"未开处方数" textValue:[NSString stringWithFormat:@"%ld",model.wkcfrs] isShow:NO];
         _leftarr = @[model1,model2,model3,model4,model5,model6];
         [_tbHeader updateCustomerTbHeaderModel:_leftarr];
     }];
}
- (void)requestData:(UIButton *)btn{
    _guihuazhixingRequest = [[BeautyRequest alloc]init];
    _shijizhixingRequest = [[BeautyRequest alloc]init];
    _homeGetListRequest = [[BeautyRequest alloc]init];
    if (btn.tag == 0) {
//        if (![ctwoListId isEqualToString:@"-1"] ) {
        [_guihuazhixingRequest requestBeautyGuiHuaiZhiXing:cjoin_code oneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime resultBlock:^(BeautyGuihuaModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                for (NSInteger i = 0; i<_arrone.count; i++) {
                    MzzTitleAndDetailView *View = _arrone[i];
                    switch (i) {
                        case 0:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@个",@(model.ghzcfs)];
                            [View setTitle:@"规划总处方数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 1:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@次",@(model.ghzcs)];
                            [View setTitle:@"规划总次数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 2:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@个",@(model.ghzxms)];
                            [View setTitle:@"规划总项目数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 3:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@元",@(model.ghzje)];
                            [View setTitle:@"规划总金额" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 4:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.ykcfrs)];
                            [View setTitle:@"已开处方人数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 5:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.wkcfrs)];
                            [View setTitle:@"未开处方人数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }
            }
        }];
//        }
    }else{
//        if (![ctwoListId isEqualToString:@"-1"] ) {
        [_shijizhixingRequest requestBeautyShiJiZhiXing:cjoin_code oneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId startTime:cstartTime endTime:cendTime resultBlock:^(BeautyShijiModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                for (NSInteger i = 0; i<_arrtwo.count; i++) {
                    MzzTitleAndDetailView *View = _arrtwo[i];
                    switch (i) {
                        case 0:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@次",@(model.cfzxcs)];
                            [View setTitle:@"处方执行次数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 1:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@个",@(model.cfzxxms)];
                            [View setTitle:@"处方执行项目数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 2:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@元",@(model.cfxhje)];
                            [View setTitle:@"处方消耗金额" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 3:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.cfjdrs)];
                            [View setTitle:@"处方接待人数" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 4:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.ghnzx)];
                            [View setTitle:@"规划内执行" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 5:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.ghnwzx)];
                            [View setTitle:@"规划内未执行" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 6:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.ghwzx)];
                            [View setTitle:@"规划外执行" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                        case 7:
                        {
                            NSString *str = [NSString stringWithFormat:@"%@人",@(model.wddwzx)];
                            [View setTitle:@"未到店未执行" andDetail:str andClick:^(MzzTitleAndDetailView *view) {
                                
                            }];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }
            }
        }];
//        }
    }
    [ShareWorkInstance shareInstance].coneClick = coneClick;
    [ShareWorkInstance shareInstance].ctwoClick = ctwoClick;
    [ShareWorkInstance shareInstance].ctwoListId = ctwoListId;
    [ShareWorkInstance shareInstance].cinId = cinId;
    [self requestList];
}
- (void)requestList{
    //列表数据
    _page = 0;
    WeakSelf;
    __block UITableView *tmptbView = _tbView;
    [_homeGetListRequest requestBeautyHomeGetList:cjoin_code oneClick:coneClick twoClick:tmpTwoClick twoListId:tmpTwoListId inId:cinId startTime:cstartTime endTime:cendTime page:_page keyword:_keyWords resultBlock:^(BeautyHomeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _lbColor.hidden = NO;
        [self endRefreshing];
        [tmptbView.mj_footer endRefreshingWithNoMoreData];
        if (isSuccess) {
            _firstNum ++;
            _modelType = model.pType;
            _YuanGong = model.yuangong;
            if (model.pType == 0) {
                [_sourceArr removeAllObjects];
                [_sourceArr addObjectsFromArray:model.dList];
            } else if(model.pType == 1){
                [_sourceArr removeAllObjects];
                [_sourceArr addObjectsFromArray:model.uList];
            }
            
            //            if ([tmpTwoListId isEqualToString:@"-1"]) {
            [tmptbView reloadData];
            //            }else{
            //                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            //                [tmptbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            //            }
        }
        [weakSelf endRefreshing];
    }];
    [tmptbView.mj_footer resetNoMoreData];
}
- (void)loadMoareList{
    _page++;
    WeakSelf;
    __block UITableView *tmptbView = _tbView;
    [_homeGetListRequest requestBeautyHomeGetList:cjoin_code oneClick:coneClick twoClick:tmpTwoClick twoListId:tmpTwoListId inId:cinId startTime:cstartTime endTime:cendTime page:_page keyword:_keyWords resultBlock:^(BeautyHomeListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _modelType = model.pType;
            _YuanGong = model.yuangong;
            if (model.pType == 0) {
                if (model.dList.count) {
                    [_sourceArr addObjectsFromArray:model.dList];
//                    if ([tmpTwoListId isEqualToString:@"-1"]) {
                    
                        [tmptbView reloadData];
//                    }else{
//                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//                        [tmptbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//                    }
                } else {
                    _page--;
                    [tmptbView.mj_footer endRefreshingWithNoMoreData];
                }
            } else if(model.pType == 1){
                if (model.uList.count) {
                    [_sourceArr addObjectsFromArray:model.uList];
//                    if ([tmpTwoListId isEqualToString:@"-1"]) {
                        [tmptbView reloadData];
//                    }else{
//                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//                        [tmptbView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//                    }
                } else {
                    _page--;
                    [tmptbView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        }else{
            _page--;
        }
        [weakSelf endRefreshing];
    }];
}
- (void)creatNav{
    NSString *rightStr = nil;
    NSString *roleStr = [NSString stringWithFormat:@"%ld",_join_code.framework_function_main_role];
    NSArray * canRoleStrs = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    if ([canRoleStrs containsObject:roleStr]) {
        rightStr = @"定制处方";
    }
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"美丽定制" withleftImageStr:@"back" withRightStr:rightStr];
    if ([canRoleStrs containsObject:roleStr]) {
         [nav.btnRight addTarget:self action:@selector(dingzhichufang) forControlEvents:UIControlEventTouchUpInside];
    }
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)initSubviews{
    _totalHeaderView = [[UIView alloc]init];
    _totalHeaderView.backgroundColor = [UIColor whiteColor];
    WeakSelf;
//    _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, 44) dateBlock:^(NSString *start, NSString *end) {
//        cstartTime = start;
//        cendTime = end;
//    }];
//    [self.view addSubview:_datePickView];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 10)];
    line.backgroundColor = kBackgroundColor;
    [_totalHeaderView addSubview:line];
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, 44)];
    [_totalHeaderView addSubview:container];
    CGRect rect1=CGRectMake(SCREEN_WIDTH/2.0-17-80, 0, 80, 43);
    CGRect rect2=CGRectMake(SCREEN_WIDTH/2.0+17, 0, 80, 43);
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"规划统计" forState:UIControlStateNormal];
    btn1.frame = rect1;
    btn1.titleLabel.font = FONT_SIZE(15);
    [btn1 setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    [btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    btn1.tag = 0;
    _selectBtn = _tempBtn = btn1;
    
    [btn1 addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"实际执行" forState:UIControlStateNormal];
    btn2.frame = rect2;
    btn2.titleLabel.font = FONT_SIZE(15);
    [btn2 setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    [btn2 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    btn2.tag = 1;
    
    [btn2 addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:btn2];
    
    UILabel * lbColor = [[UILabel alloc] initWithFrame:CGRectMake(105, 42, 60, 2)];
    lbColor.backgroundColor = kBtn_Commen_Color;
    _lbColor = lbColor;
    _lbColor.hidden = YES;
    [container addSubview:lbColor];
    _headerHeight = 0.0;
    
    [_totalHeaderView addSubview:container];
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, _datePickView.bottom,SCREEN_WIDTH,SCREEN_HEIGHT -_datePickView.bottom) style:UITableViewStylePlain];
    _tbView.separatorColor = [UIColor clearColor];
    _tbView.backgroundColor = Color_NormalBG;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
    _tbView.tableHeaderView = _totalHeaderView;
    
    
    _tbView.mj_header = self.gifHeader;
//    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf clickSwitch:_tempBtn];
//    }];
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoareList];
    }];
}
- (XMHRefreshGifHeader *)gifHeader {
    WeakSelf
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [weakSelf clickSwitch:_tempBtn];
            });
        }];
    }
    return _gifHeader;
}
- (void)clickSwitch:(UIButton *)btn{
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    NSInteger count= 0;
    if (btn.tag == 0) {
        count = 6;
        if (_arrone.count) {
            [_arrone removeAllObjects];
        }
    }else{
        count = 8;
        if (_arrtwo.count) {
            [_arrtwo removeAllObjects];
        }
    }
    _lbColor.frame = CGRectMake(btn.left, btn.bottom, btn.width, 2);
    for (int i = 0; i<count; i++) {
        MzzTitleAndDetailView *View = [[MzzTitleAndDetailView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/(count/2) *(i%(count/2)),54 + 52.5 * (i/(count/2)), SCREEN_WIDTH/(count/2), 52.5)];
        View.backgroundColor = [UIColor whiteColor];
        _headerHeight = View.bottom;
        if (btn.tag == 0) {
            [_arrone addObject:View];
        } else {
            [_arrtwo addObject:View];
        }
        [_totalHeaderView addSubview:View];
    }
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _headerHeight, SCREEN_WIDTH, 10)];
    line2.backgroundColor = kBackgroundColor;
//    [_totalHeaderView addSubview:line2];
    _totalHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH,_headerHeight);//235-44
    if (cjoin_code) {
        [self requestData:btn];
    }
}
- (void)dingzhichufang{
    ChoiseCustomerViewController *vc = [[ChoiseCustomerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BeautyCell1indentifier = @"BeautyCell1indentifier";
    static NSString *BeautyCell2indentifier = @"BeautyCell2indentifier";
    static NSString *BeautyCell3indentifier = @"BeautyCell3indentifier";
    switch (indexPath.section) {
        case 0:
            {
                if ([tmpTwoListId isEqualToString:@"-1"]) {
                    return nil;
                } else {
                    BeautyCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:BeautyCell3indentifier];
                    if (!cell3)
                    {
                        cell3 = [[BeautyCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BeautyCell3indentifier];
                    }
                    if (coneClick) {
                        [cell3 refreshBeautyCell3:coneClick twoClick:tmpTwoClick twoListId:tmpTwoListId join_code:cjoin_code inId:cinId];
                        cell3.BeautyCell3Block = ^(BOOL isOK) {
                            if (isOK) {
//                                [_tbView.mj_footer resetNoMoreData];
                            }
                        };
                    }
                    return cell3;
                }
            }
            break;
            case 1:
        {
            if (_modelType == 0) {
                BeautyCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:BeautyCell1indentifier];
                if (!cell1)
                {
                    cell1 = [[[NSBundle mainBundle] loadNibNamed:@"BeautyCell1" owner:nil options:nil] lastObject];
                }
                if (indexPath.row<_sourceArr.count) {
                    BeautyHomeDModel *model = _sourceArr[indexPath.row];
                    [cell1 reloadBeautyCell1YuanGong:model];
                }
                return cell1;
            } else if(_modelType == 1){
                BeautyCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:BeautyCell2indentifier];
                if (!cell2)
                {
                    cell2 = [[[NSBundle mainBundle] loadNibNamed:@"BeautyCell2" owner:nil options:nil] lastObject];
                }
                if (indexPath.row<_sourceArr.count) {
                    BeautyHomeUModel *model = _sourceArr[indexPath.row];
                    [cell2 reFreshBeautyCell2:model];
                }
                return cell2;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    WeakSelf;
    switch (section) {
        case 0:
            {
//                __block UIButton *tempbtn = _selectBtn;
                if (!_organizationHeader) {
                    _organizationHeader = [[organizationalStructureView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 49)];
                }
                if (!_searchHeaderView) {
                    _searchHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
                    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
                    line2.backgroundColor = kBackgroundColor;
                    [_searchHeaderView addSubview:line2];
//                    [_searchHeaderView addSubview:_organizationHeader];
                }
                
                _organizationHeader.organizationalStructureViewBlock = ^(NSString *join_code, NSString *oneClick, NSString *twoClick, NSString *twoListId, NSString *inId,NSInteger level,NSInteger mainrole,List*listInfo) {
//                    cjoin_code = join_code;
//                    coneClick = oneClick;
//                    ctwoClick = twoClick;
//                    ctwoListId = twoListId;
//                    cinId = inId;
//                    _OrgnaizelistInfo = listInfo;
//
//                    if ([twoClick isEqualToString:@"-100"]) {
//                        TheOneCustomerViewController *vc = [[TheOneCustomerViewController alloc]init];
//                        vc.uid = listInfo.ID;
//                        vc.join_code =join_code;
//                        [weakSelf.navigationController pushViewController:vc animated:NO];
//                    } else {
//
//                        if ([[ShareWorkInstance shareInstance].share_join_code.fram_id_level isEqualToString:@"-2"]) {
//                            if (_firstNum == 0) {
//                                tmpTwoClick = @"all";
//                                tmpTwoListId = @"-1";
//                            }else{
//                                tmpTwoClick = ctwoClick;
//                                tmpTwoListId = ctwoListId;
//                            }
//
//                        } else {
//                            tmpTwoClick = ctwoClick;
//                            tmpTwoListId = ctwoListId;
//                        }
//                        [weakSelf clickSwitch:tempbtn];
//                    }
                };
                return _searchHeaderView;
            }
            break;
            case 1:
        {
            if (!_searchView) {
                _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
            }
            __block JasonSearchView    *tempsearchView = _searchView;
            _searchView.searchBar.btnRightBlock = ^{
                //搜索
                _keyWords = tempsearchView.searchBar.text;
                [weakSelf requestList];
            };
            _searchView.searchBar.btnleftBlock = ^{
                tempsearchView.searchBar.text = nil;
                _keyWords = nil;
                [weakSelf requestList];
            };
            if ([ShareWorkInstance shareInstance].share_join_code.fram_id == _OrgnaizelistInfo.fram_id || ![ctwoListId isEqualToString:@"-1"]) {
                return nil;
            } else {
                return _searchView;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            {
//                return 49+10;
                return 10;
            }
            break;
        case 1:
        {
            if ([ShareWorkInstance shareInstance].share_join_code.fram_id == _OrgnaizelistInfo.fram_id || ![ctwoListId isEqualToString:@"-1"]) {
                return 0;
            } else {
                return 49;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            if ([tmpTwoListId isEqualToString:@"-1"]) {
                return 0;
            }else{
               return 1;
            }
        }
            break;
        case 1:
            return _sourceArr.count;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            if ([tmpTwoListId isEqualToString:@"-1"]) {
                return 0;
            }else{
                return 615;
            }
        }
            break;
        case 1:
        {
            if (_modelType == 0) {
                return 163;
            } else {
                return 166;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
        {
            if (_modelType == 0) {
                if (indexPath.row<_sourceArr.count) {
                    BeautyHomeDModel *model = _sourceArr[indexPath.row];
                    ZuZhiChoiceModel *zuzhiModel = [[ZuZhiChoiceModel alloc]init];
                    zuzhiModel.name = model.name;
                    zuzhiModel.fram_id = model.fram_id;
                    zuzhiModel.fram_name_id = model.fram_name_id;
                    zuzhiModel.inId = model.inId;
                    [_organizationHeader freshorganizationalView:zuzhiModel];
                    Fram_List * info;
                    for (NSInteger i = 0; i<_join_code.fram_list.count; i++) {
                        Fram_List * tempinfo = _join_code.fram_list[i];
                        if (model.fram_name_id == tempinfo.fram_name_id) {
                            if (i+1 < _join_code.fram_list.count) {
                                Fram_List * newinfo = _join_code.fram_list[i+1];
                                info = newinfo;
                            }
                            break;
                        }
                    }
                    if (model.fram_name_id == _YuanGong) {
                        ctwoClick = @"all";
                        ctwoListId = @"-1";
                    } else {
                        ctwoClick = [NSString stringWithFormat:@"%@",@(model.fram_id)];//@"all";
                        ctwoListId = [NSString stringWithFormat:@"%@",@(model.fram_name_id)];//[NSString stringWithFormat:@"%@",@(info.fram_name_id)];
                    }
                    coneClick = [NSString stringWithFormat:@"%@",@(model.fram_id)];
                    cinId = model.inId;
                    
                    tmpTwoClick = ctwoClick;
                    tmpTwoListId = ctwoListId;
                    
                    /*
                    if ([[ShareWorkInstance shareInstance].share_join_code.fram_id_level isEqualToString:@"-2"]) {
                        tmpTwoClick = @"all";
                        tmpTwoListId = @"-1";
                    } else {
                        tmpTwoClick = ctwoClick;
                        tmpTwoListId = ctwoListId;
                    }
                    if ([model.yg isEqualToString:@"yuangong"]) {
                        tmpTwoClick = @"all";
                        tmpTwoListId = @"-1";
                    }
                     */
                    [self requestData:_selectBtn];
                }
            } else {
                if (indexPath.row<_sourceArr.count) {
                    BeautyHomeUModel *model = _sourceArr[indexPath.row];
                    TheOneCustomerViewController *vc = [[TheOneCustomerViewController alloc]init];
                    vc.from = 2;
                    vc.uid = [NSString stringWithFormat:@"%@",@(model.user_id)];
                    vc.join_code =cjoin_code;
                    [self.navigationController pushViewController:vc animated:NO];
                }
            }
        }
            break;
        default:
            break;
    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
