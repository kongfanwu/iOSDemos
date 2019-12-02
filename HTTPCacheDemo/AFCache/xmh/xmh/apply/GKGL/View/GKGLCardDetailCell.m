//
//  GKGLCardDetailCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCardDetailCell.h"
@interface GKGLCardDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@end
@implementation GKGLCardDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lbName.textColor = kColor6;
    _lbTime.textColor = kColor9;
}

- (void)updateCellParam:(NSDictionary *)param
{
    _lbName.text = param[@"ly_name"];
    _lbTime.text = param[@"insert_time"];
    _lbValue.text = param[@"show"];
    NSString * operation = param[@"operation"];
    if (operation.integerValue == 1) {
        _lbValue.textColor = kColor6;
    }
    if (operation.integerValue == 2) {
        _lbValue.textColor = kColorTheme;
    }
}

@end
