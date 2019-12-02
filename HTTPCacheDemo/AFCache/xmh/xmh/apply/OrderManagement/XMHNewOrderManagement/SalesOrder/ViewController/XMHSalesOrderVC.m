//
//  XMHSalesOrderVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSalesOrderVC.h"
#import "XMHBillRecoveryOrderRequest.h"
#import "XMHSegmentVCModel.h"
#import "CustomerListModel.h"
#import "XMHSegmentVCManager.h"
#import "XMHBillRecoveryListModel.h"
#import "XMHSalesOrderContentVC.h"
#import "XMHShoppingCartView.h"
#import "MzzCustomerRequest.h"
#import "MzzStoreModel.h"
#import "XMHSaleOrderStatisticVC.h"
#import "XMHCustomerInfoView.h"
#import "XMHNormalOrderManagementVC.h"
@interface XMHSalesOrderVC ()
@property (nonatomic, strong) NSMutableArray *sidebarData;
//@property (nonatomic, strong) CustomerModel *selectModel;
//@property (nonatomic, copy) NSString *storeCode;// 门店编码
@end

@implementation XMHSalesOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"销售制单" backBtnShow:YES];
    WeakSelf
    self.shoppingCart.shoppingCart = ^(NSMutableArray * _Nonnull modelArr) {
        [weakSelf staticModelTransFormCartModelArr:modelArr];
        
    };
    
    [self getCustomerStoreCode];
    if (self.selectModel) {//从外部传入已选顾客
        [self.customerInfoView configUserName:[NSString stringWithFormat:@"%@ (%@)", self.selectModel.uname, [self.selectModel safeMobile]]];
    }

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.shoppingCart.submitButtonTitle = @"去支付";
//    self.shoppingCart.isEdit = NO;
    self.shoppingCart.enterType = ShoppingCartEenterType_SaleOrder;
    [self getCustomerStoreCode];
}
/**
 获取侧边栏数据
 */
- (void)loadSidebarSData{
    WeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"type"];
    [params setValue:@(self.selectModel.uid) forKey:@"user_id"];
    [XMHBillRecoveryOrderRequest requestBillRecoverySidebarParams:params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            weakSelf.sidebarData = resultArr;
            [weakSelf reloadContentTab];
        }
    }];
    
}

/**
 获取列表数据
 */
- (void)reloadContentTab{
    
    NSMutableArray *dataArray = NSMutableArray.new;
    [self.segmentVCManager.dataArray removeAllObjects];
    for (int i = 0; i < self.sidebarData.count; i++) {
        XMHBillRecoveryModel *recoverModel = [self.sidebarData safeObjectAtIndex:i];
        XMHSegmentVCModel *model = XMHSegmentVCModel.new;
        UIViewController *vc = UIViewController.new;
        model.text = recoverModel.name;
        if (!self.selectModel) {
            model.edit = NO;
            model.contentVC = vc;
            if (i == 0) {
                model.select = YES;
            }
            [dataArray safeAddObject:model];
        }else{
            model.edit = YES;
            if (i == 0) {
                model.select = YES;
            }
            NSString *userId = [NSString stringWithFormat:@"%ld",(long)self.selectModel.uid];
            XMHSalesOrderContentVC *contentBaseVC = [[XMHSalesOrderContentVC alloc]initUserId:userId type:recoverModel.type name:recoverModel.name];
            model.contentVC = contentBaseVC;
            contentBaseVC.storeCode  = self.storeCode;

            [dataArray safeAddObject:model];
        }
    }
    
    self.segmentVCManager.dataArray = dataArray;
    
}
#pragma mark -已选顾客

- (void)reloadBaseViewSelectModel:(CustomerModel *)selectModel
{
    self.selectModel = selectModel;
    [self loadSidebarSData];
//    [self reloadContentTab];
}
#pragma mark -- 购物车
- (void)staticModelTransFormCartModelArr:(id)modelArr
{
    // 将已选顾客传过去
    XMHSaleOrderStatisticVC *vc = [[XMHSaleOrderStatisticVC alloc]init];
    vc.store_code = self.storeCode;
    vc.customer = self.selectModel;
    vc.yingfuPrice = self.yingfuPrice;
    vc.ordernum = self.ordernum;
    vc.saleModelList = modelArr;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -- layz
- (NSMutableArray *)sidebarData
{
    if (!_sidebarData) {
        _sidebarData = [NSMutableArray array];
    }
    return _sidebarData;
}
#pragma mark - request
/**
 获取门店编码
 */
-(void)getCustomerStoreCode
{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    //门店归属
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            MzzStoreList *storeList = listModel;
            MzzStoreModel *selectStoreModel = storeList.list[0];
            self.storeCode = selectStoreModel.store_code;
//            [self requestData];
        }
    }];
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
