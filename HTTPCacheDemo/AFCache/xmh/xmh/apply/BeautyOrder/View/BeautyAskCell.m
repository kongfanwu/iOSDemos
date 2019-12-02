//
//  BeautyAskCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyAskCell.h"
#import "NSString+Costom.h"
#import "askPlaceholdLabel.h"
@implementation BeautyAskCell{
    askPlaceholdLabel             *_lbPlacehold;//占位
    NSMutableParagraphStyle *paragraphStyle;
    NSDictionary *attributes;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _container.layer.cornerRadius = 5;
    _container.layer.masksToBounds = YES;
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb1.text = @"处方诉求：";
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    _text1.textColor = kLabelText_Commen_Color_3;
    _text1.font = FONT_SIZE(15);
    _text1.frame = CGRectMake(12, _lb1.bottom + 15, SCREEN_WIDTH - 24 - 20, 118-30);
    _text1.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _text1.delegate = self;
    
    paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    attributes =@{NSFontAttributeName:FONT_SIZE(15),
                  NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:kColorC};
    //默认文字的标签.
    CGFloat h=0.0;
    if (I6_HEIGHT_SALE>=1.0) {
        h=-15;
    } else {
        h=0.0;
    }
    CGRect rect= CGRectMake(0,h, _text1.width, 90);
    _lbPlacehold = [[askPlaceholdLabel alloc] initWithFrame:rect];
    _lbPlacehold.font = FONT_SIZE(15);
    _lbPlacehold.enabled = NO;
    _lbPlacehold.textColor = kColorC;
    _lbPlacehold.numberOfLines = 0;
    [_text1 addSubview:_lbPlacehold];
    
    _line1.backgroundColor = kBackgroundColor;
    _line1.frame = CGRectMake(0, _text1.bottom+15, SCREEN_WIDTH, 10);
}
- (void)reFreshBeautyAskCell:(NSString *)title withContext:(NSString *)context withPlaceText:(NSString *)placeText withhidden:(BOOL)isHidden{
    _lb1.text = title;
    _text1.text = context;
    _lbPlacehold.attributedText = [[NSAttributedString alloc] initWithString:placeText attributes:attributes];
    _lbPlacehold.hidden = isHidden;
}
// 改变输入框默认文字
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _lbPlacehold.hidden = NO;
    } else {
        _lbPlacehold.hidden = YES;
//        textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
