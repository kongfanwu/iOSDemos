//
//  LDeatailSendView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/4.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDeatailSendView.h"
#import "LDeatailSelectView.h"
#import "OnLineRequest.h"
#import "ExpressListModel.h"
@implementation LDeatailSendView
{
    LDeatailSelectView * _selectView;
    ExpressListModel * _listModel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews];
        [self requestExpress];
    }
    return self;
}
- (void)initSubViews
{
    [self createBG];
    [self createSelectView];
}
- (void)createBG
{
    UIView * view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor darkGrayColor];
    view.alpha = 0.7;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view addGestureRecognizer:tap];
    [self addSubview:view];
}
- (void)tap
{
    [self removeFromSuperview];
}
- (void)createSelectView
{
    LDeatailSelectView * selectView = [[[NSBundle mainBundle]loadNibNamed:@"LDeatailSelectView" owner:nil options:nil]lastObject];
    [selectView.btnSure addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [selectView.btnCancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    selectView.frame = CGRectMake(0, SCREEN_HEIGHT - 280 , SCREEN_WIDTH, 280);
//    [selectView.tfKuaiDi setupData:@[@"申通",@"顺丰",@"中通",@"韵达"]];
    _selectView = selectView;
    [self addSubview:selectView];
}
- (void)click:(UIButton *)btn
{
    NSString * code = @"";
    if (btn.tag ==300) {//取消
        
    }else{//确定
        for (ExpressModel * model in _listModel.list) {
            if ([_selectView.tfKuaiDi.text isEqualToString:model.name]) {
                code = model.code;
            }
        }
        if (_LDeatailSendViewBlock) {
            _LDeatailSendViewBlock(code,_selectView.tfCode.text);
        }
    }
    [self tap];
}
- (void)requestExpress
{
    NSMutableArray * titles = [[NSMutableArray alloc] init];
    [OnLineRequest requestExpressResultBlock:^(ExpressListModel*model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _listModel = model;
            for (ExpressModel * sub in model.list) {
                [titles addObject:sub.name];
            }
            [_selectView.tfKuaiDi setupData:[[NSArray alloc] initWithArray:titles]];
        }
    }];
}
@end
