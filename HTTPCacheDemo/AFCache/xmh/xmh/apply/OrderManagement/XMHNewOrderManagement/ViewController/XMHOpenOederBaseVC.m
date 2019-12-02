//
//  XMHOpenOederBaseVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOpenOederBaseVC.h"
#import "XMHOpenOrderSearchHeaderView.h"
#import "XMHOrderSearchCustomerVC.h"
#import "XMHCustomerInfoView.h"
#import "XMHOrderSearchCustomerVC.h"
#import "CustomerListModel.h"
#import "XMHSegmentVCManager.h"
#import "XMHShoppingCartView.h"
#import "XMHShoppingCartManager.h"
@interface XMHOpenOederBaseVC()

@property (nonatomic, strong) UIView *contentView;



@end

@implementation XMHOpenOederBaseVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    self.navView.backgroundColor = kBtn_Commen_Color;
    [self creatSubviews];
}

#pragma mark -- UI
- (void)creatSubviews
{
    WeakSelf
    
    //搜索顾客
    self.customerInfoView = [[XMHCustomerInfoView alloc] init];
    [self.view addSubview:_customerInfoView];
    [_customerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNaviBarHeight);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(63);
    }];
    
    [_customerInfoView setSearchBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        weakSelf.searchVC = [[XMHOrderSearchCustomerVC alloc]init];
        weakSelf.searchVC.selectedCustomer = ^(CustomerModel * _Nonnull model) {
            NSString *phone = model.mobile;
            if (model.mobile.length) {
                 phone = [model.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            }
           
            NSString *infoStr = [NSString stringWithFormat:@"%@ (%@)",model.uname,phone];
            [customerInfoView configUserName:infoStr];
            [weakSelf reloadBaseViewSelectModel:model];
            weakSelf.searchVC = nil;
        };
        [weakSelf presentViewController:weakSelf.searchVC animated:YES completion:nil];
        
    }];
    [_customerInfoView setDeleteUserBlock:^(XMHCustomerInfoView * _Nonnull customerInfoView) {
        [weakSelf reloadBaseViewSelectModel:nil];
    }];
    
    self.contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customerInfoView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
//        make.bottom.mas_equalTo(-49);
        make.bottom.mas_equalTo(-(kSafeAreaBottom + 49));
    }];
    
    
    self.segmentVCManager = XMHSegmentVCManager.new;
     _segmentVCManager.view.frame = _contentView.bounds;
    [self addChildViewController:self.segmentVCManager];
    [_contentView addSubview:self.segmentVCManager.view];
   // 购物车
    self.shoppingCart = [[XMHShoppingCartView alloc] init];
    _shoppingCart.submitButtonTitle = @"开始回收";
    _shoppingCart.isEdit = NO;
    _shoppingCart.enterType = ShoppingCartEenterType_BillRec;
    
   
    [self.view addSubview:_shoppingCart];
    [_shoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(-kSafeAreaBottom);
    }];
    [self loadSidebarSData];
  
  
}
- (void)loadSidebarSData{}
- (void)reloadBaseViewSelectModel:(nullable CustomerModel *)selectModel{}

@end
