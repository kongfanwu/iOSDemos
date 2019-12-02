//
//  OrderRightSectionHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderRightSectionHeader.h"

@implementation OrderRightSectionHeader
{
    SLPresListModel *presModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)freshOrderRightSectionHeard:(SLPresListModel *)model{

    self.lb.text = model.name;
    presModel = model;
    if (model.isSelect) {
        [self.btn  setBackgroundImage:[UIImage imageNamed:@"orderduoxuanxuanzhong.png"] forState:UIControlStateNormal];
    }else{
        [self.btn  setBackgroundImage:[UIImage imageNamed:@"orderduoxuanweixuan.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnAction:(id)sender {
        if (presModel.isSelect == YES) {
            presModel.isSelect = NO;
        }else{
            presModel.isSelect = YES;
        }
        if (presModel.isSelect == YES) {
            if (_clickXuan) {
                _clickXuan(presModel.isSelect);
            }
        }else{
            if (_clickWeiXuan) {
                _clickWeiXuan(presModel.isSelect);
            }
        }
}

@end
