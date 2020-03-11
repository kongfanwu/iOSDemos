//
//  FTFormInputCell.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormInputCell.h"

@interface FTFormInputCell()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel, *valueLabel, *detailTitleLable;
@end

@implementation FTFormInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = UILabel.new;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
        }];
        
        self.valueLabel = UILabel.new;
        [self.contentView addSubview:_valueLabel];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel);
            make.left.mas_equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(-15);
        }];
    }
    return self;
}

- (void)configRow:(FTFormRow *)row {
    self.titleLabel.text = row.title;
    self.valueLabel.text = [row.universalConversion conversionValue];
}

@end
