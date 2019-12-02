//
//  MzzBillDetailTbCommonHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillDetailTbCommonHeader.h"
@interface MzzBillDetailTbCommonHeader ()
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation MzzBillDetailTbCommonHeader
- (void)updateMzzBillDetailTbCommonHeaderModel:(MzzBillInfoModel *)model
{
    if (model.operation == 1) {
        _lbValue.textColor = kBtn_Commen_Color;
    }
    if (model.operation == 1) {
        _lbValue.textColor = kLabelText_Commen_Color_6;
    }
    _lbValue.text = model.show;
    _lbName.text = model.name;
}
@end
