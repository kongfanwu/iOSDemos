//
//  BeautyCustomerCommonCell.m
//  xmh
//
//  Created by ald_ios on 2018/11/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCustomerCommonCell.h"
#import "CustomerListModel.h"
#import <YYWebImage/YYWebImage.h>
@interface BeautyCustomerCommonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbStore;
@property (weak, nonatomic) IBOutlet UILabel *lbJis;
@property (weak, nonatomic) IBOutlet UIButton *btnClass;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW;

@end
@implementation BeautyCustomerCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)updateBeautyCustomerCommonCellModel:(CustomerModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lbName.text = model.uname;
    _lbStore.text = [NSString stringWithFormat:@"门店：%@",model.mdname];
    _lbJis.text = [NSString stringWithFormat:@"技师：%@",model.jis_name];
    if (model.grade_name.length == 0) {
        _btnClass.hidden = YES;
    }else{
        NSString * btnTitle = model.grade_name;
        CGFloat btnW = [btnTitle stringWidthWithFont:FONT_SIZE(9)];
        _btnW.constant = btnW + 10;
        [_btnClass setTitle:btnTitle forState:UIControlStateNormal];
        _btnClass.layer.borderColor = [ColorTools colorWithHexString:@"#FFAF19"].CGColor;
        [_btnClass setTitleColor:[ColorTools colorWithHexString:@"#FFAF19"] forState:UIControlStateNormal];
    }
    
}
@end
