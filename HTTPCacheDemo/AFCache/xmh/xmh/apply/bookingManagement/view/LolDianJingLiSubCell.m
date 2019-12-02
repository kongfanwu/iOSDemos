//
//  LolDianJingLiSubCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolDianJingLiSubCell.h"
#import "LolHomeBaseModel.h"
@implementation LolDianJingLiSubCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    _lb1.font = FONT_SIZE(14);
    _lb1.textColor = [ColorTools colorWithHexString:@"#333333"];
    
    _lb2.font = FONT_SIZE(11);
    _lb2.textColor = [ColorTools colorWithHexString:@"#999999"];
    
    _lb3.font = FONT_SIZE(11);
    _lb3.textColor = [ColorTools colorWithHexString:@"#999999"];
    
    _lb4.font = FONT_SIZE(11);
    _lb4.textColor = [ColorTools colorWithHexString:@"#999999"];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)setModel:(LolHomeBaseModel *)model
{
    _lb1.text = model.name;
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(10, 15, _lb1.width, _lb1.height);
    
    _lb2.text = [NSString stringWithFormat:@"管理门店:%ld个",model.count];
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 10, _lb2.width, _lb2.height);
    
    _lb3.text = [NSString stringWithFormat:@"预约服务人数:%ld人",model.num];
    [_lb3 sizeToFit];
    _lb3.frame = CGRectMake(_lb1.left, _lb2.bottom + 10, _lb3.width, _lb3.height);
    
    _lb4.text = [NSString stringWithFormat:@"预约项目:%ld个",model.pro_num];
    [_lb4 sizeToFit];
    _lb4.frame = CGRectMake(_lb1.left, _lb3.bottom + 10, _lb4.width, _lb4.height);
    NSString * title = @"";
    switch (model.state) {
        case 1:
            title = @"休息";
            break;
        case 2:
            title = @"达标";
            break;
        case 3:
            title = @"不达标";
            break;
            
        default:
            break;
    }
    [_imgV1 lolMarkViewImageName:@"bookbiaoqian" Title:title];
    _imgV1.frame = CGRectMake(_lb1.right + 10, 15, 0, 0);
    
    [_btn1 setImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
    _btn1.frame = CGRectMake(SCREEN_WIDTH - 8 - 15, (105 - 15)/2, 8, 15);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
