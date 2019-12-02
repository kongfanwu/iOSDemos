//
//  LanternMAlertView.m
//  xmh
//
//  Created by ald_ios on 2019/2/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMAlertView.h"
@interface LanternMAlertView ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *btnleft;
@property (weak, nonatomic) IBOutlet UIButton *btnright;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *view1;

@end
@implementation LanternMAlertView
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSDate * currentDate = [NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [format stringFromDate:currentDate];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:dateStr attributes:@{NSForegroundColorAttributeName:kColor9,NSFontAttributeName :FONT_SIZE(13), NSParagraphStyleAttributeName:style}];
    _tf.attributedPlaceholder = attri;
    
    _view1.layer.cornerRadius = 10;
    _view1.layer.masksToBounds = YES;
    
}
- (IBAction)cancel:(UIButton *)sender
{
    [self removeFromSuperview];
}
- (IBAction)sure:(UIButton *)sender
{
    [_tf resignFirstResponder];
    NSString * text = @"";
    if (_tf.text.length > 0) {
        text = _tf.text;
    }else{
        text = _tf.placeholder;
    }
    if (_LanternMAlertViewSureBlock) {
        _LanternMAlertViewSureBlock(text);
    }
    [self removeFromSuperview];
}

@end
