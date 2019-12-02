//
//  BookCommonCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/18.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookCommonCell.h"
#import "LolHomeModel.h"
@interface BookCommonCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@end
@implementation BookCommonCell
{
    NSDictionary * _textName;
    NSDictionary * _unitName;
    NSDictionary * _stateName;
    NSDictionary * _colorName;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _btn.layer.cornerRadius = 3;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /** 初始化数据 */
    _textName = @{@"1":@{@"0":@"",@"1":@"管理门店",@"2":@"预约服务人数",@"3":@"预约项目"},@"2":@{@"0":@"",@"1":@"员工数",@"2":@"预约服务人数",@"3":@"预约项目"},@"3":@{@"0":@"",@"1":@"所属门店",@"2":@"预约服务人数",@"3":@"预约项目"}};
    _unitName = @{@"1":@{@"0":@"",@"1":@"人",@"2":@"人",@"3":@"个"},@"2":@{@"0":@"",@"1":@"人",@"2":@"人",@"3":@"个"},@"3":@{@"0":@"",@"1":@"",@"2":@"人",@"3":@"个"}};
    _stateName = @{@"1":@"休息",@"2":@"达标",@"3":@"不达标"};
}
- (void)updateBookCommonCellModel:(LolHomeModel *)model pageType:(NSString *)pageType
{
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[pageType][@"1"],model.count,_unitName[pageType][@"1"]];
    _lb3.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[pageType][@"2"],model.num,_unitName[pageType][@"2"]];
    _lb4.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[pageType][@"3"],model.pro_num,_unitName[pageType][@"3"]];
    if (pageType.integerValue == 3) {
        _lb2.hidden = YES;
    }else{
        _lb2.hidden = NO;
    }
    NSString * stateNum = [NSString stringWithFormat:@"%ld",model.state];
    NSString * btnTitle = _stateName[stateNum];
    CGFloat btnW = [btnTitle stringWidthWithFont:FONT_SIZE(11)];
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
    _btnWidth.constant = btnW + 10;
//    [_btn setTitleColor:[ColorTools colorCauseByText:btnTitle] forState:UIControlStateNormal];
    if (model.state == 1) {
        _btn.backgroundColor = kSeparatorLineColor;
    }else if (model.state == 2){
//        _btn.backgroundColor = [ColorTools colorWithHexString:@"#E0ECEB"];
        _btn.layer.borderColor = [ColorTools colorWithHexString:@"#48C2AF"].CGColor;
        _btn.layer.borderWidth = 0.5;
        [_btn setTitleColor:[ColorTools colorWithHexString:@"#48C2AF"] forState:UIControlStateNormal];
    }else{
        _btn.layer.borderColor = [ColorTools colorWithHexString:@"#FF97CE"].CGColor;
        _btn.layer.borderWidth = 0.5;
        [_btn setTitleColor:[ColorTools colorWithHexString:@"#FF97CE"] forState:UIControlStateNormal];
    }
    _btn.backgroundColor = [UIColor whiteColor];
}
- (void)updateBookCommonCellModel:(LolHomeModel *)model pageType:(NSString *)pageType isCengJj:(BOOL)isCJ
{
    _lb1.text = model.name;
    if (isCJ) {
         _lb2.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[pageType][@"1"],model.count,_unitName[pageType][@"3"]];
    }else{
         _lb2.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[@"2"][@"1"],model.count,_unitName[@"2"][@"1"]];
    }
   
    _lb3.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[pageType][@"2"],model.num,_unitName[pageType][@"2"]];
    _lb4.text = [NSString stringWithFormat:@"%@：%ld%@",_textName[pageType][@"3"],model.pro_num,_unitName[pageType][@"3"]];
    if (pageType.integerValue == 3) {
        _lb2.hidden = YES;
    }else{
        _lb2.hidden = NO;
    }
    NSString * stateNum = [NSString stringWithFormat:@"%ld",model.state];
    NSString * btnTitle = _stateName[stateNum];
    CGFloat btnW = [btnTitle stringWidthWithFont:FONT_SIZE(11)];
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
    _btnWidth.constant = btnW + 10;
//    [_btn setTitleColor:[ColorTools colorCauseByText:btnTitle] forState:UIControlStateNormal];
    if (model.state == 1) {
        _btn.backgroundColor = kSeparatorLineColor;
    }else if (model.state == 2){
        //        _btn.backgroundColor = [ColorTools colorWithHexString:@"#E0ECEB"];
        _btn.layer.borderColor = [ColorTools colorWithHexString:@"#48C2AF"].CGColor;
        _btn.layer.borderWidth = 0.5;
        [_btn setTitleColor:[ColorTools colorWithHexString:@"#48C2AF"] forState:UIControlStateNormal];
    }else{
        _btn.layer.borderColor = [ColorTools colorWithHexString:@"#FF97CE"].CGColor;
        _btn.layer.borderWidth = 0.5;
        [_btn setTitleColor:[ColorTools colorWithHexString:@"#FF97CE"] forState:UIControlStateNormal];
    }
    _btn.backgroundColor = [UIColor whiteColor];
}

@end
