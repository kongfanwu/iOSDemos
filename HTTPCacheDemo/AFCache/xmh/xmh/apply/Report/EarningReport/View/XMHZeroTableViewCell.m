//
//  XMHZeroTableViewCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHZeroTableViewCell.h"
#import "XMHZeroListModel.h"
@interface XMHZeroTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *storeLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaLeftConstraint;

@end
@implementation XMHZeroTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.backgroundColor =  Color_NormalBG;
    CGFloat w = ( SCREEN_WIDTH - 20) * 0.5;
    self.storeRightConstraint.constant = w - 40;
    self.areaLeftConstraint.constant = w + 40;
}
- (void)configureWithModel:(id)model
{
    [super configureWithModel:model];
    XMHZeroModel *zeroModel = (XMHZeroModel *)model;
    self.storeLab.text = zeroModel.name;
    self.areaLab.text = zeroModel.store_name?zeroModel.store_name:@"";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
