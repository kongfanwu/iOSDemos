//
//  XMHBillRecDetailVC.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/23.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecDetailVC.h"
#import "XMHBillRecDetailView.h"
@interface XMHBillRecDetailVC ()
@property (nonatomic, strong) XMHBillRecDetailView *detailAlertView;
@end

@implementation XMHBillRecDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    self.detailAlertView = [[XMHBillRecDetailView alloc]initWithFrame:self.view.bounds];
    self.detailAlertView.billRecModel = self.billRecModel;
    __weak typeof(self) _self = self;
    self.detailAlertView.closeBlock = ^{
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    self.detailAlertView.sureBlock = ^(id  _Nonnull model) {
          __strong typeof(_self) self = _self;
        if (self.selectBlock) {
            self.selectBlock(model);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:self.detailAlertView];
    
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
