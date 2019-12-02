//
//  MinePWCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MinePWCell.h"
@interface MinePWCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
@implementation MinePWCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textField.delegate = self;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_MinePWCellBlock) {
        _MinePWCellBlock(textField.text);
    }
}

#pragma mark - NSNotificationCenter

- (void)textFieldTextDidChangeNotification:(NSNotification *)not {
    if (not.object == _textField) {
        if (_MinePWCellBlock) {
            _MinePWCellBlock(_textField.text);
        }
    }
}

@end
