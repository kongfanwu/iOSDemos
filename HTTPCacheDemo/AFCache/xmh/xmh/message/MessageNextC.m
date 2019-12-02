//
//  MessageNextC.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MessageNextC.h"
#import "MsgRequest.h"
#import "LolUserInfoModel.h"
#import "MessageNextCell.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "LMsgListModel.h"
#import "MsgHomeListModel.h"
#import "ShareWorkInstance.h"
#import "LMsgListModel.h"
#import "NSString+Costom.h"
#import "ApproveDetailController.h"
#import "MzzGenjinViewController.h"
#import "BookDetailsViewController.h"
#import "ChuFangDetailViewController.h"
#import "LolSkipToDetailMode.h"
#import "MzzJiSuanViewController.h"
#import "MassgaeNoDataView.h"
#import "XMHRefreshGifHeader.h"
#import "BeautyCFDetailVC.h"
#import "MsgActivityCenterErrorVC.h"
#import "XMHNewMzzJiSuanViewController.h"
#import "BookParamModel.h"
#import "BookDetailVC.h"
#import "XMHOutComeFactory.h"
@interface MessageNextC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)MassgaeNoDataView *noDataView;
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;
@end

@implementation MessageNextC
{
    /** 加载更多 */
    BOOL _isMore;
    NSInteger _page;
    LMsgListModel * _msgListModel;
    NSString * _joinCode;
    NSString * _accountId;
    NSString * _token;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    _isMore = NO;
    _page = 0;
    [self initSubViews];
    
    [self requestHomeMsgListData];
}
- (void)initSubViews
{
    [self.navView setNavViewTitle:_msgHomeModel.title backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.noDataImageView];
}
- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.backgroundColor = kColorE;
        _tbView.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [self refreshTbData];
//        }];
        __weak typeof(self) _self = self;
        _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self requestMoreData];
        }];
    }
    return _tbView;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        __weak typeof(self) _self = self;
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            __strong typeof(_self) self = _self;
            [self refreshTbData];
        }];
    }
    return _gifHeader;
}
- (MassgaeNoDataView *)noDataImageView
{
    if (!_noDataView) {
        _noDataView = loadNibName(@"MassgaeNoDataView");
        _noDataView.frame = CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Heigh_Nav);
        _noDataView.hidden = YES;
        [_noDataView updateMassgaeNoDataViewText:@"暂没有消息提醒哟!"];
    }
    return _noDataView;
}
- (void)requestMoreData
{
    _isMore = YES;
    _page ++;
    [self requestHomeMsgListData];
}
- (void)refreshTbData
{
    _isMore = NO;
    _page = 0;
    [self requestHomeMsgListData];
}
- (void)endRefreshing{
    [_tbView.mj_header endRefreshing];
    [_tbView.mj_footer endRefreshing];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kMessageNextCell = @"kMessageNextCell";
    MessageNextCell * messageNextCell = [tableView dequeueReusableCellWithIdentifier:kMessageNextCell];
    if (!messageNextCell) {
        messageNextCell = loadNibName(@"MessageNextCell");
    }
    [messageNextCell updateMessageNextCellModel:_dataSource[indexPath.row]];
    return messageNextCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tbView.rowHeight = UITableViewAutomaticDimension;
    _tbView.estimatedRowHeight = 240;
    return _tbView.rowHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMsgModel * model = _dataSource[indexPath.row];
    [self skipToDestWithModel:model];
}

- (void)skipToDestWithModel:(LMsgModel *)msgModel
{
    /* 待消息推送上线测试后打开2019/8/29
    id vc =  [XMHOutComeFactory createOutComeVCMsgModel:msgModel pushUserInfo:nil isUMPush:NO];
    [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
    return;
     */
    
    NSDictionary * urlDict = [msgModel.url dictionaryWithJsonString:msgModel.url];
    NSString * ptype = urlDict[@"ptype"];
    NSString * joinCode = urlDict[@"join_code"];
    NSString * orderNum = urlDict[@"ordernum"];
    NSString * activity_id = urlDict[@"b_activity_id"];
    NSString * storeCode = urlDict[@"store_code"];
    if ([ptype containsString:@"approval"]) { //跳转审批模块
        // 准备ApproveDetailModel 参数
        NSString * code = urlDict[@"code"];
        NSString * from = urlDict[@"type"];
        BOOL isFromList = NO;
        NSArray * arr = [ptype componentsSeparatedByString:@"-"];
        NSInteger ptypeIndex = [[arr lastObject] integerValue];
        NSString * navTitle = nil;
        NSString * urlStr = nil;
        switch (ptypeIndex) {
            case 1:{//会员冻结
                navTitle = @"会员冻结审批";
                urlStr = [NSString stringWithFormat:@"%@approval/dongjie.html",SERVER_H5];
            }
                break;
            case 2:{//账单校正
                navTitle = @"账单校正审批";
                urlStr = [NSString stringWithFormat:@"%@approval/jiaozheng.html",SERVER_H5];
            }
                break;
            case 3:{//清卡审批
                navTitle = @"清卡审批";
                urlStr = [NSString stringWithFormat:@"%@approval/qingka.html",SERVER_H5];
            }
                break;
            case 4:{//完善资料
                navTitle = @"完善信息";
                urlStr = [NSString stringWithFormat:@"%@approval/wanshan.html",SERVER_H5];
            }
                break;
            case 5:{//会员调店
                navTitle = @"会员调店审批";
                urlStr = [NSString stringWithFormat:@"%@approval/tiaodian.html",SERVER_H5];
            }
                break;
            case 6:{//个性制单
                navTitle = @"个性制单";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }
                break;
            case 7:{//已购置换
                navTitle = @"已购置换";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }
                break;
            case 8:{//升卡续卡
                navTitle = @"升卡续卡";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }
                break;
            case 9:{//奖赠审批
                navTitle = @"奖赠审批";
                urlStr = [NSString stringWithFormat:@"%@sales/infor.html",SERVER_H5];
                isFromList = YES;
            }
                break;
                
            default:
                break;
        }
        ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:_token joinCode:joinCode code:code accountId:_accountId url:urlStr navTitle:navTitle from:from ordernum:orderNum fromList:isFromList];
        ApproveDetailController * next = [[ApproveDetailController alloc] init];
        next.detailModel = detailModel;
        [self.navigationController pushViewController:next animated:NO];
    }else if ([ptype isEqualToString:@"user-1"]){//智能分配跳转跟进顾客
        //
        NSString * jis = urlDict[@"jis"];
        NSString * userId = urlDict[@"user_id"];
        NSString * userName = urlDict[@"user_name"];
        MzzGenjinViewController * vc = [[MzzGenjinViewController alloc] init];
        [vc setJis:jis andUser_id:userId andUname:userName];
        [self.navigationController pushViewController:vc animated:NO];
    }else if ([ptype isEqualToString:@"appo-1"]){ //预约管理跳转
        //
        NSString * userId = urlDict[@"user_id"];
        NSString * orderNum = urlDict[@"ordernum"];
        //        LolSkipToDetailMode * skipModel = [[LolSkipToDetailMode alloc]initWithType:@"yyy" orderNum:orderNum userId:userId toGd:@""];
        //        BookDetailsViewController * next = [[BookDetailsViewController  alloc] init];
        //        next.skipModel = skipModel;
        BookDetailVC * bookDetail = [[BookDetailVC alloc] init];
        BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"服务详情" type:@"yyy"orderNum:orderNum userID:userId];
        bookDetail.paramModel = paramModel;
        [self.navigationController pushViewController:bookDetail animated:YES];
        //        [self.navigationController pushViewController:next animated:NO];
    }else if ([ptype containsString:@"ser"]){ // 销售单服务单跳转
        NSArray * arr = [ptype componentsSeparatedByString:@"-"];
        NSInteger ptypeIndex = [[arr lastObject] integerValue];
        NSString * orderNum = urlDict[@"ordernum"];
        NSString * type = urlDict[@"type"];
        NSString * userId = urlDict[@"user_id"];
        switch (ptypeIndex) {
            case 1:{//销售单结算
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andYemianStyle:YemianJieSuan andType:type.integerValue andUid:userId withName:@""];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
            case 2:{//销售单补签
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andYemianStyle:YemianBuQian andType:type.integerValue andUid:userId withName:@""];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
            case 3:{//服务单结算
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andZt:@"2"];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
            case 4:{//服务单补签
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andZt:@"3"];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
                
            default:
                break;
        }
    }else if ([ptype containsString:@"pres"]){ //  美丽定制跳转
        NSArray * arr = [ptype componentsSeparatedByString:@"-"];
        NSInteger ptypeIndex = [[arr lastObject] integerValue];
        NSString * orderNum = urlDict[@"ordernum"];
        NSString * userId = urlDict[@"user_id"];
        switch (ptypeIndex) {
            case 1:
            case 2:
            {
                //                ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
                //                LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
                //                NSString    *token = model.data.token;
                //                vc.billNum = orderNum;
                //                vc.token = token;
                //                vc.isComeFromMsg = YES;
                //                vc.userId = userId;
                //                [self.navigationController pushViewController:vc animated:NO];
                NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
                [param setValue:userId forKey:@"user_id"];
                [param setValue:orderNum forKey:@"ordernum"];
                [param setValue:storeCode forKey:@"store_code"];
                [param setValue:@"2" forKey:@"come"];
                BeautyCFDetailVC * next = [[BeautyCFDetailVC alloc] init];
                next.msgBlock = ^{
                    [self.navigationController popToViewController:self animated:NO];
                };
                next.param = param;
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
                
            default:
                break;
        }
    }else if([ptype isEqualToString:@"b_activity"]){
        MsgActivityCenterErrorVC * next = [[MsgActivityCenterErrorVC alloc] init];
        next.activity_id = activity_id;
        [self.navigationController pushViewController:next animated:NO];
        
    }
 
}
#pragma mark ------网络请求------
- (void)requestHomeMsgListData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * page = [NSString stringWithFormat:@"%ld",_page];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:accountId?accountId:@"" forKey:@"account_id"];
    [param setValue:page?page:@"0" forKey:@"page"];
    [param setValue:_msgHomeModel.state?_msgHomeModel.state:@"" forKey:@"type"];
    [MsgRequest requestMsgListParam:param resultBlock:^(LMsgListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        [self endRefreshing];
        if (isSuccess) {
            if (!_isMore) {
                [_dataSource removeAllObjects];
            }
            [_dataSource addObjectsFromArray:model.list];
            if (model.list.count == 0) {
                [_tbView.mj_footer endRefreshingWithNoMoreData];
            }
            if (_dataSource.count == 0) {
                _noDataView.hidden = NO;
            }
            [_tbView reloadData];
        }else{}
    }];
}
@end
