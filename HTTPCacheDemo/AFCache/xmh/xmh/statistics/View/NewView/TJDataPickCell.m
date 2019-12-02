//
//  TJDataPickCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/3.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJDataPickCell.h"
#import "TJParamModel.h"
@interface TJDataPickCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbTItle;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
@implementation TJDataPickCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _line.backgroundColor = kSeparatorColor;
}
- (void)updateTJDataPickCellModel:(TJParamModel *)model
{
    _lbTItle.text = model.name;
    if (model.selected) {
        _lbTItle.textColor = kColorTheme;
    }
    if (!model.selected) {
        _lbTItle.textColor = kColor9;
    }
}
@end
