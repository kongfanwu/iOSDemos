//
//  XMHVipDiscountVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHVipDiscountVC.h"
#import "XMHSaleOrderRequest.h"
#import "XMHVipDiscountDetailBaseView.h"
#import "ZheKouModel.h"

@interface XMHVipDiscountVC ()
@property (nonatomic, strong) NSMutableArray *zheKouStoredCards;//会员折扣数据
@end

@implementation XMHVipDiscountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestVipDiscount];
}

/*
会员优惠列表
*/
- (void)requestVipDiscount
{
    WeakSelf
    [XMHSaleOrderRequest requestSaleOrderVipDiscountParams:self.params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        weakSelf.zheKouStoredCards =  resultArr;
        [weakSelf createSubViews];
    }];
}

/**
 展示会员优惠界面
 */

- (void)createSubViews
{
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackBtn bk_addEventHandler:^(id sender) {
        if (_selectedModel) {
            _selectedModel(_zhekouModel);
        }
    } forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:blackBtn];
    
    [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(179);
    }];
   CGRect rect = CGRectMake(0, 179, SCREEN_WIDTH, SCREEN_HEIGHT - 179);
    
    XMHVipDiscountDetailBaseView *view = [[XMHVipDiscountDetailBaseView alloc]initWithFrame:rect zheKouStoredCards:self.zheKouStoredCards model:self.zhekouModel];
    view.detailModel = self.detailModel;
    view.zhekouModel = self.zhekouModel;
    view.selectedModel = ^(ZheKouStored_Card * model) {
        if (_selectedModel) {
            _selectedModel(model);
        }
    };

    [self.view addSubview:view];
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
