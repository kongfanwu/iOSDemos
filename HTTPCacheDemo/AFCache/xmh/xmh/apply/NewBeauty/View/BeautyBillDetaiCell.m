//
//  BeautyBillDetaiCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyBillDetaiCell.h"
@interface BeautyBillDetaiCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIProgressView *p;
@property (weak, nonatomic) IBOutlet UIView *lineBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineBottomH;

@end
@implementation BeautyBillDetaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb3.text = @"预计消耗总周期";
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = kColor9;
    _lb4.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    
    _lb1.font = FONT_SIZE(16);
    _lb2.font = _lb3.font = FONT_SIZE(11);
    _lb4.font = FONT_SIZE(15);
    _lineBottom.backgroundColor = kSeparatorColor;
    _lineBottomH.constant = kSeparatorHeight;
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    _lb1.text = param[@"name"]?param[@"name"]:@"";
    if ([param[@"num"] integerValue] == -1) {
        _lb2.text = [NSString stringWithFormat:@"余额：%@",param[@"money"]?param[@"money"]:@""];
    }
    if ([param[@"money"] integerValue] == -1) {
        _lb2.text = [NSString stringWithFormat:@"余次：%@",param[@"num"]?param[@"num"]:@""];
    }
    _lb4.text = [NSString stringWithFormat:@"%@天",param[@"yjxhzq"]?param[@"yjxhzq"]:@""];
}
@end
