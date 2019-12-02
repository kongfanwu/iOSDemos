//
//  TJCommonCell1.m
//  xmh
//
//  Created by ald_ios on 2018/12/3.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJCommonCell1.h"
#import "TJBBListModel.h"
@interface TJCommonCell1 ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb1Top;

@end
@implementation TJCommonCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    _line.backgroundColor = kSeparatorColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateTJCommonCell1BBModel:(TJBBModel *)model
{
    _lbTitle.text = model.name;
    _lb1.text = [NSString stringWithFormat:@"接待客次：%@次",model.keci];
    _lb2.text = [NSString stringWithFormat:@"销售业绩：%@元",model.xiaoshouyeji];
    _lb3.text = [NSString stringWithFormat:@"消耗业绩：%@元",model.xiaohaoyeji];
    _lb4.text = [NSString stringWithFormat:@"月累计活动顾客：%@人",model.yuehuodongguke];
    _lb5.text = [NSString stringWithFormat:@"有效顾客：%@人",model.youxiaoguke];
    _lb6.text = [NSString stringWithFormat:@"消耗项目数：%@个",model.shicaoxianmushu];
    _lb7.text = [NSString stringWithFormat:@"消耗/销售占比：%@%@",model.bfb,@"%"];
    _lb8.hidden = YES;
    
    if (model.type.integerValue == 1) {
        _lb5.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 2) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 3) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 4) {
        _lb6.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 5) {
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 6) {
        _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    
}
- (void)updateTJCommonCell1ProductionReportParam:(NSDictionary *)param
{
    _lb1Top.constant = 15;
    _lbTitle.text = param[@"name"];
    _lb5.hidden = _lb6.hidden = _lb7.hidden = _lb8.hidden = YES;
    if ([param[@"type"] integerValue] == 0) {
         _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 1) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 2) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 3) {
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    _lb1.text = [NSString stringWithFormat:@"总销售业绩：%@元",param[@"zongyeji"]];
    _lb2.text = [NSString stringWithFormat:@"售前业绩：%@元",param[@"shouqian"]];
    _lb3.text = [NSString stringWithFormat:@"售中业绩：%@元",param[@"shouzhong"]];
    _lb4.text = [NSString stringWithFormat:@"售后业绩：%@元",param[@"shouhou"]];
}
@end
