//
//  XMHCouponVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponVC.h"
#import "XMHACCouponListCell.h"
#import "XMHCouponModel.h"
#import "XMHCouponListStateItemModel.h"
#import "UITableView+XMHEmptyData.h"
#import "XMHSuccessAlertView.h"
#import "XMHActionCenterRequest.h"
#import "XMHSuccessAlertView.h"
#import "XMHFormVC.h"
#import "XMHCouponRequest.h"
#import "XMHItemModel.h"
#import "XMHServiceGoodsModel.h"
#import "XMHFormDataCreate.h"
#import <UMShare/UMShare.h>
#import "XMHACShareView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface XMHCouponVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) XMHACShareView *shareView;
@property(nonatomic, assign)CGRect frame;
@property(nonatomic, strong) NSMutableDictionary *currentParams;
@end

@implementation XMHCouponVC
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        _currentParams = [NSMutableDictionary dictionary];
        _dataArr = [NSMutableArray array];
        self.page = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[XMHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.emptyEnable = YES;
    _tableView.backgroundColor = kBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100.f;
    [self.view addSubview:_tableView];
      __weak typeof(self) _self = self;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(_self) self = _self;
        self.page++;
        if (self.currentParams.allValues.count) {
            [self requestListDataParmas:self.currentParams];
        }
        
    }];
}

#pragma mark -- request
- (void)requestListDataParmas:(NSMutableDictionary *)params
{
    _currentParams = params;

    [params setValue:@(self.page) forKey:@"page"];
    
    XMHActionCenterRequest *request =   [[XMHActionCenterRequest alloc]init];
    [request requestCouponListParams:params resultBlock:^(NSMutableArray * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
         [_tableView.mj_footer endRefreshing];
        if (isSuccess) {
             _tableView.mj_footer.hidden = !result.count;
            if (_page == 1) {
                _dataArr = [result mutableCopy];
            }else {
                [_dataArr addObjectsFromArray:result];
            }
            [self.tableView reloadData];
  
        }
    }];
}
/**
 获取优惠券详情

 @param couponModel 优惠券model
 @param complete 回调
 */
- (void)getCpuponDataCouponModel:(XMHCouponModel *)couponModel complete:(void(^)(XMHCouponModel *couponModel))complete {
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSMutableDictionary *param = NSMutableDictionary.new;
    param[@"id"] = couponModel.uid;
    param[@"account"] = model.data.account;
    param[@"account_id"] = @(model.data.ID).stringValue;
    [XMHCouponRequest requestCouponEditParams:param resultBlock:^(BaseModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (!isSuccess) return;
        XMHCouponModel *newCouponModel = [XMHCouponModel yy_modelWithJSON:model.data];
        
        //------- 会员等级 -------
        // type 0 会员等级 1 订单商品 2 使用渠道 3 支付使用
        NSDictionary *vipDic = [XMHCouponModel getRulesType:0 rules:model.data[@"rules"]];
        newCouponModel.vipLevel = vipDic[@"condition1"];
        // 不是全部 && 选择了部分等级
        if ([newCouponModel.vipLevel isKindOfClass:[NSArray class]]) {
            newCouponModel.vipDataArray = [NSArray yy_modelArrayWithClass:[XMHItemModel class] json:vipDic[@"condition1"]];
            NSMutableString *str = NSMutableString.new;
            for (int i = 0; i < newCouponModel.vipDataArray.count; i++) {
                XMHItemModel *itemMdoel = newCouponModel.vipDataArray[i];
                if (i == newCouponModel.vipDataArray.count - 1) {
                    [str appendFormat:@"%@", itemMdoel.title];
                } else {
                    [str appendFormat:@"%@,", itemMdoel.title];
                }
            }
            newCouponModel.vipLevel = str;
        }
        
        //------- 订单商品 -------
        NSDictionary *orderDic = [XMHCouponModel getRulesType:1 rules:model.data[@"rules"]];
        newCouponModel.orderGoods = orderDic[@"condition1"];
        if ([newCouponModel.orderGoods isKindOfClass:[NSArray class]]) {
            newCouponModel.orderDataArray = [NSArray yy_modelArrayWithClass:[XMHServiceGoodsModel class] json:orderDic[@"condition1"]];
            newCouponModel.orderGoods = [NSString stringWithFormat:@"订单商品（已选%lu）", (unsigned long)newCouponModel.orderDataArray.count];
        }
        
        //------- 使用渠道 -------
        NSDictionary *platformDic = [XMHCouponModel getRulesType:2 rules:model.data[@"rules"]];
        newCouponModel.platform = IsEmpty(platformDic[@"condition1"]) ? nil : platformDic[@"condition1"];
        
        NSArray *allPlatformList = [XMHFormDataCreate platformList];
        if ([newCouponModel.platform isKindOfClass:[NSString class]] && [newCouponModel.platform isEqualToString:@"*"] ) { // 全部
            newCouponModel.platformDataArray = allPlatformList;
            newCouponModel.platform = @"全部渠道";
        } else { // 部分渠道
            // 获取选择的平台
            NSMutableArray *newAllPlatformList = NSMutableArray.new;
            newCouponModel.platformDataArray = newAllPlatformList;
            NSArray *platformIds = [newCouponModel.platform componentsSeparatedByString:@","];
            for (NSString *platformId in platformIds) {
                [allPlatformList enumerateObjectsUsingBlock:^(XMHItemModel * _Nonnull itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([itemModel.idStr isEqualToString:platformId]) {
                        [newAllPlatformList addObject:itemModel];
                    }
                }];
            }
            
            // 拼接平台名称
            NSMutableString *str = NSMutableString.new;
            for (int i = 0; i < newCouponModel.platformDataArray.count; i++) {
                XMHItemModel *itemMdoel = newCouponModel.platformDataArray[i];
                if (i == newCouponModel.platformDataArray.count - 1) {
                    [str appendFormat:@"%@", itemMdoel.title];
                } else {
                    [str appendFormat:@"%@,", itemMdoel.title];
                }
            }
            newCouponModel.platform = str;
        }
        
        //------- 支付使用 -------
        NSDictionary *payDic = [XMHCouponModel getRulesType:5 rules:model.data[@"rules"]];
        NSString *payInfo = payDic[@"condition1"];
        newCouponModel.payModel = [XMHCouponPayInfoModel yy_modelWithJSON:payInfo];
        
        if (complete) complete(newCouponModel);
    }];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHCouponModel * model = [_dataArr safeObjectAtIndex:indexPath.row];
    
    XMHACCouponListCell *cell = [XMHACCouponListCell createCellWithTable:tableView];
    [cell resetMarkLine];
    [cell configureWithModel:model];
    __weak typeof(self) _self = self;
    cell.didSelectClickBlock = ^(XMHACCouponListCell * _Nonnull cell, XMHCouponListStateItemModel *couponListStateItemModel) {
        __strong typeof(_self) self = _self;
        [self didSelectToolActionTableView:self.tableView model:model toolItemModel:couponListStateItemModel];
    };
    
    if (indexPath.row == (_dataArr.count - 1)) {
        [cell updataMarkLine];
    }

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    headerView.backgroundColor = UIColor.clearColor;
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     XMHCouponModel *couponModel = [_dataArr safeObjectAtIndex:indexPath.row];
    
    [self getCpuponDataCouponModel:couponModel complete:^(XMHCouponModel *newCouponModel) {
        XMHFormVC *formVc = XMHFormVC.new;
        formVc.edit = NO;
        formVc.couponModel = newCouponModel;
        formVc.couponType = [newCouponModel.type integerValue];
        formVc.createType = XMHActionCreateTypeChaKan;
        [self.nc pushViewController:formVc animated:YES];
    }];
}

- (void)didSelectToolActionTableView:(UITableView *)tableview  model:(id)model toolItemModel:(XMHCouponListStateItemModel *)toolItemModel
{
   
    switch (toolItemModel.tag) {
        case XMHCounponFunctionTypeTingYong:
            {
                [self tingYongrCouponModel:model];
            }
            break;
        case XMHCounponFunctionTypeQiYong:
        {
            [self qiYongrCouponModel:model];
        }
            break;
        case XMHCounponFunctionTypeXiuGai:
        {
            XMHCouponModel *couponModel = model;
            
            __weak typeof(self) _self = self;
            [self getCpuponDataCouponModel:couponModel complete:^(XMHCouponModel *newCouponModel) {
                __strong typeof(_self) self = _self;
                XMHFormVC *formVc = XMHFormVC.new;
                formVc.edit = YES;
                formVc.couponModel = newCouponModel;
                formVc.couponType = [newCouponModel.type integerValue];
                formVc.createType = XMHActionCreateTypeEdit;
                [self.nc pushViewController:formVc animated:YES];
            }];
        }
            break;
        case XMHCounponFunctionTypeXiuGaiKuCun:
        {
            [self xiuGaiKuCunCouponModel:model];
        }
            break;
        case XMHCounponFunctionTypeShare:
        {
           
            [self shareCouponModel:model];
        }
            break;
        case XMHCounponFunctionTypeDelete:
        {
            
            [self deleteCouponModel:model];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -- event

/**
 停用

 @param model XMHCouponModel
 */
- (void)tingYongrCouponModel:(XMHCouponModel *)model
{
  /*  [[[XMHSuccessAlertView alloc]initWithTitle:@"是否停用此张优惠券" withTwoBtnclick:^(NSInteger index) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:model.uid forKey:@"id"];
            [params setValue:@(2) forKey:@"type"];
            XMHActionCenterRequest *request = [[XMHActionCenterRequest alloc]init];
            [request requestCouponListPutInParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (isSuccess) {
                    _page = 1;
                    [_dataArr removeAllObjects];
                    [self requestListDataParmas:_currentParams];
                    [XMHProgressHUD showOnlyText:@"停用成功"];
                    
                }
            }];
        }
    }]show];
*/
 
    [[[XMHSuccessAlertView alloc]initWithTitle:@"是否停用此张优惠券" withTwoBtnclick:^(NSInteger index) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:model.uid forKey:@"id"];
            [params setValue:@(2) forKey:@"type"];
            XMHActionCenterRequest *request = [[XMHActionCenterRequest alloc]init];
            [request requestCouponListPutInParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (isSuccess) {
                    id data = [result safeObjectForKey:@"data"];
                    if ([data isKindOfClass:[NSDictionary class]]) {
                        NSArray *list = [data safeObjectForKey:@"list"];
                        [[[XMHSuccessAlertView alloc]initWithTitle:@"这张优惠券正在被使用中不能停用,请先取消绑定再下线！" tableViewDataSource:list sureButtonTitle:@"我知道了" click:^(NSInteger index) {
                            if (index == 1) {
                                _page = 1;
                                [_dataArr removeAllObjects];
                                [self requestListDataParmas:_currentParams];
                            }
                        }]show];
                    }else if ([data isKindOfClass:[NSString class]]){
                        _page = 1;
                        [_dataArr removeAllObjects];
                        [self requestListDataParmas:_currentParams];
                        [XMHProgressHUD showOnlyText:@"停用成功"];
                    }
                }
            }];
        }
    }]show];
}
/**
 启用
 
 @param model XMHCouponModel
 */
- (void)qiYongrCouponModel:(XMHCouponModel *)model
{
    [[[XMHSuccessAlertView alloc]initWithTitle:@"是否启用此张优惠券" withTwoBtnclick:^(NSInteger index) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:model.uid forKey:@"id"];
            [params setValue:@(1) forKey:@"type"];
            XMHActionCenterRequest *request = [[XMHActionCenterRequest alloc]init];
            [request requestCouponListPutInParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (isSuccess) {
                     _page = 1;
                    [_dataArr removeAllObjects];
                    [self requestListDataParmas:_currentParams];
                    [XMHProgressHUD showOnlyText:@"启用成功"];
                    
                    
                }
            }];
        }
    }]show];
}

/**
 修改库存
 
 @param model XMHCouponModel
 */
- (void)xiuGaiKuCunCouponModel:(XMHCouponModel *)model
{

  XMHSuccessAlertView *alertView =  [[XMHSuccessAlertView alloc]initWithTextFieldTitle:@"请输入库存" leftButtonTitle:@"取消" rightButtonTitle:@"保存" click:^(NSInteger index, NSString * _Nonnull text) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:model.uid forKey:@"id"];
            [params setValue:text ? text:@"" forKey:@"num"];
            XMHActionCenterRequest *request = [[XMHActionCenterRequest alloc]init];
            [request requestCouponListStockParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (isSuccess) {
                     _page = 1;
                    [_dataArr removeAllObjects];
                    [self requestListDataParmas:_currentParams];
                    [XMHProgressHUD showOnlyText:@"入库成功"];
                    
                }
            }];
            
        }
  }];
   alertView.kucunLimit = YES;
   [alertView show];
    
}

/**
 分享
 
 @param model XMHCouponModel
 */
- (void)shareCouponModel:(XMHCouponModel *)model
{
    WeakSelf
    _shareView = loadNibName(@"XMHACShareView");
    _shareView.shareViewOnlick = ^(NSInteger index) {
        
        XMHCouponModel *couponModel = (XMHCouponModel *)model;
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        NSString* thumbURL =  couponModel.shop_logo;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:couponModel.share_title descr:couponModel.sub_title thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl =couponModel.pic;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //UMSocialPlatformType_WechatTimeLine  UMSocialPlatformType_WechatSession
        UMSocialPlatformType UMSocialPlatformType = UMSocialPlatformType_WechatSession;
        if (index == 1) {
            UMSocialPlatformType = UMSocialPlatformType_WechatTimeLine;
        }
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType messageObject:messageObject currentViewController:weakSelf completion:^(id data, NSError *error) {
            
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);

                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [weakSelf alertWithError:error];
        }];
    };
    [_shareView show];
}

/**
 删除

 @param model XMHCouponModel
 */
- (void)deleteCouponModel:(XMHCouponModel *)model
{
    [[[XMHSuccessAlertView alloc]initWithTitle:@"是否删除此商品" withTwoBtnclick:^(NSInteger index) {
        if (index == 1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:model.uid forKey:@"id"];
            XMHActionCenterRequest *request = [[XMHActionCenterRequest alloc]init];
            [request requestCouponListDelTicketParams:params resultBlock:^(NSDictionary * _Nonnull result, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                if (isSuccess) {
                    _page = 1;
                    [_dataArr removeAllObjects];
                    [self requestListDataParmas:_currentParams];
                    [XMHProgressHUD showOnlyText:@"删除成功"];
                    
                    
                }
            }];
        }
    }]show];
}

- (void)alertWithError:(NSError *)error
{
    [self.shareView dismiss];
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

#pragma clang diagnostic pop
