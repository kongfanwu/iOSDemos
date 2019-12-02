//
//  BookDetailHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDetailHeader.h"
#import <YYWebImage/YYWebImage.h>
#import "CustomerMessageModel.h"
@interface BookDetailHeader ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/** 顾客姓名 */
@property (weak, nonatomic) IBOutlet UILabel *lbName;
/** 顾客登记 */
@property (weak, nonatomic) IBOutlet UILabel *lbClass;
/** 顾客电话 */
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;

@end
@implementation BookDetailHeader
- (void)awakeFromNib
{
    [super awakeFromNib];
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.layer.masksToBounds = YES;
}
- (void)updateBookDetailHeaderModel:(CustomerMessageModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lbName.text = [NSString stringWithFormat:@"顾客姓名：%@",model.uname];
    _lbClass.text = [NSString stringWithFormat:@"会员等级：%@",model.grade];
    _lbPhone.text = [NSString stringWithFormat:@"顾客电话：%@",model.mobile];
}
@end
