//
//  GKGLCustomerBillDetailCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillDetailCell.h"
@interface GKGLCustomerBillDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lbState;

@end
@implementation GKGLCustomerBillDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb5.hidden = YES;
    _lb1.textColor = _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor=  kColor6;
    _lbState.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateCellParam:(NSDictionary *)param cellType:(NSInteger )tag
{
    _lb1.text = [NSString stringWithFormat:@"开单类型：%@",param[@"name"]];
    _lb2.text = [NSString stringWithFormat:@"开单人：%@",param[@"kai_name"]];
    _lb3.text = [NSString stringWithFormat:@"实付金额：%@",param[@"price"]];
    _lb4.text = [NSString stringWithFormat:@"结算时间：%@",param[@"time"]];
    _lbState.text = @"已完成";
    if (tag == 1) {
        _lb5.hidden = NO;
        NSMutableString * proStr = [[NSMutableString alloc] init];
        NSInteger count = [param[@"pro_list"] count];
        for (int i = 0; i < count; i++) {
            [proStr appendString:param[@"pro_list"][i]];
            [proStr appendString:@"、"];
        }
        [proStr replaceCharactersInRange:NSMakeRange(proStr.length -1, 1) withString:@""];
        _lb4.text = [NSString stringWithFormat:@"项目：%@",proStr];
        _lb5.text = [NSString stringWithFormat:@"结算时间：%@",param[@"time"]];
    }
}
@end
