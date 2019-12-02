//
//  FWDHaoKaCell.m
//  
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//

#import "FWDHaoKaCell.h"

@implementation FWDHaoKaCell
{
    UIButton * _selectBTN;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self haoKaClick:_btn1];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)haoKaClick:(UIButton *)sender {
    _selectBTN.selected = NO;
    sender.selected = YES;
    _selectBTN = sender;
    if (_FWDHaoKaCellBlock) {
        NSString * select = [NSString stringWithFormat:@"%ld",sender.tag - 500];
        _FWDHaoKaCellBlock(select);
    }
}
@end
