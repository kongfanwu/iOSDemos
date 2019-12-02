//
//  XMHSaleOrderDetailAlertVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderDetailAlertVC.h"
#import "XMHProSaleOrderDetailView.h"
#import "XMHGoodsSaleOrderDetailView.h"
#import "XMHCourseSaleOrderDetailView.h"
#import "XMHTicketSaleOrderDetailView.h"
#import "XMHRenewalCardDetailView.h"
#import "XMHSaleOrderBaseDetailView.h"

@interface XMHSaleOrderDetailAlertVC ()

@end

@implementation XMHSaleOrderDetailAlertVC
- (instancetype)initWithFrame:(CGRect)frame cardType:(NSString *)cardType detailModel:(SaleModel *)detailModel userId:(NSString *)userId storeCode:(NSString *)storeCode
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        
        UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [blackBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:blackBtn];
        
        [blackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(179);
        }];
        WeakSelf
        CGRect rect = CGRectMake(0, 179, SCREEN_WIDTH, SCREEN_HEIGHT - 179);
        XMHSaleOrderBaseDetailView *contentView ;
        if ([cardType isEqualToString:@"pro"]) {
            contentView = [[XMHProSaleOrderDetailView alloc]initWithFrame:rect userId:userId storeCode:storeCode type:cardType detailModel:detailModel];
        }else if ([cardType isEqualToString:@"goods"]){
            contentView = [[XMHGoodsSaleOrderDetailView alloc]initWithFrame:rect userId:userId storeCode:storeCode type:cardType detailModel:detailModel];
        }else if ([cardType isEqualToString:@"ticket"]){
            contentView = [[XMHTicketSaleOrderDetailView alloc]initWithFrame:rect userId:userId storeCode:storeCode type:cardType detailModel:detailModel];
        }else if ([cardType isEqualToString:@"skxk"]){
            contentView = [[XMHRenewalCardDetailView alloc]initWithFrame:rect userId:userId storeCode:storeCode type:cardType detailModel:detailModel];
        }else {
            contentView = [[XMHCourseSaleOrderDetailView alloc]initWithFrame:rect userId:userId storeCode:storeCode type:cardType detailModel:detailModel];
        }
        [contentView updateSubviews];
        contentView.selectedFinishBlock = ^(SaleModel * _Nonnull model) {
            if (weakSelf.selectedSaleModel) {
                weakSelf.selectedSaleModel(model);
                [weakSelf closeBtn];
            }
        };
        contentView.closeDetailView = ^{
            [weakSelf closeBtn];
        };
        
        [self.view addSubview:contentView];
    }
    return self;
}

- (void)closeBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
