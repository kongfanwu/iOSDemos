//
//  CustomerDetailTbHeader.m
//  xmh
//
//  Created by ald_ios on 2018/11/1.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerDetailTbHeader.h"
#import "CustomerMessageModel.h"
#import <YYWebImage/YYWebImage.h>
@interface CustomerDetailTbHeader ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/** 顾客姓名 */
@property (weak, nonatomic) IBOutlet UILabel *lbName;
/** 门店 */
@property (weak, nonatomic) IBOutlet UILabel *lbStore;
/** 技师 */
@property (weak, nonatomic) IBOutlet UILabel *lbJis;
/** 顾客等级 */
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW;
@property (strong, nonatomic)NSDictionary * levelDic;
@property (weak, nonatomic) IBOutlet UIView *lineBottom;
@end

@implementation CustomerDetailTbHeader
- (void)awakeFromNib
{
    [super awakeFromNib];
//    _levelDic = @{@"1":@"初级",@"2":@"高级",@"3":@"特级",@"4":@"岗前",@"5":@"实习"};
    _lineBottom.backgroundColor = kSeparatorColor;
}
- (void)updateCustomerDetailTbHeaderModel:(CustomerMessageModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lbName.text = model.uname;
    _lbStore.text = model.mdname;
    _lbJis.text = [NSString stringWithFormat:@"技师：%@",model.jis_name];
    
    NSString * btnTitle = model.grade;
    CGFloat btnW = [btnTitle stringWidthWithFont:FONT_SIZE(9)];
    _btnW.constant = btnW + 10;
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
}
- (void)updateCustomerDetailTbHeaderParam:(NSMutableDictionary *)param
{
    [_icon yy_setImageWithURL:URLSTR(param[@"headimgurl"]) placeholder:kDefaultCustomerImage];
    _lbName.text = param[@"user_name"]?param[@"user_name"]:@"";
    _lbStore.text = param[@"store_name"]?param[@"store_name"]:@"";
    _lbJis.text = [NSString stringWithFormat:@"技师：%@",param[@"jis_name"]?param[@"jis_name"]:@""];
    
    NSString *level = [NSString stringWithFormat:@"%@",param[@"grade"]];
    NSString * btnTitle = level;
    CGFloat btnW = [btnTitle stringWidthWithFont:FONT_SIZE(9)];
    _btnW.constant = btnW + 10;
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
    if (level.length == 0) {
        _btn.hidden = YES;
    }
}
@end
