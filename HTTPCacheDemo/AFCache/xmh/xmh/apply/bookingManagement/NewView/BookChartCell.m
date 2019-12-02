//
//  BookChartCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookChartCell.h"
@interface BookChartCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIView *bg;

@end
@implementation BookChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    _lb2.textColor = kColor9;
    _lb1.textColor = kColor3;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    _lb1.text = param[@"name"]?param[@"name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"%@个预约订单",param[@"num"]?param[@"num"]:@"0"];
}

@end
