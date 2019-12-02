//
//  XMHOutComeCouponInfoCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOutComeCouponInfoCell.h"
#import "NSString+NCDate.h"

@interface XMHOutComeCouponInfoCell ()
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *timeLab;
@property (strong, nonatomic) UILabel *methodLab;
@property (strong, nonatomic) UILabel *traceLab;
@property (strong, nonatomic) UILabel *sendLab;

@end

@implementation XMHOutComeCouponInfoCell
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
        
        self.lineView = UIView.new;
        self.lineView.backgroundColor = kSeparatorColor;
        [self.bgView addSubview:self.lineView];
        
        self.timeLab = UILabel.new;
        self.timeLab.textColor = kColor3;
        self.timeLab.font = FONT_SIZE(16);
        [self.bgView addSubview:self.timeLab];
        
        self.methodLab = UILabel.new;
        self.methodLab.textColor = kColor3;
        self.methodLab.font = FONT_SIZE(16);
        [self.bgView addSubview:self.methodLab];
        
        self.traceLab = UILabel.new;
        self.traceLab.textColor = kColor3;
        self.traceLab.font = FONT_SIZE(16);
        [self.bgView addSubview:self.traceLab];
        
        self.sendLab = UILabel.new;
        self.sendLab.textColor = kColor3;
        self.sendLab.font = FONT_SIZE(16);
        [self.bgView addSubview:self.sendLab];
        
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(50);
            
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(self.bgView.mas_right);
            make.top.mas_equalTo(self.titleLab.mas_bottom);
            make.height.mas_equalTo(kSeparatorHeight);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_left);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(18);
            
        }];
        [self.methodLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_left);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.timeLab.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(18);
            
        }];
        [self.traceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_left);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.methodLab.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(18);
            
        }];
        
        [self.sendLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_left);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.traceLab.mas_bottom).mas_offset(10);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-15);
            
        }];
        
    }
    return self;
}

- (void)configureWithModel:(XMHExecutionResultModel *)model
{
    [super configureWithModel:model];
    self.titleLab.text = model.name;
    self.timeLab.text = [NSString stringWithFormat:@"执行时间：%@",[NSString formateDateToYYYYMMddHHmm:model.send_date]?[NSString formateDateToYYYYMMddHHmm:model.send_date]:@""];
    self.methodLab.text = [NSString stringWithFormat:@"执行方式：优惠券 "];
    self.traceLab.text = [NSString stringWithFormat:@"追踪顾客：%@人",model.all];
    self.sendLab.text = [NSString stringWithFormat:@"每人发送：%@张",model.person_send];
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
