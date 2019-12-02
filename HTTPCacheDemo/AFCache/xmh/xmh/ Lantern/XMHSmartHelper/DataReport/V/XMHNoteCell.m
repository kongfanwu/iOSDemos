//
//  XMHNoteCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHNoteCell.h"
#import "NSString+NCDate.h"
@interface XMHNoteCell ()
/** 时间戳 */
@property (nonatomic, strong) UIImageView *mark;
/** 时间戳线 */
@property (nonatomic, strong) UIView *markLine;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIView *bgView;
/** 执行方式 */
@property (nonatomic, strong) UILabel *methodLab;
/** 发送成功状态 */
@property (nonatomic, strong) UILabel *statusLab;
/** 追踪顾客 */
@property (nonatomic, strong) UILabel *traceLab;
/** 发送失败 */
@property (nonatomic, strong) UILabel *failLab;

@end

@implementation XMHNoteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBackgroundColor;
       [self creatSubViews];
    }
    return self;
}

- (void)configureWithModel:(XMHExecutionResultModel *)model
{
    [super configureWithModel:model];
    self.timeLab.text = [NSString stringWithFormat:@"执行时间: %@",[NSString formateDateToYYYYMMddHHmm:model.send_date]];
    self.methodLab.text = [NSString stringWithFormat:@"执行方式: 短信"];
    self.statusLab.text = [NSString stringWithFormat:@"发送成功: %@人",model.success];
    self.traceLab.text = [NSString stringWithFormat:@"追踪顾客: %@人",model.all];
    self.failLab.text = [NSString stringWithFormat:@"发送失败: %@人",model.failure];
}
- (void)creatSubViews
{
    self.mark = [[UIImageView alloc]init];
    self.mark.image = [UIImage imageNamed:@"huodongzhongxin_shijianzhou"];
    [self.contentView addSubview:self.mark];
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    self.markLine = [[UIView alloc]init];
    self.markLine.backgroundColor =  [ColorTools colorWithHexString:@"#f10180"];
    [self.contentView addSubview:self.markLine];
    [self.markLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mark.mas_bottom);
        make.centerX.mas_equalTo(self.mark.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    self.timeLab = [[UILabel alloc]init];
    self.timeLab.font = [UIFont systemFontOfSize:16];
    self.timeLab.textColor = kColor3;
    self.timeLab.text = @"执行时间: 2017年10月11日 09:00";
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mark.mas_right).mas_offset(10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLab.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-25);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.timeLab.mas_bottom).mas_offset(10);
    }];
    
    
    self.methodLab = [[UILabel alloc]init];
    self.methodLab.font = [UIFont systemFontOfSize:14];
    self.methodLab.textColor = kColor6;
    self.methodLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.methodLab];
    [self.methodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    self.statusLab =  [[UILabel alloc]init];
    self.statusLab.font = [UIFont systemFontOfSize:14];
    self.statusLab.textColor = kColor6;
    self.statusLab.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.methodLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
    }];
    
    self.traceLab = [[UILabel alloc]init];
    self.traceLab.font = [UIFont systemFontOfSize:14];
    self.traceLab.textColor = kColor6;
    self.traceLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.traceLab];
    [self.traceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.statusLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.statusLab.mas_right);
    }];
    
    self.failLab = [[UILabel alloc]init];
    self.failLab.font = [UIFont systemFontOfSize:14];
    self.failLab.textColor = kColor6;
    self.failLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.failLab];
    [self.failLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.traceLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.statusLab.mas_right);
        make.bottom.mas_equalTo(-15);
    }];
}
- (void)updataMarkLine
{
    [self.markLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mark.mas_bottom);
        make.centerX.mas_equalTo(self.mark.mas_centerX);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(1);
    }];
}
- (void)resetMarkLine
{
    [self.markLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mark.mas_bottom);
        make.centerX.mas_equalTo(self.mark.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(1);
    }];
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
