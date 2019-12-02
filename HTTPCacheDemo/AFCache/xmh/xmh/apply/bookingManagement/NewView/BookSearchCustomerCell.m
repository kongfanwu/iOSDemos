//
//  BookSearchCustomerCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookSearchCustomerCell.h"
#import <YYWebImage/YYWebImage.h>
@interface BookSearchCustomerCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/** 顾客姓名 */
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerName;
/** 顾客等级 */
@property (weak, nonatomic) IBOutlet UILabel *lbClass;
/** 顾客电话 */
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;

@end
@implementation BookSearchCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.layer.masksToBounds = YES;
}
- (void)updateBookSearchCustomerCellModel:(CustomerModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lbCustomerName.text = [NSString stringWithFormat:@"顾客姓名：%@",model.uname];
    _lbClass.text = [NSString stringWithFormat:@"会员等级：%@",model.grade_name];
    _lbPhone.text = [NSString stringWithFormat:@"顾客电话：%@",model.mobile];
}

@end
