//
//  LanternMResultCell.m
//  xmh
//
//  Created by ald_ios on 2019/2/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMResultCell.h"
#import <YYWebImage/YYWebImage.h>
//#import "LanternMResultVC.h"
@interface LanternMResultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

@end
@implementation LanternMResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb1.textColor = kColor3;
    _lb2.textColor =kColor9;
    _lb1.font = FONT_SIZE(16);
    _lb2.font = FONT_SIZE(11);
    _lb3.font = FONT_SIZE(11);
    _lb3.textColor = kColor9;
    _lb3.hidden = YES;
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.layer.masksToBounds = YES;
}
- (void)updateCellParam:(NSDictionary *)param
{
    _lb1.text = param[@"name"];
    _lb2.text = [NSString stringWithFormat:@"￥%.2f",[param[@"price"]floatValue]];
    _icon.image = UIImageName(@"xiangmumorentouxiang");
}
- (void)updateCellParam:(NSDictionary *)param searchType:(LanternSearchType)searchType
{
    if (searchType == LanternSearchTypePro) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"￥%.2f",[param[@"price"]floatValue]];
        _icon.image = UIImageName(@"xiangmumorentouxiang");
    }else if (searchType == LanternSearchTypeStaff){
        _lb1.text = param[@"name"];
        _lb2.hidden = YES;
        _lb3.text = param[@"store_name"];
        _lb3.hidden = NO;
        [_icon yy_setImageWithURL:URLSTR(param[@"pic"]) placeholder:kDefaultJisImage];
    }else if (searchType == LanternSearchTypeCustomer){
        _lb1.text = param[@"name"];
        _lb2.text = param[@"grade"];
        _lb3.text = param[@"store_name"];
        _lb3.hidden = NO;
        [_icon yy_setImageWithURL:URLSTR(param[@"pic"]) placeholder:kDefaultCustomerImage];
    }else{}
}
@end
