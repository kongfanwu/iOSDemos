//
//  BeautyCFCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFCell.h"
@interface BeautyCFCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
/** 状态 */
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong)NSMutableDictionary * param;
@property (weak, nonatomic) IBOutlet UIView *lineTop;
@property (weak, nonatomic) IBOutlet UIView *lineBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTopH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linebottomH;

@end
@implementation BeautyCFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lb1.font = FONT_SIZE(15);
    _lb1.textColor = kColor3;
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = _lb6.font = FONT_SIZE(11);
    _lb8.font = FONT_SIZE(13);
    
    _lb2.textColor = _lb3.textColor = _lb4.textColor =  _lb6.textColor  = _lb7.textColor = kColor9;
    _lb5.textColor = [ColorTools colorWithHexString:@"#EA007A"];
    _btn.layer.cornerRadius = 3;
    _btn.layer.masksToBounds = YES;
    _btn.backgroundColor = [ColorTools colorWithHexString:@"#EA007A"];
    // Initialization code
    [_btn setTitle:@"处方报告" forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lineTop.backgroundColor = _lineBottom.backgroundColor = kSeparatorColor;
    _lineTopH.constant = _linebottomH.constant = kSeparatorHeight;
    _lineBottom.hidden = YES;
}
- (IBAction)end:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"处方报告"]) {
        if (_BeautyCFCellCFReportBlock) {
            _BeautyCFCellCFReportBlock(_param);
        }
    }else if ([sender.currentTitle isEqualToString:@"结束处方"]){
        if (_BeautyCFCellEndCFBlock) {
            _BeautyCFCellEndCFBlock(_param);
        }
    }else{}
    
}
- (void)updateCellParam:(NSMutableDictionary *)param index:(NSInteger)index
{
    _param = param;
    /** 进行中 */
    if (index == 0) {
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        /** 只有做过一次或一次以上的处方有结束处方 */
        if ([param[@"num1"] integerValue] >= 1) {
           [_btn setTitle:@"结束处方" forState:UIControlStateNormal];
        }else{
            _btn.hidden = YES;
        }
        
    }
    _lb1.text = param[@"user_name"]?param[@"user_name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"处方名称：%@", param[@"pres_name"]?param[@"pres_name"]:@""];
    _lb3.text = [NSString stringWithFormat:@"预约技师：%@", param[@"jis_name"]?param[@"jis_name"]:@""];
    _lb4.text = @"剩余次数：";
    _lb5.text = param[@"num1"]?param[@"num1"]:@"";
    _lb6.text = [NSString stringWithFormat:@"/%@",param[@"num"]?param[@"num"]:@""];
    _lb2.text = [NSString stringWithFormat:@"处方名称：%@", param[@"pres_name"]?param[@"pres_name"]:@""];
    _lb7.text = [NSString stringWithFormat:@"完成时间：%@", param[@"time"]?param[@"time"]:@""];
    if ([param[@"zt"] integerValue] == 2) {/** 已终止 */
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF9072"];
        _lb8.text = @"已终止";
    }else if ([param[@"zt"] integerValue] == 3){/** 已完成 */
        _lb8.textColor = kColorC;
        _lb8.text = @"已完成";
    }else{}
}
@end
