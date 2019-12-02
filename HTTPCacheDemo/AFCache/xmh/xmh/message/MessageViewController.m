//
//  MessageViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//
#import "LLTabBar.h"
#import "MessageViewController.h"
#import "messageCell.h"
#import "MessageCellNote.h"
#import "MsgRequest.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "LMsgListModel.h"
#import "NSString+Costom.h"
#import "ApproveDetailController.h"
#import "MzzGenjinViewController.h"
#import "BookDetailsViewController.h"
#import "ChuFangDetailViewController.h"
#import "LolSkipToDetailMode.h"
#import "MzzJiSuanViewController.h"

#import "LNavView.h"
#import "LNMsgCell.h"
#import "BookDetailVC.h"
#import "BookParamModel.h"
#import "XMHRefreshGifHeader.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tbMessage;
/** 刷新 */
@property (nonatomic, strong)XMHRefreshGifHeader * gifHeader;

@end

@implementation MessageViewController
{
    LMsgListModel * _msgListModel;
    NSString * _joinCode;
    NSString * _accountId;
    NSString * _token;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
    [self initBaseData];
    [self requestNetData];
}
- (void)requestNum
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_accountId forKey:@"account_id"];
    [param setValue:_joinCode forKey:@"join_code"];
    [MsgRequest requestUnReadNumParma:param resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
        }
    }];
}
#pragma mark    ------UI------
- (void)initSubViews
{
    [self creatNav];
    [self.view addSubview:self.tbMessage];
}
- (void)creatNav{
    LNavView * navView = loadNibName(@"LNavView");
    navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav);
    [navView setNavViewTitle:@"消息"];
    [self.view addSubview:navView];
}
- (UITableView *)tbMessage
{
    WeakSelf;
    if (!_tbMessage) {
        _tbMessage = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 15,SCREEN_WIDTH,Heigh_View) style:UITableViewStylePlain];
        _tbMessage.backgroundColor = kBackgroundColor;
        _tbMessage.separatorColor = [UIColor clearColor];
        _tbMessage.delegate = self;
        _tbMessage.dataSource = self;
        _tbMessage.mj_header = self.gifHeader;
//        [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf requestNetData];
//        }];
        _tbMessage.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestMoreNetData];
        }];
    }
    return _tbMessage;
}
- (XMHRefreshGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [XMHRefreshGifHeader headerWithRefreshingBlock:^{
            [self requestNetData];
        }];
    }
    return _gifHeader;
}

#pragma mark    ------DATA------
- (void)initBaseData
{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * accountId = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    NSString * joincode = [ShareWorkInstance shareInstance].join_code;
    _accountId = accountId;
    _joinCode = joincode;
    _token = infomodel.data.token;
}
- (void)requestNetData
{
    WeakSelf
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:_accountId forKey:@"account_id"];
    [param setValue:_joinCode forKey:@"join_code"];
    [MsgRequest requestMsgListParam:param resultBlock:^(LMsgListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _msgListModel = model;
            [_tbMessage reloadData];
            [weakSelf endRefreshing];
        }
    }];
}
- (void)requestMoreNetData{
    [self endRefreshing];
}
- (void)endRefreshing{
    [_tbMessage.mj_header endRefreshing];
    [_tbMessage.mj_footer endRefreshing];
}
#pragma mark    ------UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"messageCellindentifier";
    LNMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LNMsgCell" owner:nil options:nil] lastObject];
    }
    cell.model = _msgListModel.list[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _msgListModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tbMessage.rowHeight = UITableViewAutomaticDimension;
    _tbMessage.estimatedRowHeight = 240;
    return _tbMessage.rowHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMsgModel * model =  _msgListModel.list[indexPath.row];
    [self skipToDestWithModel:model];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestNetData];
}
- (void)skipToDestWithModel:(LMsgModel *)msgModel
{
    NSDictionary * urlDict = [msgModel.url dictionaryWithJsonString:msgModel.url];
    NSString * ptype = urlDict[@"ptype"];
    NSString * joinCode = urlDict[@"join_code"];
    NSString * orderNum = urlDict[@"ordernum"];
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
//        [self.navigationController pushViewController:next animated:NO];
        
        BookDetailVC * bookDetail = [[BookDetailVC alloc] init];
        BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"服务详情" type:@"yyy"orderNum:orderNum userID:userId];
        bookDetail.paramModel = paramModel;
        [self.navigationController pushViewController:bookDetail animated:YES];
    }else if ([ptype containsString:@"ser"]){ // 销售单服务单跳转
        NSArray * arr = [ptype componentsSeparatedByString:@"-"];
        NSInteger ptypeIndex = [[arr lastObject] integerValue];
        NSString * orderNum = urlDict[@"ordernum"];
        NSString * type = urlDict[@"type"];
        NSString * userId = urlDict[@"user_id"];
        switch (ptypeIndex) {
            case 1:{//销售单结算
                MzzJiSuanViewController *next = [[MzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andYemianStyle:YemianJieSuan andType:type.integerValue andUid:userId withName:@""];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
            case 2:{//销售单补签
               MzzJiSuanViewController *next = [[MzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andYemianStyle:YemianBuQian andType:type.integerValue andUid:userId withName:@""];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
            case 3:{//服务单结算
                MzzJiSuanViewController *next = [[MzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andZt:@"2"];
                [self.navigationController pushViewController:next animated:NO];
            }
                break;
            case 4:{//服务单补签
                MzzJiSuanViewController *next = [[MzzJiSuanViewController alloc] init];
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
                ChuFangDetailViewController *vc = [[ChuFangDetailViewController alloc]init];
                LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
                NSString    *token = model.data.token;
                vc.billNum = orderNum;
                vc.token = token;
                vc.isComeFromMsg = YES;
                vc.userId = userId;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
                
            default:
                break;
        }
    }else{
        
    }
}
@end
