//
//  XMHOutComeFactory.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeFactory.h"
#import "XMHOutComeNoteVC.h"
#import "XMHOutComeCouponVC.h"
#import "XMHOutComeSubscribeVC.h"
#import "XMHWorkTaskScheduleVC.h"
#import "XMHDataReportVC.h"
#import "LMsgListModel.h"
#import "NSString+Costom.h"
#import "NSString+NCDate.h"
#import "ApproveDetailModel.h"
#import "ApproveDetailController.h"
#import "MzzGenjinViewController.h"
#import "BookDetailVC.h"
#import "BookParamModel.h"
#import "XMHNewMzzJiSuanViewController.h"
#import "BeautyCFDetailVC.h"
#import "MsgActivityCenterErrorVC.h"
@interface XMHOutComeFactory()

@end

@implementation XMHOutComeFactory

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.readMessages = NSMutableArray.new;
    }
    return self;
}
+(id)createOutComeVCMsgModel:(LMsgModel *)msgModel pushUserInfo:(NSDictionary *) pushUserInfo isUMPush:(BOOL)isUMPush;
{
    NSString * ptype;
    NSString *cute_hand_rec_id;
    NSDictionary *jumpDic = [NSDictionary dictionary];
    if (isUMPush) {
        // 由后台提供数据
        NSDictionary *dic = pushUserInfo[@"aps"];
        jumpDic = [[dic safeObjectForKey:@"jump"] dictionaryWithJsonString:[dic valueForKey:@"jump"]];
        cute_hand_rec_id = [jumpDic safeObjectForKey:@"cute_hand_rec_id"];
        ptype = [jumpDic safeObjectForKey:@"ptype"];

    }else{
    
        jumpDic = [msgModel.url dictionaryWithJsonString:msgModel.url];
        ptype =  jumpDic[@"ptype"];
        cute_hand_rec_id = [jumpDic safeObjectForKey:@"cute_hand_rec_id"];
    }
    
    UIViewController *viewController;
    
    // 获取对应字段
    NSString * joinCode = [jumpDic safeObjectForKey:@"join_code"];
    NSString * orderNum = [jumpDic safeObjectForKey:@"ordernum"];
    NSString * activity_id = [jumpDic safeObjectForKey:@"b_activity_id"];
    NSString * storeCode = [jumpDic safeObjectForKey:@"store_code"];
    
    if ([ptype containsString:@"approval"]) { //跳转审批模块
        // 准备ApproveDetailModel 参数
        NSString * code = jumpDic[@"code"];
        NSString * from = jumpDic[@"type"];
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
        ApproveDetailModel * detailModel = [ApproveDetailModel initWithToken:@"" joinCode:joinCode code:code accountId:@"" url:urlStr navTitle:navTitle from:from ordernum:orderNum fromList:isFromList];
        ApproveDetailController * next = [[ApproveDetailController alloc] init];
        next.detailModel = detailModel;
        viewController = next;
    }else if ([ptype isEqualToString:@"user-1"]){//智能分配跳转跟进顾客
        //
        NSString * jis = jumpDic[@"jis"];
        NSString * userId = jumpDic[@"user_id"];
        NSString * userName = jumpDic[@"user_name"];
        MzzGenjinViewController * vc = [[MzzGenjinViewController alloc] init];
        [vc setJis:jis andUser_id:userId andUname:userName];
        viewController = vc;
    }else if ([ptype isEqualToString:@"appo-1"]){ //预约管理跳转
        //
        NSString * userId = jumpDic[@"user_id"];
        NSString * orderNum = jumpDic[@"ordernum"];
       
        BookDetailVC * bookDetail = [[BookDetailVC alloc] init];
        BookParamModel * paramModel = [BookParamModel createBookParamModelVCTitle:@"服务详情" type:@"yyy"orderNum:orderNum userID:userId];
        bookDetail.paramModel = paramModel;
       viewController = bookDetail;

    }else if ([ptype containsString:@"ser"]){ // 销售单服务单跳转
        NSArray * arr = [ptype componentsSeparatedByString:@"-"];
        NSInteger ptypeIndex = [[arr lastObject] integerValue];
        NSString * orderNum = jumpDic[@"ordernum"];
        NSString * type = jumpDic[@"type"];
        NSString * userId = jumpDic[@"user_id"];
        switch (ptypeIndex) {
            case 1:{//销售单结算
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andYemianStyle:YemianJieSuan andType:type.integerValue andUid:userId withName:@""];
                 viewController = next;
            }
                break;
            case 2:{//销售单补签
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andYemianStyle:YemianBuQian andType:type.integerValue andUid:userId withName:@""];
                viewController = next;
            }
                break;
            case 3:{//服务单结算
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andZt:@"2"];
                  viewController = next;
            }
                break;
            case 4:{//服务单补签
                XMHNewMzzJiSuanViewController *next = [[XMHNewMzzJiSuanViewController alloc] init];
                [next setOrderNum:orderNum andZt:@"3"];
                viewController = next;
            }
                break;
                
            default:
                break;
                return viewController;
               
        }
    }else if ([ptype containsString:@"pres"]){ //  美丽定制跳转
        NSArray * arr = [ptype componentsSeparatedByString:@"-"];
        NSInteger ptypeIndex = [[arr lastObject] integerValue];
        NSString * orderNum = jumpDic[@"ordernum"];
        NSString * userId = jumpDic[@"user_id"];
        switch (ptypeIndex) {
            case 1:
            case 2:
            {
                NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
                [param setValue:userId forKey:@"user_id"];
                [param setValue:orderNum forKey:@"ordernum"];
                [param setValue:storeCode forKey:@"store_code"];
                [param setValue:@"2" forKey:@"come"];
                BeautyCFDetailVC * next = [[BeautyCFDetailVC alloc] init];
                next.msgBlock = ^{
                  UIViewController *currentVC =  [XMHVCTools getCurrentViewController];
                 [currentVC.navigationController popViewControllerAnimated:NO];
                };
                next.param = param;
                viewController = next;
            }
                break;
                
            default:
                break;
        }
    }else if([ptype isEqualToString:@"b_activity"]){
        MsgActivityCenterErrorVC * next = [[MsgActivityCenterErrorVC alloc] init];
        next.activity_id = activity_id;
        viewController = next;
        
    }
    
    // 这段代码先屏蔽,待智能助手上线再打开
//    else if ([ptype containsString:@"cute"]){// 智能助手的ptype是cute开头:cute-1标准服务流程提醒 cute-2标准服务流程提醒 cute-3任务执行短信提醒 cute-4任务执行优惠券提醒 cute-5任务执行预约提醒 cute-6所有的任务都完成（跳转到数据报告）
//        id<XMHOutComeProtocol> viewController;
//        XMHResultOfExecutionType type = [[ptype substringFromIndex:ptype.length-1] integerValue];
//        switch (type) {
//            case XMHResultOfExecutionTypeNote:
//                viewController = [[XMHOutComeNoteVC alloc]init];
//                break;
//            case XMHResultOfExecutionTypeCoupon:
//                viewController = [[XMHOutComeCouponVC alloc]init];
//                break;
//            case XMHResultOfExecutionTypeSubscribe:
//                viewController = [[XMHOutComeSubscribeVC alloc]init];
//                break;
//            case XMHResultOfExecutionTypeStandard_Remind:{
//                XMHWorkTaskScheduleVC *vc = [[XMHWorkTaskScheduleVC alloc]init];
//                vc.type = WorkTaskScheduleTypeRemind;
//                viewController = vc;
//            }
//                break;
//            case XMHResultOfExecutionTypeActual_Remind:{
//                XMHWorkTaskScheduleVC *vc = [[XMHWorkTaskScheduleVC alloc]init];
//                vc.type = WorkTaskScheduleTypeCheck;
//                vc.time = [NSString formateDateToYYYYMMdd:msgModel.time];
//                viewController = vc;
//            }
//                break;
//            case XMHResultOfExecutionTypeDataReport:{
//                viewController = [[XMHDataReportVC alloc]init];
//            }
//                break;
//
//            default:
//                break;
//        }
//        viewController.cute_hand_rec_id = cute_hand_rec_id;
//        return viewController;
//    }
    
    return viewController;
}

- (void)addReadMessage:(LMsgModel *)msgModel
{
//    NSString *cute_hand_rec_id = [[msgModel.url dictionaryWithJsonString:msgModel.url] valueForKey:@"cute_hand_rec_id"];
//    for (LMsgModel *model in self.readMessages) {
//        NSString *rec_id = [[model.url dictionaryWithJsonString:msgModel.url] valueForKey:@"cute_hand_rec_id"];
//        if ([cute_hand_rec_id isEqualToString:rec_id]) {
//        }else{
//           [self.readMessages safeAddObject:msgModel];
//        }
//    }
//    
//    if (![self.readMessages containsObject:msgModel]) {
//       [self.readMessages safeAddObject:msgModel];
//        
//    }
}
@end
