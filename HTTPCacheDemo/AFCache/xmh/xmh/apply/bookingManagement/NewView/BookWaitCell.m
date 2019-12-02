//
//  BookWaitCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookWaitCell.h"
#import "DaiYuYueModel.h"
#import <YYWebImage/YYWebImage.h>
@interface BookWaitCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/** 顾客姓名 */
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerName;
/** 技师姓名 */
@property (weak, nonatomic) IBOutlet UILabel *lbJisName;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@end
@implementation BookWaitCell
{
    DaiYuYueModel * _model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _btn1.layer.borderWidth = 0.5;
    _btn1.layer.borderColor = kColorTheme.CGColor;
}

- (IBAction)btnClick:(UIButton *)sender
{
    if (_BookWaitCellBlock) {
        _BookWaitCellBlock(_model.user_id);
    }
}
- (void)updateBookWaitCellModel:(DaiYuYueModel *)model
{
    _model = model;
    [_icon yy_setImageWithURL:URLSTR(model.user_headimgurl) placeholder:kDefaultCustomerImage];
    _lbCustomerName.text = [NSString stringWithFormat:@"顾客姓名：%@",model.user_name];
    _lbJisName.text = [NSString stringWithFormat:@"技师姓名：%@",model.jis_name];
}
@end
