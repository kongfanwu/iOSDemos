//
//  GKGLCustomerCFCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerCFCell.h"
@interface GKGLCustomerCFCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@end
@implementation GKGLCustomerCFCell
{
    NSDictionary * _param;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb1.textColor = _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor=  _lb6.textColor = kColor6;
    _btn.layer.borderWidth = 1;
    _btn.layer.borderColor = kColorTheme.CGColor;
    _btn.layer.cornerRadius = 5;
    _btn.layer.masksToBounds = YES;
    [_btn setTitleColor:kColorTheme forState:UIControlStateNormal];
    _viewBg.layer.cornerRadius = 5;
    _viewBg.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCellParam:(NSDictionary *)param cellType:(NSInteger )tag;
{
    _param = param;
    _lb1.text = [NSString stringWithFormat:@"处方名称：%@",param[@"name"]];
    _lb2.text = [NSString stringWithFormat:@"预约技师：%@",param[@"jis_name"]];
    _lb3.text = @"剩余次数";
    if (tag == 0) {
       _lb4.text = [NSString stringWithFormat:@"规划时间：%@",param[@"time"]];
        _btn.hidden = YES;
    }
    if (tag == 1) {
        _lb4.text = [NSString stringWithFormat:@"完成时间：%@",param[@"time"]];
    }
    _lb5.text = [NSString stringWithFormat:@"%ld",[param[@"num1"]integerValue]];
    _lb6.text = [NSString stringWithFormat:@"/%@",param[@"num"]];
    _lb5.textColor = kColorTheme;
    if ([param[@"presentation"] isEqual:[NSNull null]] || [param[@"proposal"] isEqual:[NSNull null]] || !param[@"presentation"] || !param[@"proposal"]) {
        _btn.hidden = YES;
    }
}
- (IBAction)tapDown:(UIButton *)sender
{
    if (_GKGLCustomerCFCellTapBlock) {
        _GKGLCustomerCFCellTapBlock(_param);
    }
}

@end
