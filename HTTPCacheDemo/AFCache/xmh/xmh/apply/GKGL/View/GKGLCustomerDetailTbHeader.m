//
//  GKGLCustomerDetailTbHeader.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerDetailTbHeader.h"
#import "GKGLHomeCustomerListModel.h"
#import <YYWebImage/YYWebImage.h>
#import "NSString+Costom.h"
@interface GKGLCustomerDetailTbHeader ()<CAAnimationDelegate>
/** 顾客账单 */
@property (weak, nonatomic) IBOutlet UIView *viewZD;
/** 顾客画像 */
@property (weak, nonatomic) IBOutlet UIView *viewHX;
/** 顾客处方 */
@property (weak, nonatomic) IBOutlet UIView *viewCF;
/** 卡项普及 */
@property (weak, nonatomic) IBOutlet UIView *viewPJ;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *gukeState;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbClassW;

@property (weak, nonatomic) IBOutlet UILabel *lbClass;
@property (weak, nonatomic) IBOutlet UILabel *lbXF;
@property (weak, nonatomic) IBOutlet UIImageView *imgvEquity;
@end
@implementation GKGLCustomerDetailTbHeader
- (void)awakeFromNib
{
    [super awakeFromNib];
    _viewZD.tag = 1000;
    _viewHX.tag = 1001;
    _viewCF.tag = 1002;
    _viewPJ.tag = 1003;
    _icon.tag = 1004;
    _icon.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_viewZD addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_viewHX addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_viewCF addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_viewPJ addGestureRecognizer:tap4];
    
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_icon addGestureRecognizer:tap5];
    
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.layer.masksToBounds = YES;
    
    _gukeState.layer.cornerRadius = _gukeState.height/2;
//    _gukeState.layer.borderWidth = 1;
    _gukeState.layer.masksToBounds = YES;
    
    _lbClass.layer.masksToBounds = YES;
    _lbClass.backgroundColor = [UIColor whiteColor];
    _lbClass.layer.cornerRadius = _lbClass.height/2;
    _lbClass.textColor = [ColorTools colorWithHexString:@"#FF9072"];

    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shake.duration = 2;
    shake.autoreverses = YES;
    shake.repeatCount = 5;
    shake.removedOnCompletion = YES;
    shake.fromValue = [NSNumber numberWithFloat:0];
    shake.toValue = [NSNumber numberWithFloat:+20];
    [_imgvEquity.layer addAnimation:shake forKey:@"imageview"];
    _lbClass.layer.backgroundColor = [UIColor cyanColor].CGColor;
    
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 1000) {
        if (_GKGLCustomerDetailTbHeaderZDBlock) {
            _GKGLCustomerDetailTbHeaderZDBlock();
        }
    }else if (tap.view.tag == 1001) {
        if (_GKGLCustomerDetailTbHeaderHXBlock) {
            _GKGLCustomerDetailTbHeaderHXBlock();
        }
    }else if (tap.view.tag == 1002) {
        if (_GKGLCustomerDetailTbHeaderCFBlock) {
            _GKGLCustomerDetailTbHeaderCFBlock();
        }
    }else if (tap.view.tag == 1003) {
        if (_GKGLCustomerDetailTbHeaderPJBlock) {
            _GKGLCustomerDetailTbHeaderPJBlock();
        }
    }else if (tap.view.tag == 1004) {
        if (_GKGLCustomerDetailTbHeaderIconBlock) {
            _GKGLCustomerDetailTbHeaderIconBlock();
        }
    }else{}
}
- (void)updateGKGLCustomerDetailTbHeaderModel:(GKGLHomeCustomerModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _gukeState.text = model.zt;
    _lbName.text = model.name;
    _lbXF.text = model.show;
    _lbClass.text = model.grade_name;
    
    CGFloat w = [model.grade_name stringWidthWithFont:FONT_SIZE(10)];
    _lbClassW.constant = w + 15;
    
    
    if ([model.zt isEqualToString:@"活动顾客"]) {
        _gukeState.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _gukeState.textColor = [ColorTools colorWithHexString:@"#FF9072"];
        _gukeState.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
    }
    if ([model.zt isEqualToString:@"休眠顾客"]) {
        _gukeState.backgroundColor = [ColorTools colorWithHexString:@"#FFF7E8"];;
        _gukeState.textColor = [ColorTools colorWithHexString:@"#FFAF19"];
        _gukeState.layer.borderColor = [ColorTools colorWithHexString:@"#FFAF19"].CGColor;
        
    }
    if ([model.zt isEqualToString:@"流失顾客"]) {
        _gukeState.backgroundColor = kColorE5E5E5;
        _gukeState.textColor = kColor9;
        _gukeState.layer.borderColor = kColor9.CGColor;
    }
    if (model.zt.length ==0) {
        _gukeState.hidden = YES;
    }
}
- (void)updateGKGLCustomerDetailTbHeaderParamDic:(NSDictionary *)param
{
    NSString * equity = param[@"equity"];
    if (equity.length == 0) {
        _imgvEquity.hidden = YES;
    }
    if ([equity isEqualToString:@"普通权益"]) {
        _imgvEquity.image = UIImageName(@"gkgl_gkxqpuka");
    }else if ([equity isEqualToString:@"金卡权益"]){
        _imgvEquity.image = UIImageName(@"gkgl_gkxqjinka");
    }else if ([equity isEqualToString:@"钻石权益"]){
        _imgvEquity.image = UIImageName(@"gkgl_gkxqzuanshi");
    }else if ([equity isEqualToString:@"至尊权益"]){
        _imgvEquity.image = UIImageName(@"gkgl_gkxqzhizun");
    }else if ([equity isEqualToString:@"银卡权益"]){
        _imgvEquity.image = UIImageName(@"gkgl_gkxqjyinka");
    }else if ([equity isEqualToString:@"铂金权益"]){
        _imgvEquity.image = UIImageName(@"gkgl_gkxqbojin");
    }else if ([equity isEqualToString:@"女皇权益"]){
        _imgvEquity.image = UIImageName(@"gkgl_gkxqnvwang");
    }else{}
}
@end
