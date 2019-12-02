//
//  XMHFormLogoCell.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormImageCell.h"
#import "UIImageView+YYWebImage.h"

@interface XMHFormImageCell()
/** <##> */
@property (nonatomic, strong) UIImageView *logoImageView;
/** <##> */
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation XMHFormImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.logoImageView = UIImageView.new;
        [self.contentView addSubview:_logoImageView];
        [_logoImageView cornerRadius:3];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:UIImageName(@"shangchuantupian") forState:UIControlStateNormal];
        [_addButton cornerRadius:3];
        [self.contentView addSubview:_addButton];
        __weak typeof(self) _self = self;
        [_addButton bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            if (self.addPhotoClick) self.addPhotoClick(self);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
 
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:model.value] placeholder:kDefaultImage];
    
    if (model.isEdit) {
        [_addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(62, 27));
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(62, 27));
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.right.mas_equalTo(_addButton.mas_left).offset(-10);
        }];
    } else {
        [_logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(62, 27));
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.right.mas_equalTo(-15);
        }];
    }
}

@end
