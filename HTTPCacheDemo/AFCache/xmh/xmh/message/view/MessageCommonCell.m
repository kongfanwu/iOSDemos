//
//  MessageCommonCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/19.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MessageCommonCell.h"
#import <YYWebImage/YYWebImage.h>
#import "NSString+Costom.h"
#import "MsgHomeListModel.h"
@interface MessageCommonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbNumW;

@end
@implementation MessageCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = _icon.height/2;
    _lbNum.backgroundColor = kColorTheme;
    _lbNum.layer.cornerRadius = _lbNum.height/2;
    _lbNum.layer.masksToBounds = YES;
    _lbTitle.textColor = kColor6;
    _lbMsg.textColor = kColor9;
    _line.backgroundColor = kColorE;
    
}
- (void)updateMessageCommonCellModel:(MsgHomeModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultImage];
    
    _lbNum.text = model.num;
    _lbNumW.constant = [_lbNum.text stringWidthWithFont:FONT_SIZE(11)] + 10;
    
    _lbTitle.text = model.title;
    _lbMsg.text =  model.depict;
    
    if (model.num.integerValue == 0) {
        _lbNum.hidden = YES;
    }
    
}
@end
