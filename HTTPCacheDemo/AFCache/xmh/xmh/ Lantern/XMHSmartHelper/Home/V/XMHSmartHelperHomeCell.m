//
//  XMHSmartHelperHomeCell.m
//  xmh
//
//  Created by ald_ios on 2019/6/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSmartHelperHomeCell.h"
#import "NSString+Costom.h"
@interface XMHSmartHelperHomeCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbNumW;
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@end
@implementation XMHSmartHelperHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lbTitle.font = FONT_SIZE(13);
    _lbTitle.textColor = kColor3;
    
    _lbNum.layer.cornerRadius = _lbNum.height/2;
    _lbNum.layer.masksToBounds = YES;
    _lbNum.text = @"99+";
    _lbNum.font = FONT_SIZE(11);
    _lbNum.textColor = [UIColor whiteColor];
    _lbNum.hidden = NO;
    _lbNum.backgroundColor = kColorTheme;
    
}
- (void)updateCellModel:(MineCellModel *)model
{
    _imgv.image = UIImageName(model.iconStr);
    _lbTitle.text = model.title;
    
    NSString * num = @"";
    if (model.num > 99) {
        _lbNum.hidden = NO;
        num = @"99+";
    }else if (model.num == 0){
        _lbNum.hidden = YES;
    }else{
        _lbNum.hidden = NO;
        num = [NSString stringWithFormat:@"%ld",model.num];
    }
    CGFloat w = [num stringWidthWithFont:FONT_SIZE(11)];
    _lbNumW.constant = w + 10;
    _lbNum.text = num;
    
}
@end
