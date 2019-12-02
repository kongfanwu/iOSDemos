//
//  XMHOpenOederBaseVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@class XMHSegmentVCManager;
@class CustomerModel;
@class XMHShoppingCartView;
@class XMHCustomerInfoView;
@class XMHOrderSearchCustomerVC;
NS_ASSUME_NONNULL_BEGIN

@interface XMHOpenOederBaseVC : BaseCommonViewController

@property (nonatomic, strong) XMHSegmentVCManager *segmentVCManager;

@property (nonatomic, strong) XMHShoppingCartView *shoppingCart;

@property (nonatomic, strong) XMHCustomerInfoView *customerInfoView;

@property (nonatomic, strong, nullable) XMHOrderSearchCustomerVC *searchVC;
/**
 获取侧边栏数据,子类重写
 */
- (void)loadSidebarSData;

/**
 通过已选顾客,获取对应数据,子类重写

 @param selectModel 顾客
 */
- (void)reloadBaseViewSelectModel:(nullable CustomerModel *)selectModel;
@end

NS_ASSUME_NONNULL_END
