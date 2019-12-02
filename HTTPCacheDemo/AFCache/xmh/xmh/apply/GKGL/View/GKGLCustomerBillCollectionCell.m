//
//  GKGLCustomerBillCollectionCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillCollectionCell.h"
#import "NSString+Costom.h"
@interface GKGLCustomerBillCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLeftW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnRightW;

@end
@implementation GKGLCustomerBillCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_btnLeft setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    [_btnRight setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    _btnRight.backgroundColor = _btnLeft.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
    _btnRight.titleLabel.font = _btnLeft.titleLabel.font = FONT_SIZE(10);
    _btnRight.layer.cornerRadius = _btnLeft.layer.cornerRadius = 2;
    _btnRight.layer.masksToBounds = _btnLeft.layer.masksToBounds = YES;
    
    _btnLeft.userInteractionEnabled = _btnRight.userInteractionEnabled = NO;
}
- (void)updateGKGLCustomerBillCollectionCellParamDic:(NSDictionary *)param type:(nonnull NSString *)type
{
    _lbName.text = param[@"name"];
    _lbValue.hidden = YES;
    if ([type isEqualToString:@"bank"]) {
       _lbName.text = @"账户";
        _lbValue.hidden = _btnRight.hidden = _btnLeft.hidden = YES;
        
    }
    
    if ([type isEqualToString:@"stored_card"]) {
        _lbName.text = param[@"stored_card_name"];        
    }
    if ([type isEqualToString:@"ticket_coupon"]) {
        NSString * ticketName = @"";
        if ([param[@"type"] integerValue] == 3) {
            ticketName = @"现金券";
            /** 1、如果fulfill有值 显示 fulfill-price   2、如果fulfill没有值 显示 price */
            if ([param[@"fulfill"] integerValue]==0) {
                _lbValue.text = [NSString stringWithFormat:@"%@元",param[@"price"]];
            }else{
                _lbValue.text = [NSString stringWithFormat:@"%@-%@元",param[@"fulfill"],param[@"price"]];
            }
           
        }else if ([param[@"type"] integerValue] == 4){
            ticketName = @"折扣券";
            _lbValue.text = [NSString stringWithFormat:@"%@折",param[@"discount"]];
        }else if ([param[@"type"] integerValue] == 5){
            ticketName = @"礼品券";
            _lbValue.text = param[@"name"];
        }else{}
        _lbName.text = ticketName;
        NSString * title = @"";
        if (!param[@"status"]) {
            return;
        }
        if ([param[@"status"] integerValue] == 1) {
            title = @"未使用";
        }else if ([param[@"status"] integerValue] == 2) {
            title = @"已用完";
        }else if ([param[@"status"] integerValue] == 3) {
            title = @"已过期";
        }else{}
        NSString * leftTitle = title;
        CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
        if ([leftTitle isEqualToString:@""]) {
            _btnLeftW.constant = leftBtnW;
        }else{
            _btnLeftW.constant = leftBtnW + 5;
        }
        NSString * rightTitle = @"";
       
        CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnRight setTitle:rightTitle forState:UIControlStateNormal];
        _btnRightW.constant = rightBtnW + 5;
        
        _btnRight.hidden = NO;
        _lbValue.hidden = NO;
        if ([param[@"jh_zt"] integerValue] == 0) {
            rightTitle = @"待激活";
            _btnLeft.hidden = YES;
            _btnRight.hidden = NO;
            
        }else{
            rightTitle = @"激活";
            _btnLeft.hidden = NO;
            _btnRight.hidden = YES;
        }
        if (_btnRight.hidden == YES) {
            _btnRightW.constant = 0;
        }
        if (_btnLeft.hidden == YES) {
            _btnLeftW.constant = 0;
        }
//        _lbValue.text = param[@"discount"];
    }
    if ([type isEqualToString:@"pro"] || [type isEqualToString:@"card_num"]||[type isEqualToString:@"card_time"]||[type isEqualToString:@"goods"]||[type isEqualToString:@"ticket"]||[type isEqualToString:@"stored_card"]) {
        
        NSString * rightTitle = param[@"state"];
        CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnRight setTitle:rightTitle forState:UIControlStateNormal];
        _btnRightW.constant = rightBtnW + 5 ;
        
        NSString * title = @"";
        if (param[@"fenqi_zt"] == nil || [param[@"fenqi_zt"] isEqual:[NSNull null]]) {
            _btnLeft.hidden = YES;
            return;
        }
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            title = @"未分期";
        }else if ([param[@"fenqi_zt"] integerValue] == 1) {
            title = @"分期";
        }else if ([param[@"fenqi_zt"] integerValue] == 2) {
            title = @"已还清";
        }else if ([param[@"fenqi_zt"] integerValue] == 3) {
            title = @"终止还款";
        }else{}
        
        NSString * leftTitle = title;
        CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
        _btnLeftW.constant = leftBtnW + 5;
        if ([param[@"fenqi_zt"] integerValue] == 0 && [type isEqualToString:@"pro"]) {
            _btnRight.hidden = YES;
            NSString * leftTitle = param[@"state"];
            CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
            [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
            _btnLeftW.constant = leftBtnW + 5 ;
            
        }
        if ([param[@"fenqi_zt"] integerValue] == 0 && [type isEqualToString:@"stored_card"]) {
            _btnRight.hidden = YES;
            NSString * leftTitle = param[@"state"];
            CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
            [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
            _btnLeftW.constant = leftBtnW + 5 ;
        }
        if ([param[@"fenqi_zt"] integerValue] == 0 && [type isEqualToString:@"card_num"]) {
            _btnRight.hidden = YES;
            NSString * leftTitle = param[@"state"];
            CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
            [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
            _btnLeftW.constant = leftBtnW + 5 ;
        }
    }
    if ([type isEqualToString:@"goods"]||[type isEqualToString:@"ticket"]) {
        NSString * rightTitle = param[@"state"];
        CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnLeft setTitle:rightTitle forState:UIControlStateNormal];
        _btnLeftW.constant = rightBtnW + 5 ;
        _btnLeft.hidden = NO;
        _btnRight.hidden = YES;
        
    }
    if ([type isEqualToString:@"equity"]) { /** 权益包 */
        _lbName.text = param[@"type_name"];
        NSString * leftTitle = param[@"statue_name"];
        CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
        _btnLeftW.constant = leftBtnW + 5;
        _btnRight.hidden = YES;
    }
    if ([type isEqualToString:@"card_time"]) { /** 时间卡 */
        NSString * leftTitle = param[@"state"];
        CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
        [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
        _btnLeftW.constant = leftBtnW + 5;
        _btnRight.hidden = YES;
    }
    
    if ([type isEqualToString:@"goods"]) { /** 产品 非服务型显示已购买 */
        NSString * title = @"";
        if( [param[@"is_serv"] integerValue] == 0){
            title = @"已购买";
            NSString * rightTitle = title;
            CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
            [_btnLeft setTitle:rightTitle forState:UIControlStateNormal];
            _btnLeftW.constant = rightBtnW + 5 ;
            _btnLeft.hidden = NO;
            _btnRight.hidden = YES;
        }
    }
    if ([type isEqualToString:@"ticket_coupon"]) { /** 产品 非服务型显示已购买 */
        NSString * title = @"";
        if( [param[@"status"] integerValue] == 5){
            title = @"已过期";
            NSString * rightTitle = title;
            CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
            [_btnLeft setTitle:rightTitle forState:UIControlStateNormal];
            _btnLeftW.constant = rightBtnW + 5 ;
            _btnLeft.hidden = NO;
            _btnRight.hidden = YES;
        }else{
            if( [param[@"jh_zt"] integerValue] == 0){
                title = @"待激活";
                NSString * rightTitle = title;
                CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
                [_btnLeft setTitle:rightTitle forState:UIControlStateNormal];
                _btnLeftW.constant = rightBtnW + 5 ;
                _btnLeft.hidden = NO;
                _btnRight.hidden = YES;
            }
        }
    }
//    if ([type isEqualToString:@"pro"]) { /** 项目 */
//        NSString * title = @"";
//        if( [param[@"fenqi_zt"] integerValue] == 1 || [param[@"fenqi_zt"] integerValue] == 2){
//            if ([param[@"fenqi_zt"] integerValue] == 1) {
//                title = @"分期";
//            }
//            if ([param[@"fenqi_zt"] integerValue] == 2) {
//                title = @"未还清";
//            }
//            NSString * leftTitle = title;
//            CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
//            [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
//            _btnLeftW.constant = leftBtnW + 5 ;
//
//            NSString * rightTitle = param[@"state"];
//            CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
//            [_btnRight setTitle:rightTitle forState:UIControlStateNormal];
//            _btnRightW.constant = rightBtnW + 5 ;
//        }else{
//            NSString * leftTitle = title;
//            CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
//            [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
//            _btnLeftW.constant = leftBtnW + 5 ;
//        }
//    }
    
    
    NSString *leftMark = @"";
    NSString *rightMark = @"";
    NSInteger fenqi = 0;
    if (!(param[@"fenqi_zt"] == nil || [param[@"fenqi_zt"] isEqual:[NSNull null]])) {
        fenqi = [param[@"fenqi_zt"] integerValue];
        
    }

    NSString * fenqiTitle = @"";
    if (fenqi == 1) {
        fenqiTitle = @"分期";
    }else if(fenqi == 2){
        fenqiTitle = @"已还清";
    }else if(fenqi == 3){
        fenqiTitle = @"终止还款";
    }
    
    /** 两个标签 显示规则  显示一个的时候右侧隐藏用左侧显示  */
    
    
    /**
     账户：
        两个标签都不显示
     
     */
    if ([type isEqualToString:@"bank"]) {
        _btnLeft.hidden = _btnRight.hidden = YES;
    }
    /**
     票券：
        分期状态：无
            显示：
            不显示：
        使用状态：
            显示： 优先显示冻结状态 其次使用状态 使用状态全部显示
            不显示：
     */
    if ([type isEqualToString:@"ticket"]) {
        _btnRight.hidden = YES;
        _btnLeft.hidden = NO;
        leftMark = param[@"state"];
        
    }
    /**
     项目：
     分期状态：有
     显示：    分期中 终止还款 已还清
     不显示： 未分期
     使用状态：
     显示： 优先显示冻结状态 其次使用状态 使用状态全部显示
     不显示：
     
     */
    if ([type isEqualToString:@"pro"]) {
        if (fenqiTitle.length ==0) {
            _btnRight.hidden = YES;
            _btnLeft.hidden = NO;
            leftMark = param[@"state"];
        }else{
            _btnRight.hidden = _btnLeft.hidden = NO;
            leftMark = fenqiTitle;
            rightMark = param[@"state"];
        }
    }
    /**
     产品：
     分期状态：无
     显示：
     不显示：
     使用状态：
     显示： 优先显示冻结状态 其次使用状态 使用状态全部显示
     不显示：  未使用
     
     服务型产品  使用中  已用完
     非服务产品  待发放 已领取
     
     */
    if ([type isEqualToString:@"goods"]) { //TODO 高东确认字段 服务型 非服务
        _btnRight.hidden = YES;
        _btnLeft.hidden = NO;
        leftMark = param[@"state"];
    }
    /**
     时间卡：
     分期状态：无
     显示：
     不显示：
     使用状态：
     显示： 优先显示冻结状态 其次使用状态 使用状态全部显示
     不显示：  未使用
     
     
     */
    if ([type isEqualToString:@"card_time"]) {
        _btnRight.hidden = YES;
        _btnLeft.hidden = NO;
        leftMark = param[@"state"];
    }
    /**
     任选卡：
     分期状态：有
     显示：    分期中 终止还款 已还清
     不显示： 未分期
     使用状态：
     显示： 优先显示冻结状态 其次使用状态 使用状态全部显示
     不显示： 未使用
     
     */
    if ([type isEqualToString:@"card_num"]) {
        if (fenqiTitle.length ==0) {
            _btnRight.hidden = YES;
            _btnLeft.hidden = NO;
            leftMark = param[@"state"];
        }else{
            _btnRight.hidden = _btnLeft.hidden = NO;
            leftMark = fenqiTitle;
            rightMark = param[@"state"];
            if ([param[@"state"] isEqualToString:@"未使用"]) {
                _btnRight.hidden = YES;
            }
        }
    }
    /**
     优惠券：
     分期状态：无
     显示：
     不显示：
     使用状态：
     显示： 优先显示待激活状态 其次使用状态 使用状态全部显示
     不显示：
     
     */
    if ([type isEqualToString:@"ticket_coupon"]) {
        _btnRight.hidden = YES;
        _btnLeft.hidden = NO;
        if ([param[@"jh_zt"] integerValue] == 0) {
            leftMark = @"待激活";
        }else{
            NSInteger state = [param[@"status"] integerValue];
            if (state == 1) {
                leftMark = @"未使用";
            }else if(state == 2){
                leftMark = @"已用完";
            }else if(state == 3){
                leftMark = @"已过期";
            }
        }
    }
    /**
     储值卡：
     分期状态：有
     显示：    分期中 终止还款 已还清
     不显示： 未分期
     使用状态：
     显示： 优先显示冻结状态 其次使用状态 使用状态全部显示
     不显示： 已用完
     
     */
    if ([type isEqualToString:@"stored_card"]) {
        if (fenqiTitle.length ==0) {
            _btnRight.hidden = YES;
            _btnLeft.hidden = NO;
            leftMark = param[@"state"];
        }else{
            _btnRight.hidden = _btnLeft.hidden = NO;
            leftMark = fenqiTitle;
            rightMark = param[@"state"];
            if ([param[@"state"] isEqualToString:@"已用完"]) {
                _btnRight.hidden = YES;
            }
        }
    }
    /**
     quity：
        已购买 已过期 二选一
     
     */
    if ([type isEqualToString:@"equity"]) {
        _btnRight.hidden = YES;
        _btnLeft.hidden = NO;
        leftMark = param[@"statue_name"];
    }
    
    NSString * leftTitle = leftMark;
    CGFloat leftBtnW = [leftTitle stringWidthWithFont:FONT_SIZE(10)];
    [_btnLeft setTitle:leftTitle forState:UIControlStateNormal];
    _btnLeftW.constant = leftBtnW + 5 ;
    
    NSString * rightTitle = rightMark;
    CGFloat rightBtnW = [rightTitle stringWidthWithFont:FONT_SIZE(10)];
    [_btnRight setTitle:rightTitle forState:UIControlStateNormal];
    _btnRightW.constant = rightBtnW + 5 ;
    
    if (_btnRight.hidden) {
        _btnRightW.constant = 0;
    }
    if (_btnLeft.hidden) {
        _btnLeftW.constant = 0;
    }
   
}
@end
