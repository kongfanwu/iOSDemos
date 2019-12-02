//
//  XMHOutComeNoteContentCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeNoteContentCell.h"
@interface XMHOutComeNoteContentCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@end

@implementation XMHOutComeNoteContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBackgroundColor;
        self.bgView = UIView.new;
        self.bgView.backgroundColor = UIColor.whiteColor;
        self.bgView.layer.cornerRadius = 5;
        self.bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.bgView];
        
        self.titleLab = UILabel.new;
        self.titleLab.textColor = kColor3;
        self.titleLab.font = FONT_SIZE(16);
        [self.bgView addSubview:self.titleLab];
        
        self.contentLab = UILabel.new;
        self.contentLab.textColor = kColor3;
        self.contentLab.numberOfLines = 0;
        self.contentLab.font = FONT_SIZE(16);
        [self.bgView addSubview:self.contentLab];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(18);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(80);
        }];
        
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.titleLab.mas_top);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-15);
            
        }];
        
    }
    return self;
}
- (void)configureWithModel:(XMHExecutionResultModel *)model
{
    [super configureWithModel:model];
    
    self.titleLab.text = @"执行内容: ";
    self.contentLab.text = model.track_msg?model.track_msg:@"  ";
  

};
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
