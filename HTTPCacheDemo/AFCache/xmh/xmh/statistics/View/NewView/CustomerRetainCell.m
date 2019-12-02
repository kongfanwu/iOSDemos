//
//  CustomerRetainCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerRetainCell.h"
#import "CustomerRetainListModel.h"
@interface CustomerRetainCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@end
@implementation CustomerRetainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCustomerRetainCellModel:(CustomerRetainModel *)model
{
    _lbName.text = model.name;
    _lb1.text = @"保有顾客";
    _lb2.text = [NSString stringWithFormat:@"标准值：%@",model.biaozhun];
    _lb3.text = [NSString stringWithFormat:@"新增顾客：%@",model.xinzeng];
    _lb4.text = [NSString stringWithFormat:@"售中转化顾客：%@",model.zhuanhua];
    _lb5.text = [NSString stringWithFormat:@"活动顾客：%@",model.huodong];
    
//    _lb6.text = [NSString stringWithFormat:@"本月：%@",model.benyue];
    _lb6.hidden = YES;
    _lb7.text = [NSString stringWithFormat:@"本月：%@",model.benyue];
    _lb8.text = [NSString stringWithFormat:@"售中承接：%@",model.chengjie];
    _lb9.text = [NSString stringWithFormat:@"流失顾客：%@",model.liushi];
    _lb10.text = [NSString stringWithFormat:@"有效顾客：%@",model.youxiao];
    if (model.type.integerValue == 1) {
        _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 2) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 3) {
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 4) {
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 5) {
        _lb9.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 6) {
        _lb5.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 7) {
        _lb10.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    
}
@end
