//
//  XMHBillRecoveryVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecoveryVC.h"
#import "XMHSegmentVCModel.h"
#import "CustomerListModel.h"
#import "XMHSegmentVCManager.h"
#import "XMHBillRecoveryOrderRequest.h"
#import "XMHBillRecoveryListModel.h"
#import "XMHBillRecContentVC.h"
#import "XMHShoppingCartManager.h"
#import "XMHShoppingCartView.h"
#import "XMHBillReListModel.h"
#import "XMHShoppingCartManager.h"
#import "XMHBillRecoverStatisticVC.h"
#import "XMHOrderSearchCustomerVC.h"
#import "XMHCustomerInfoView.h"
@interface XMHBillRecoveryVC()
@property (nonatomic, strong) NSMutableArray *sidebarData;
@property (nonatomic, strong) CustomerModel *selectModel;
@property (nonatomic, strong) NSMutableArray *shoppingCartArr;
@end

@implementation XMHBillRecoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"回收置换" backBtnShow:YES];
    self.sidebarData = [NSMutableArray array];
    WeakSelf
    self.shoppingCart.shoppingCart = ^(NSMutableArray * _Nonnull modelArr) {
        [weakSelf staticModelTransFormCartModelArr:modelArr];
    
    };
    
    [self.customerInfoView setSearchBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        weakSelf.searchVC = [[XMHOrderSearchCustomerVC alloc]init];
        weakSelf.searchVC.fromRecoverBill = YES;
        weakSelf.searchVC.selectedCustomer = ^(CustomerModel * _Nonnull model) {
            NSString *phone = [model.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            NSString *infoStr = [NSString stringWithFormat:@"%@ (%@)",model.uname,phone];
            [customerInfoView configUserName:infoStr];
            [weakSelf reloadBaseViewSelectModel:model];
            weakSelf.searchVC = nil;
        };
        [weakSelf presentViewController:weakSelf.searchVC animated:YES completion:nil];
        
    }];
    [self.customerInfoView setDeleteUserBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        [weakSelf reloadBaseViewSelectModel:nil];
    }];
}

/**
 获取侧边栏数据
 */
- (void)loadSidebarSData{
    WeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"2" forKey:@"type"];
    if (!self.selectModel) {
        [params setValue:@"3" forKey:@"type"];
    }else{
        [params setValue:@"2" forKey:@"type"];
        [params setValue:@(self.selectModel.uid) forKey:@"user_id"];
    }
    [XMHBillRecoveryOrderRequest requestBillRecoverySidebarParams:params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        
        if (isSuccess) {
            weakSelf.sidebarData = resultArr;
             [self reloadContentTab];
        }

    }];
    
}
- (void)reloadContentTab{
   
     NSMutableArray *dataArray = NSMutableArray.new;
     [self.segmentVCManager.dataArray removeAllObjects];
        for (int i = 0; i < self.sidebarData.count; i++) {
            XMHBillRecoveryModel *recoverModel = [self.sidebarData safeObjectAtIndex:i];
            XMHSegmentVCModel *model = XMHSegmentVCModel.new;
            UIViewController *vc = UIViewController.new;
            model.text = recoverModel.name;
            if (!self.selectModel) { //没有选择联系人时不展示右侧数据
                self.shoppingCart.isEdit = NO;//购物车不能点击
                model.edit = NO;
                model.contentVC = vc;
                if (i == 0) {
                    model.select = YES;
                }
                [dataArray safeAddObject:model];
                [XMHShoppingCartManager.sharedInstance.dataArray removeAllObjects];
                [XMHShoppingCartManager.sharedInstance clear];

            }else{
                model.edit = YES;
                if (i == 0) {
                    model.select = YES;
                }
                WeakSelf
                XMHBillRecContentVC *contentBaseVC = [[XMHBillRecContentVC alloc]initUserId:[NSString stringWithFormat:@"%ld",self.selectModel.uid ]type:recoverModel.type name:recoverModel.name];
                model.contentVC = contentBaseVC;
                contentBaseVC.nav = self.navigationController;
                contentBaseVC.addShoppingCartBlock = ^(id  _Nonnull model) {
                    [weakSelf shoppingCartModel:model];
                };
                [dataArray safeAddObject:model];
            }
        }

    self.segmentVCManager.dataArray = dataArray;
    
}

- (void)reloadBaseViewSelectModel:(CustomerModel *)selectModel
{
    self.selectModel = selectModel;
    [self loadSidebarSData];
}
#pragma mark -- 添加购物车
- (void)shoppingCartModel:(id)model
{
    XMHShoppingCartManager *manager = [XMHShoppingCartManager sharedInstance];
    [manager addModel:model];
    
}

/**
 转换成结算统计model
 */
-(void)staticModelTransFormCartModelArr:(NSMutableArray *)modelArr
{
    
    CGFloat totalPrice = 0;
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (id model in modelArr) {
        XMHBillRecoveryStatiscModel *statiModel = XMHBillRecoveryStatiscModel.new;
        if ([model isKindOfClass:[XMHBillReProModel class]]) {
            XMHBillReProModel *pro = (XMHBillReProModel *)model;
            statiModel.name = pro.name;
            statiModel.uid = pro.uid;
            statiModel.price = [NSString stringWithFormat:@"%.2f",pro.recoverPrice];//[NSString stringWithFormat:@"%f",[pro computeTotalPrice]];
            statiModel.num = [NSString stringWithFormat:@"%ld",(long)pro.selectCount];
            statiModel.code = pro.code;
            statiModel.type = @"pro";
            totalPrice += [statiModel.price floatValue];
            
        }else if ([model isKindOfClass:[XMHBillReGoodsModel class]]) {
            XMHBillReGoodsModel *pro = (XMHBillReGoodsModel *)model;
            statiModel.name = pro.name;
            statiModel.uid = pro.uid;
            statiModel.price = [NSString stringWithFormat:@"%.2f",pro.recoverPrice] ;//[pro computeTotalPrice]
            statiModel.num = [NSString stringWithFormat:@"%ld",(long)pro.selectCount];
            statiModel.type = @"goods";
            statiModel.code = pro.code;
            totalPrice += [statiModel.price floatValue];//[pro computeTotalPrice];
            
        }else if ([model isKindOfClass:[XMHBillReCardModel class]]){
            XMHBillReCardModel *pro = (XMHBillReCardModel *)model;
            statiModel.name = pro.name;
            statiModel.uid = pro.user_card_id;
            statiModel.price = [NSString stringWithFormat:@"%.2f",[pro computeTotalPrice]] ;
            statiModel.num = [NSString stringWithFormat:@"%ld",(long)pro.selectCount];
            statiModel.type = @"stored_card";
            statiModel.code = pro.code;
             totalPrice += [pro computeTotalPrice];
        }
        else if ([model isKindOfClass:[XMHBillReTimeModel class]]){
            XMHBillReTimeModel *pro = (XMHBillReTimeModel *)model;
            statiModel.name = pro.name;
            statiModel.uid = pro.uid;
            statiModel.price = [NSString stringWithFormat:@"%.2f",[pro computeTotalPrice]] ;
            statiModel.num = [NSString stringWithFormat:@"%ld",pro.selectCount];
            statiModel.type = @"card_time";
            statiModel.code = pro.code;
             totalPrice += [pro computeTotalPrice];
        }
        else if ([model isKindOfClass:[XMHBillReNumCardModel class]]){
            XMHBillReNumCardModel *pro = (XMHBillReNumCardModel *)model;
            statiModel.name = pro.name;
            statiModel.uid = pro.uid;
            statiModel.price = [NSString stringWithFormat:@"%.2f",pro.recoverPrice];//[NSString stringWithFormat:@"%.2f",[pro computeTotalPrice]] ;
            statiModel.num = [NSString stringWithFormat:@"%ld",pro.selectCount];
            statiModel.type = @"card_num";
            statiModel.code = pro.code;
             totalPrice += [statiModel.price floatValue];
        }
        else if ([model isKindOfClass:[XMHBillReTicketModel class]]){
            XMHBillReTicketModel *pro = (XMHBillReTicketModel *)model;
            statiModel.name = pro.name;
            statiModel.uid = pro.uid;
            statiModel.price = [NSString stringWithFormat:@"%.2f",pro.recoverPrice] ;
            statiModel.num = [NSString stringWithFormat:@"%ld",pro.selectCount];
            statiModel.type = @"ticket";
            statiModel.code = pro.code;
            totalPrice += [statiModel.price floatValue];
        }
        
        [dataArr safeAddObject:statiModel];
    }
    
    XMHBillRecoverStatisticVC *vc = [[XMHBillRecoverStatisticVC alloc]init];
    vc.selectUserModel = self.selectModel;
    vc.dataArr = dataArr;
    vc.totalPrice = [NSString stringWithFormat:@"%.2f",totalPrice];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)dealloc
{
    [XMHShoppingCartManager.sharedInstance clear];
}
@end
