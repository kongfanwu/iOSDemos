//
//  TheOneCustomerViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TheOneCustomerViewController.h"
#import "CustomerDetailHeader.h"
#import "CustomerDetailCell.h"
#import "CustomerDetailCell1.h"
#import "TwoBtnChoiseSectionHeader.h"
#import "CustomerDetailCell2.h"
#import "BeautyAskViewController.h"
#import "BeautyRequest.h"
#import "ZhangDanMingXiModel.h"
#import "ZhangDanMingXiSubModel.h"
#import "ChuFangDetailViewController.h"
#import "GuKeChuFangList.h"
#import "GuKeChuFang.h"
#import "ChuFangReporterViewController.h"
#import "BookRequest.h"
#import "ShareWorkInstance.h"
#import "UserManager.h"
#import "LolUserInfoModel.h"
#import "ReportBJController.h"
/** 自定义View */
#import "CustomerDetailTbHeader.h"
#import "CommonSubmitView.h"
#import "XMHRefreshGifHeader.h"
@interface TheOneCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tbView;
    CustomerDetailHeader *_tbHeaderView;
    __block TwoBtnChoiseSectionType _type;
    TwoBtnChoiseSectionHeader *_sectionheader;
    BeautyRequest       *_zhangDanMingXiRequest;
    BeautyRequest       *_guKeChuFangRequest;
    ZhangDanMingXiModel *_zhangDanMingXiModel;
    NSMutableArray      *_zhangDanMingXiList;
    NSMutableArray      *_guKeChuFangList;
    BOOL  _onceTime;
    CustomerMessageModel * _customerMessageModel;
    Join_Code *_sharejoin_code;
    NSString *_jsName;
}
@property (nonatomic, strong)CustomerDetailTbHeader * tbHeader;
@property (nonatomic, strong)UITableView * tbView;
@property (nonatomic, strong)CommonSubmitView * commonSubmitView;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation TheOneCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 初始化数据 */
    _zhangDanMingXiRequest = [[BeautyRequest alloc]init];
    _guKeChuFangRequest = [[BeautyRequest alloc]init];
    _sharejoin_code = [ShareWorkInstance shareInstance].share_join_code;
    _onceTime = YES;
    
    /** 构建UI */
    [self creatNav];
    [self.view addSubview:self.tbView];
    if (_from == 1) {
        _tbView.frame = CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,Heigh_View_normal);
    }
    if (_from == 2) {
        _tbView.frame = CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,Heigh_View_normal - 69);
        [self.view addSubview:self.commonSubmitView];
    }
    
    
    /** 数据请求 */
    /** 头部数据 */
    [self requestUserData];
    /** 列表数据 */
    [self requestNetData];
    
    
}
#pragma mark ------跳转相关------
- (void)pop
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)nextEvent
{
    BeautyAskViewController *vc = [[BeautyAskViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark ------构建UI------
- (CustomerDetailTbHeader *)tbHeader
{
    if (!_tbHeader) {
        _tbHeader = loadNibName(@"CustomerDetailTbHeader");
    }
    return _tbHeader;
}
- (CommonSubmitView *)commonSubmitView
{
    WeakSelf
    if (!_commonSubmitView) {
        _commonSubmitView = loadNibName(@"CommonSubmitView");
        _commonSubmitView.frame = CGRectMake(0, SCREEN_HEIGHT - 69, SCREEN_WIDTH, 69);
        [_commonSubmitView updateCommonSubmitViewTitle:@"定制处方"];
        _commonSubmitView.CommonSubmitViewBlock = ^{
            BeautyAskViewController *vc = [[BeautyAskViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:NO];
        };
    }
    return _commonSubmitView;
}
- (void)creatNav
{
    NSString *rightStr = nil;
    NSString *roleStr = [NSString stringWithFormat:@"%ld",_sharejoin_code.framework_function_main_role];
    NSArray * canRoleStrs = @[@"4",@"5",@"6",@"8",@"9",@"10"];
    if ([canRoleStrs containsObject:roleStr]) {
        if (_from == 1) {
            rightStr = @"下一步";
        }
        if (_from == 2) {
            rightStr = @"";
        }
    }
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客总处方" withleftImageStr:@"stgkgl_fanhui" withRightStr:rightStr];
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    if ([canRoleStrs containsObject:roleStr]) {
        [nav.btnRight addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];

}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav,SCREEN_WIDTH,Heigh_View_normal) style:UITableViewStylePlain];
        _tbView.separatorColor = [UIColor clearColor];
        _tbView.backgroundColor = Color_NormalBG;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableHeaderView = self.tbHeader;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf requestNetData];
//        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestNetData];
            });
        }];
    }
    return _gifHeader;
}
- (void)requestMoreNetData{
    [self endRefreshing];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}

#pragma mark ------UITableViewDelegate------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerDetailCellindentifier = @"ChoiseCustomerCellindentifier";
    static NSString *CustomerDetailCell1indentifier = @"CustomerDetailCell1indentifier";
    static NSString *CustomerDetailCell2indentifier = @"CustomerDetailCell2indentifier";

    switch (_type) {
        case TwoBtnChoiseSectionTypeZhangDan:
        {
            if (indexPath.row == 0) {
                CustomerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomerDetailCellindentifier];
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerDetailCell" owner:nil options:nil] lastObject];
                }
                [cell reFreshCustomerDetailCell:_zhangDanMingXiModel];
                return cell;
            }else{
                CustomerDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CustomerDetailCell1indentifier];
                if (!cell)
                {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerDetailCell1" owner:nil options:nil] lastObject];
                }
                if (indexPath.row-1 < _zhangDanMingXiList.count) {
                    ZhangDanMingXiSubModel *zhangDanMingXiSubModel = _zhangDanMingXiList[indexPath.row - 1];
                    [cell reFreshCustomerDetailCell1:zhangDanMingXiSubModel];
                }
                return cell;
            }
        }
            break;
        case TwoBtnChoiseSectionTypeGuKe:
        {
            CustomerDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CustomerDetailCell2indentifier];
            if (!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerDetailCell2" owner:nil options:nil] lastObject];
            }
            if (indexPath.row < _guKeChuFangList.count) {
                GuKeChuFang *model = [_guKeChuFangList objectAtIndex:indexPath.row];
                model.jis_name = _jsName;
                [cell reFreshCustomerDetailCell2:model];
                cell.CustomerDetailCell2Block = ^(GuKeChuFang *model) {
                    if (!model.presentation || !model.proposal) {
                        ReportBJController *VC = [[ReportBJController alloc]init];
                        VC.ordernum = model.ordernum;
                        LolUserInfoModel *usermodel =  [UserManager getObjectUserDefaults:userLogInInfo];
                        VC.token = usermodel.data.token;
                        VC.ReportBJControllerPopBlock = ^{
                            [_tbView.mj_header beginRefreshing];
                        };
                        [self.navigationController pushViewController:VC animated:NO];
                    }else{
                        ChuFangReporterViewController *VC = [[ChuFangReporterViewController alloc]init];
                        VC.info = _customerMessageModel;
                        VC.subinfo = model;
                        LolUserInfoModel *usermodel =  [UserManager getObjectUserDefaults:userLogInInfo];
                        VC.token = usermodel.data.token;
                        [self.navigationController pushViewController:VC animated:NO];
                    }
                };
            }
            return cell;
        }
            break;
        default:
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _sectionheader = [[[NSBundle mainBundle]loadNibNamed:@"TwoBtnChoiseSectionHeader" owner:nil options:nil] firstObject];
     __block UITableView *tempTb = _tbView;
    WeakSelf;
    __block BOOL tempBool = _onceTime;
    _sectionheader.TwoBtnChoiseSectionHeaderBlock = ^(TwoBtnChoiseSectionType type) {
        _type = type;
        if (tempBool) {
            if (type == TwoBtnChoiseSectionTypeGuKe) {
                [weakSelf requestGuKeChuFangData];
                _onceTime=NO;
            }
        }
        [tempTb reloadData];
    };
    _sectionheader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [_sectionheader reFreshTwoBtnChoiseSectionHeader:_type];
    return _sectionheader;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case TwoBtnChoiseSectionTypeZhangDan:
        {
            
        }
            break;
        case TwoBtnChoiseSectionTypeGuKe:
        {
            GuKeChuFang *model = [_guKeChuFangList objectAtIndex:indexPath.row];
            ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
            LolUserInfoModel *usermodel =  [UserManager getObjectUserDefaults:userLogInInfo];
            NSString    *token = usermodel.data.token;
            vc.billNum = model.ordernum;
            vc.token = token;
            vc.zt = model.zt;
            vc.num1byPass = model.num1;
            vc.ChuFangDetailViewControllerBlock = ^{
                [_tbView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_type) {
        case TwoBtnChoiseSectionTypeZhangDan:
        {
            return _zhangDanMingXiList.count+1;
        }
            break;
        case TwoBtnChoiseSectionTypeGuKe:
        {
            return _guKeChuFangList.count;
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_type) {
        case TwoBtnChoiseSectionTypeZhangDan:
        {
            if (indexPath.row == 0) {
                return 130;
            }else{
                return 75;
            }
        }
            break;
        case TwoBtnChoiseSectionTypeGuKe:
        {
            return 127;
        }
            break;
        default:
            break;
    }
}
#pragma mark ------网络请求------
/** 顾客信息 */
- (void)requestUserData
{
    BookRequest * request = [[BookRequest alloc] init];
    NSMutableDictionary *parmsDic = [@{@"user_id":_uid,@"join_code":_join_code} mutableCopy];
    [request requestCustomerMessageParams:parmsDic resultBlock:^(CustomerMessageModel *customerMessageModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [ShareWorkInstance shareInstance].uid = customerMessageModel.uid;
            [ShareWorkInstance shareInstance].store_code = customerMessageModel.store_code;
            [ShareWorkInstance shareInstance].join_code = customerMessageModel.join_code;
            [_tbHeader updateCustomerDetailTbHeaderModel:customerMessageModel];
            _customerMessageModel = customerMessageModel;
            _jsName = customerMessageModel.jis_name;
        }
    }];
}
/** 顾客账单 */
- (void)requestNetData
{
    switch (_type) {
        case TwoBtnChoiseSectionTypeZhangDan:
        {
            [_zhangDanMingXiRequest requestZhangDanMingxi:[NSString stringWithFormat:@"%@",_uid] Join_code:_join_code resultBlock:^(ZhangDanMingXiModel *zhangDanMingXiModel, BOOL isSuccess, NSDictionary *errorDic) {
                [self endRefreshing];
                if (isSuccess) {
                    _zhangDanMingXiModel = zhangDanMingXiModel;
                    _zhangDanMingXiList = zhangDanMingXiModel.list;
                    [_tbView reloadData];
                }
            }];
        }
            break;
        case TwoBtnChoiseSectionTypeGuKe:
        {
            [self requestGuKeChuFangData];
        }
            break;
        default:
            break;
    }
}
/** 处方数据 */
- (void)requestGuKeChuFangData{
    [_guKeChuFangRequest requestGuKeChuFang:_uid resultBlock:^(GuKeChuFangList *guKeChuFangList, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            _guKeChuFangList = guKeChuFangList.list;
            [_tbView reloadData];
        }
    }];
}
@end
