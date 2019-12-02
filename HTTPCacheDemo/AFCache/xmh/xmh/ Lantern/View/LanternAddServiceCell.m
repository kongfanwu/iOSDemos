//
//  LanternAddServiceCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternAddServiceCell.h"
#import "LanternPlanInfoListModel.h"
@interface LanternAddServiceCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@end
@implementation LanternAddServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnSelect.userInteractionEnabled = NO;
}
- (void)updateLanternAddServiceCellModel:(LanternPlanProModel *)model
{
    _lbName.text = model.name;
    if (model.selected) {
        [_btnSelect setImage:UIImageName(@"zhinengguanjia_xuanzhong") forState:UIControlStateNormal];
    }else{
        [_btnSelect setImage:UIImageName(@"zhinengguanjia_weixuan") forState:UIControlStateNormal];
    }
}
@end
