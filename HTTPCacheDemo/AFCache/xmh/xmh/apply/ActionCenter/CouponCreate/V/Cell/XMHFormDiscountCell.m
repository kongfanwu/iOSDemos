//
//  XMHFormDiscountCell.m
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormDiscountCell.h"
#import "NSString+Check.h"

@interface XMHFormDiscountCell()
/** <##> */
@property (nonatomic, strong) UILabel *suggestiveLabel;
@end

@implementation XMHFormDiscountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.suggestiveLabel = UILabel.new;
        _suggestiveLabel.font = FONT_SIZE(12);
        _suggestiveLabel.textColor = [ColorTools colorWithHexString:@"#F5BB4F"];
        [self.contentView addSubview:_suggestiveLabel];
        _suggestiveLabel.mas_key = @"suggestiveLabel";
    }
    return self;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    
    _suggestiveLabel.text = model.value2;
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.titleLabel.width);
        make.left.top.mas_equalTo(15);
    }];
    
    if (IsEmpty(model.valueType)) {
        self.valueTypeLabel.hidden = YES;
        
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(44).priorityMedium();
            make.top.equalTo(self.lineView.mas_bottom);
            if (!model.isEdit) {
                make.bottom.mas_equalTo(0);
            }
        }];
    } else {
        self.valueTypeLabel.hidden = NO;
        self.valueTypeLabel.text = model.valueType;
        
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(self.valueTypeLabel.mas_left).offset(-10);
            make.height.mas_equalTo(44).priorityMedium();
            make.top.equalTo(self.lineView.mas_bottom);
            if (!model.isEdit) {
                make.bottom.mas_equalTo(0);
            }
        }];
        
        [self.valueTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.textField);
            make.left.equalTo(self.textField.mas_right).offset(10);
        }];
    }
    
    if (model.isEdit) {
        _suggestiveLabel.hidden = NO;
        [_suggestiveLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textField.mas_bottom);
            make.left.equalTo(self.titleLabel);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
        }];
    } else {
        _suggestiveLabel.hidden = YES;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    XMHFormModel *formModel = (XMHFormModel *)self.model;
    // 折扣额度
    if ([formModel.serviceKey isEqualToString:@"discount"]) {
        if (IsEmpty(newString)) return YES;
        BOOL bl = [newString evaluateRegex:XMHRegexOneNumOneFloat];
        return bl;
    }
    // 折扣限额
    else if ([formModel.serviceKey isEqualToString:@"fulfill"]) {
        
    }
    
    return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
}


@end
