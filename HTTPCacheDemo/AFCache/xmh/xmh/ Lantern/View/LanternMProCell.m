//
//  LanternMProCell.m
//  xmh
//
//  Created by ald_ios on 2019/2/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMProCell.h"
@interface LanternMProCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPercent;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end
@implementation LanternMProCell
{
    NSMutableDictionary * _param;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lbPercent.hidden = YES;
    _bgView.backgroundColor = kColorF5F5F5;
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.masksToBounds = YES;
    _lbName.textColor = _lbPercent.textColor = kColorC;
    _tf.textColor = kColor9;
    _tf.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeOneCI:) name:UITextFieldTextDidChangeNotification object:_tf];
   
}
- (void)updateCellParam:(NSMutableDictionary *)param islast:(BOOL)islast
{
    _param = param;
    _lbName.text = param[@"name"];
    _lbPercent.text = param[@"name"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:param[@"name"] attributes:@{NSForegroundColorAttributeName:kColor9,NSFontAttributeName :FONT_SIZE(13), NSParagraphStyleAttributeName:style}];
    _tf.attributedPlaceholder = attri;

    if (islast) {
        _lbName.hidden = YES;
        _lbPercent.hidden = NO;
        _tf.hidden = YES;
        _bgView.layer.borderWidth = 0;
        _bgView.backgroundColor = [UIColor whiteColor];
    }else{
        _lbName.hidden = NO;
        _lbPercent.hidden = YES;
        _tf.hidden = YES;
        _bgView.backgroundColor = kColorF5F5F5;
        if ([param.allKeys containsObject:@"custom"] && [param[@"custom"] boolValue]) {
            _bgView.layer.borderWidth = 1;
            _bgView.layer.borderColor = kColorC.CGColor;
            _bgView.backgroundColor = [UIColor whiteColor];
            _lbName.hidden = YES;
            _tf.hidden = NO;
            _lbPercent.hidden = YES;
            _tf.textColor = kColor9;
        }else{
            _lbName.hidden = NO;
            _tf.hidden = YES;
            _lbPercent.hidden = YES;
            if ([param[@"select"] boolValue]) {
                _bgView.layer.borderWidth = 1;
                _bgView.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
                _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
                _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
            }else{
                _bgView.backgroundColor = kColorF5F5F5;
                _bgView.layer.borderWidth = 0;
                _lbName.textColor = kColorC;
            }
        }
    }
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    _param = param;
    _lbName.text = param[@"name"];
    _lbPercent.text = param[@"name"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"自定义" attributes:@{NSForegroundColorAttributeName:kColor9,NSFontAttributeName :FONT_SIZE(13), NSParagraphStyleAttributeName:style}];
    _tf.attributedPlaceholder = attri;
    _tf.text = param[@"name"];
    if ([param.allKeys containsObject:@"unit"]) { /** 证明最后一位 并且是单位 */
        _lbPercent.text = param[@"name"];
        _lbPercent.hidden = NO;
        _lbName.hidden = YES;
        _tf.hidden = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderWidth = 0;
        self.userInteractionEnabled = NO;
        
    }else{
        self.userInteractionEnabled = YES;
        _lbName.hidden = NO;
        _lbPercent.hidden = YES;
        _tf.hidden = YES;
        _bgView.backgroundColor = kColorF5F5F5;
        if ([param.allKeys containsObject:@"custom"] && [param[@"custom"] boolValue]) {
            _bgView.layer.borderWidth = 1;
            _bgView.layer.borderColor = kColorC.CGColor;
            _bgView.backgroundColor = [UIColor whiteColor];
            _lbName.hidden = YES;
            _tf.hidden = NO;
            _tf.textColor = kColor9;
            _lbPercent.hidden = YES;
        }else{
            _lbName.hidden = NO;
            _tf.hidden = YES;
            _lbPercent.hidden = YES;
            if ([param[@"select"] boolValue]) {
                _bgView.layer.borderWidth = 1;
                _bgView.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
                _bgView.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
                _lbName.textColor = [ColorTools colorWithHexString:@"#FF9072"];
            }else{
                _bgView.backgroundColor = kColorF5F5F5;
                _bgView.layer.borderWidth = 0;
                _lbName.textColor = kColorC;
            }
        }
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_param setValue:textField.text forKey:@"name"];
    if (textField.text.length > 0) {
        [_param setValue:@(YES) forKey:@"select"];
        if (_LanternMProCellBlock) {
            _LanternMProCellBlock(_param);
        }
    }
}
-(void)textFieldTextDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    NSLog(@".........%@",textfield.text);
    [_param setValue:textfield.text forKey:@"name"];
    if (textfield.text.length == 0) {
        [_param setValue:@(NO) forKey:@"select"];
        if (_LanternMProCellBlock) {
            _LanternMProCellBlock(_param);
        }
    }
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
@end
