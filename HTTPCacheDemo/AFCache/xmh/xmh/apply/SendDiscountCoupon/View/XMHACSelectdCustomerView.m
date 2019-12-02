//
//  XMHACSelectdCustomerView.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSelectdCustomerView.h"

@interface XMHACSelectdCustomerView ()
@property (weak, nonatomic) IBOutlet UIButton *selectedCustomerBtn;
@property (weak, nonatomic) IBOutlet UIButton *addCustomerBtn;
/** 已添加顾客*人 */
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) NSMutableArray * modelArr;
@end
@implementation XMHACSelectdCustomerView
- (IBAction)selectedCustomerBtnClick:(id)sender {
    if (_selectdCustomerViewBlock) {
        _selectdCustomerViewBlock(_modelArr);
    }
}

- (IBAction)addCustomerBtnClick:(id)sender {
    if (_addCustomerViewBlock) {
        _addCustomerViewBlock();
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgView.backgroundColor = kColorF5F5F5;
    _bgView.layer.cornerRadius = 5;
    _infoLab.textColor = kColor6;
    _infoLab.font = FONT_SIZE(15);
}
- (void)updateView:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
    _infoLab.text = [NSString stringWithFormat:@"已添加顾客%ld人",modelArr.count];
}

@end
