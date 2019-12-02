//
//  XMHReportCouponCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHReportCouponCell.h"
#import "XMHCouponModel.h"
#import "NSString+NCDate.h"
@interface XMHReportCouponCell ()
/** 时间戳 */
@property (nonatomic, strong) UIImageView *mark;
/** 时间戳线 */
@property (nonatomic, strong) UIView *markLine;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIView *bgView;
/** 执行方式 */
@property (nonatomic, strong) UILabel *methodLab;
/** 到店顾客 */
@property (nonatomic, strong) UILabel *arriveLab;
/** 追踪顾客 */
@property (nonatomic, strong) UILabel *traceLab;


/** 优惠券名称 */
@property (nonatomic, strong) UILabel *nameLab;
/** 赠送个数 */
@property (nonatomic, strong) UILabel *giveLab;
/** 使用个数 */
@property (nonatomic, strong) UILabel *useLab;
/**  */
@property (nonatomic, strong) UIView *line;
@end

@implementation XMHReportCouponCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBackgroundColor;
        [self creatSubViews];
    }
    return self;
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
    
}
- (void)configureWithModel:(XMHExecutionResultModel *)model
{
    [super configureWithModel:model];
    [_bgView removeAllSubViews];
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
    
    self.arriveLab =  [[UILabel alloc]init];
    self.arriveLab.font = [UIFont systemFontOfSize:14];
    self.arriveLab.textColor = kColor6;
    self.arriveLab.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.arriveLab];
    [self.arriveLab mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(self.arriveLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.arriveLab.mas_right);
    }];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = kSeparatorColor;
    [_bgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.traceLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(kSeparatorHeight);
    }];
    self.timeLab.text = [NSString stringWithFormat:@"执行时间: %@",[NSString formateDateToYYYYMMddHHmm:model.send_date]];
    self.methodLab.text = [NSString stringWithFormat:@"执行方式: 优惠券"];
    self.arriveLab.text = [NSString stringWithFormat:@"到店顾客: %@人",model.daodian];
    self.traceLab.text = [NSString stringWithFormat:@"追踪顾客: %@人",model.all];
    
    UILabel *lastUseLab;
    UIView *lineView;
    for (int i = 0; i < model.ticket_list.count; i++) {
        XMHCouponModel *couponModel = [model.ticket_list safeObjectAtIndex:i];
       
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.textColor = kColor6;
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.font = [UIFont systemFontOfSize:14];
        nameLab.text = couponModel.brand;
        [_bgView addSubview:nameLab];
        
        UILabel *giveLab = [[UILabel alloc]init];
        giveLab.textColor = kColor6;
        giveLab.textAlignment = NSTextAlignmentLeft;
        giveLab.font = [UIFont systemFontOfSize:14];
        giveLab.text = [NSString stringWithFormat:@"赠送%@个",couponModel.fa_num];
        [_bgView addSubview:giveLab];
        
        UILabel *useLab = [[UILabel alloc]init];
        useLab.textColor = kColor6;
        useLab.textAlignment = NSTextAlignmentLeft;
        useLab.font = [UIFont systemFontOfSize:14];
        useLab.text = [NSString stringWithFormat:@"使用%@个",couponModel.zhi_num];
        [_bgView addSubview:useLab];
        
        lineView = UIView.new;
        lineView.backgroundColor = kSeparatorColor;
        [_bgView addSubview:lineView];
        
      
        [nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(17);
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(-15);
            if (lastUseLab) {
                make.top.equalTo(lastUseLab.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(self.line.mas_bottom).mas_offset(10);
            }
           
        }];
        CGFloat w = (SCREEN_WIDTH - 52 - 30) * 0.5;
        [giveLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(17);
            make.left.mas_equalTo(kMargin);
            make.width.mas_equalTo(w);
            make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
        }];
        
        [useLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(17);
            make.right.mas_equalTo(-kMargin);
            make.width.mas_equalTo(w);
            make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
        }];
        lastUseLab = useLab;
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(useLab.mas_bottom).offset(10);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            
        }];
        
        if (i == model.ticket_list.count - 1) {
            [useLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-kMargin);
                make.width.mas_equalTo(w);
                make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
                make.bottom.mas_equalTo(-15);
            }];
            
            lineView.hidden = YES;
        }
    }
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
