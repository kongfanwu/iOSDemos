//
//  XMHAwardItem.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAwardItem.h"
#import "SASaleListModel.h"

@interface XMHAwardItem()
@property (nonatomic, strong)SaleModel *model;
@end

@implementation XMHAwardItem
- (IBAction)selectBtn:(id)sender {
    self.model.isBaoHan =!self.model.isBaoHan;
    if (_selectedAwardItem) {
        _selectedAwardItem(self.model);
    }
    self.imageSelet.highlighted = self.model.isBaoHan;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColor = kLabelText_Commen_Color_6;
}
- (void)refreshCellModel:(SaleModel *)model
{
    _model = model;
    self.titleLab.text = model.name;
    self.imageSelet.highlighted = model.isBaoHan;
}
- (void)resetCell
{
    self.titleLab.text = @"";
}
@end
