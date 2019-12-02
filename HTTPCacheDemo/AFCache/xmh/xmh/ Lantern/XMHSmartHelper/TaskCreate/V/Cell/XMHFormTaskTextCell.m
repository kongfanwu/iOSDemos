//
//  XMHFormTaskTextCell.m
//  xmh
//
//  Created by kfw on 2019/6/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskTextCell.h"
@interface XMHFormTaskTextCell()
/** <##> */
@property (nonatomic, strong) UILabel *leftLabel, *contentLabel;
@end

@implementation XMHFormTaskTextCell

// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHFormTaskTextCell class] forKey:XLFormRowDescriptorTypeXMHFormTaskTextCell];
}

// 这个方法是用来设置属性的 必须重写  类似于初始化的属性不变的属性进行预先配置
- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.leftLabel = UILabel.new;
    self.leftLabel.textColor = kColor3;
    self.leftLabel.font = FONT_SIZE(16);
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel sizeToFit];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(self.leftLabel);
    }];
    
    self.contentLabel = UILabel.new;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = kColor3;
    self.contentLabel.font = FONT_SIZE(16);
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel sizeToFit];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.contentLabel.height < 20 ? 20 : self.contentLabel.height).priorityLow();
        make.left.mas_equalTo(self.leftLabel.mas_right);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    
    // 拉伸优先级低
    [self.contentLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    // 压缩优先级低
    [self.contentLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
}

// 这个方法是用来进行更新的，外面给唯一的字段Value设定值就好了 通过self.rowDescriptor.value的值变化来进行更新
- (void)update
{
    [super update];
    self.leftLabel.text = self.rowDescriptor.title;
    self.contentLabel.text = [self.rowDescriptor valueTransformerDisplayText];
    
    [self.leftLabel sizeToFit];
    [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.leftLabel);
    }];
    
    [self.contentLabel sizeToFit];
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.contentLabel.height).priorityLow();
    }];
    
}


@end
