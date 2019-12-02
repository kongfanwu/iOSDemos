//
//  XMHCouponDetailVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponDetailVC.h"
#import "XMHAvailableCouponsTableView.h"
#import "XMHUnAvailableCouponsUITableView.h"
#import "XMHSaleOrderRequest.h"
#import "SATicketListModel.h"
#import "XMHCouponDetailView.h"
#import "XMHShoppingCartManager.h"

@interface XMHCouponDetailVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *availaArr;
@property (nonatomic, strong) NSMutableArray *unAvailaArr;
@property (nonatomic, strong) NSMutableArray *zheKouStoredCards;//会员折扣数据


@end

@implementation XMHCouponDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self createSubViews];
    self.availaArr = [NSMutableArray array];
    self.unAvailaArr = [NSMutableArray array];
    self.zheKouStoredCards = [NSMutableArray array];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestCouponTicketData];
}
- (void)createSubViews
{
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackBtn bk_addEventHandler:^(id sender) {
        if (_selectedCouponsModel) {
            _selectedCouponsModel(_model);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:blackBtn];
    
    [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(179);
    }];
    WeakSelf;
    CGRect rect = CGRectMake(0, 179, SCREEN_WIDTH, SCREEN_HEIGHT - 179);
    XMHCouponDetailView *view = [[XMHCouponDetailView alloc]initWithFrame:rect availaCouponArr:self.availaArr unAavailaCouponArr:_unAvailaArr];
    view.model = self.model;
    view.selectedCouponsModel = ^(SATicketModel * _Nonnull ticketModel) {
        weakSelf.model = ticketModel;
        if (_selectedCouponsModel) {
            _selectedCouponsModel(ticketModel);
        }
    };
    [self.view addSubview:view];
    
}
#pragma mark --request

/*
优惠券列表
*/
- (void)requestCouponTicketData
{
    NSMutableArray *selectedTickets = [XMHShoppingCartManager.sharedInstance selectedTicketArrsBaseModel:self.detailModel];
    NSMutableArray *arr = [NSMutableArray array];
    [XMHSaleOrderRequest requestSaleOrderVipTicketParams:self.params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            
            for (int i = 0; i < resultArr.count; i++) {
                SATicketModel *model = [resultArr safeObjectAtIndex:i];
                
                if ([model.is_use integerValue] == 1) {
                    [arr safeAddObject:model];
                }else{
                    [self.unAvailaArr safeAddObject:model];
                }
            }
            
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
            if (selectedTickets.count > 0) {
                for (int i = 0; i < arr.count; i++) {
                    SATicketModel *model = [arr safeObjectAtIndex:i];
                    for (int j = 0; j < selectedTickets.count; j++) {
                        SATicketModel *selectModel = [selectedTickets safeObjectAtIndex:j];
                        if (selectModel.uid == model.uid) {
                            [tempArr removeObject:model];
                        }
                    }
                }
            }
            self.availaArr = tempArr;
            [self createSubViews];
        }
    }];
    
    
}

@end
