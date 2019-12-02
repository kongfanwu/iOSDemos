//
//  GuideView.m
//  xmh
//
//  Created by ald_ios on 2018/10/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GuideView.h"
#import "RolesTools.h"
@interface GuideView ()
@end
@implementation GuideView
{
    NSString * _module;
    NSDictionary * _guideDict;
    UIScrollView *_scrollView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _guideDict = @{@"YYGL":@{@"yygl_guanli":@[@"yygl_guanli1",@"yygl_guanli2"],@"yygl_dianzhang":@[@"yygl_dianzhang1",@"yygl_dianzhang2"],@"yygl_yuangong":@[@"yygl_yuangong1",@"yygl_yuangong2"],@"yygl_qiantai":@[@"yygl_qiantai1"]},@"DDGL":@{@"ddgl_guanli":@[@"ddgl_guanli1",@"ddgl_guanli2"],@"ddgl_dianjingli":@[@"ddgl_dianjingli1",@"ddgl_dianjingli2"],@"ddgl_dianzhang":@[@"ddgl_dianzhang1",@"ddgl_dianzhang2"]},@"GKGL":@{@"gkgl_guanli":@[@"gkgl_guanli1",@"gkgl_guanli2"],@"gkgl_dianjingli":@[@"gkgl_dianjingli1",@"gkgl_dianjingli2",@"gkgl_dianjingli3"],@"gkgl_xsjsdianzhang":@[@"gkgl_xsjsdianzhang1",@"gkgl_xsjsdianzhang2"],@"gkgl_sqdianzhang":@[@"gkgl_sqdianzhang1"],@"gkgl_qiantai":@[@"gkgl_qiantai1",@"gkgl_qiantai2"],@"gkgl_yuangong":@[@"gkgl_yuangong1",@"gkgl_yuangong2"]},@"MLDZ":@{@"1":@[],@"1":@[],@"1":@[]},};
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
        [self addSubview:_scrollView];
    }
    return self;
}
- (void)showGuideViewModule:(NSString *)module
{
    _module = module;
    NSString * markStr = @"";
    NSString * mainrole = [NSString stringWithFormat:@"%ld",[RolesTools getUserMainRole]];
    if ([_module isEqualToString:@"YYGL"]) {
        /** 管理层 */
        if (mainrole.integerValue == 1) {
            markStr = @"yygl_guanli";
        }
        /** 前台店长 */
        if (mainrole.integerValue == 4||mainrole.integerValue == 5||mainrole.integerValue == 6) {
            markStr = @"yygl_dianzhang";
        }
        /** 员工 */
        if (mainrole.integerValue == 8||mainrole.integerValue == 9||mainrole.integerValue == 10) {
            markStr = @"yygl_yuangong";
        }
        /** 前台 */
        if (mainrole.integerValue == 7) {
            markStr = @"yygl_qiantai";
        }
    }
    if ([_module isEqualToString:@"DDGL"]) {
        /** 管理层 */
        if (mainrole.integerValue == 1) {
            markStr = @"ddgl_guanli";
        }
        /** 店经理 */
        if (mainrole.integerValue == 3) {
            markStr = @"ddgl_dianjingli";
        }
        /** 前台店长员工 */
        if (mainrole.integerValue == 4||mainrole.integerValue == 5||mainrole.integerValue == 6||mainrole.integerValue == 7||mainrole.integerValue == 8||mainrole.integerValue == 9||mainrole.integerValue == 10) {
            markStr = @"ddgl_dianzhang";
        }
    }
    if ([_module isEqualToString:@"GKGL"]) {
        /** 管理层 */
        if (mainrole.integerValue == 1) {
            markStr = @"gkgl_guanli";
        }
        /** 店经理 */
        if (mainrole.integerValue == 3) {
            markStr = @"gkgl_dianjingli";
        }
        /** 销售店长 技术店长 */
        if (mainrole.integerValue == 4||mainrole.integerValue == 5) {
            markStr = @"gkgl_xsjsdianzhang";
        }
        /** 售前店长 */
        if (mainrole.integerValue == 6) {
            markStr = @"gkgl_sqdianzhang";
        }
        /** 前台 */
        if (mainrole.integerValue == 7) {
            markStr = @"gkgl_qiantai";
        }
        /** 员工 */
        if (mainrole.integerValue == 8||mainrole.integerValue == 9||mainrole.integerValue == 10) {
            markStr = @"gkgl_yuangong";
        }
    }
    
    NSArray * guideArr =  _guideDict[module][markStr];
    _scrollView.contentSize = CGSizeMake(guideArr.count * SCREEN_WIDTH, 0);
    for (int i = 0; i < guideArr.count ; i++) {
        //建立分页
        UIImageView *newfeature = [[UIImageView alloc] init];
        //设置tag方便确定滚到到了第几页
        newfeature.tag = i;
        CGFloat nfViewW = SCREEN_WIDTH;
        CGFloat nfViewH = SCREEN_HEIGHT;
        CGFloat nfViewY = 0;
        CGFloat nfViewX = i * nfViewW;
        newfeature.frame = CGRectMake(nfViewX, nfViewY, nfViewW, nfViewH);
        UIImage * img = UIImageName(guideArr[i]);
        if (IS_IPHONE_X) {
            [newfeature setImage:img];
        }else{
            [newfeature setImage:img];
        }
        [_scrollView addSubview:newfeature];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:_module]) {
        
    }else{
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_module];
    }
}
- (void)click:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}
@end
