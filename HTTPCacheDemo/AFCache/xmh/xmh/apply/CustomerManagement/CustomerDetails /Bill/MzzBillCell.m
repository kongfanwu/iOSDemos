//
//  MzzBillCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillCell.h"
#import "MzzBillInfoListModel.h"
@interface MzzBillCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (nonatomic ,copy)NSString *cardName;
@end
@implementation MzzBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupModel:(MzzBillInfoModel *)model andType:(NSString *)type andCardName:(NSString *)cardName {
    _model = model;
    _cardName = cardName;
    [_name setText:model.ly_name];
    [_time setText:model.insert_time];
    [_value setText:model.show];
    if (model.operation == 1) {
        _value.textColor = kBtn_Commen_Color;
    }
    if (model.operation == 2) {
        _value.textColor = kLabelText_Commen_Color_6;
    }
}
@end
