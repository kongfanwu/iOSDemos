//
//  XMHACCouponListCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACCouponListCell.h"
#import "XMHCouponListStateItemModel.h"
#import "XMHCouponModel.h"
#import "NSDate+Extension.h"
#import "NSString+NCDate.h"
@interface XMHACCouponListCell()
/** 时间戳 */
@property (nonatomic, strong) UIImageView *mark;
/** 时间戳线 */
@property (nonatomic, strong) UIView *markLine;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIView *bgView;
/** 票券名称 */
@property (nonatomic, strong) UILabel *nameLab;
/** 状态 */
@property (nonatomic, strong) UILabel *statusLab;
/** 剩余库存 */
@property (nonatomic, strong) UILabel *remainNumLab;
/** 票券类型 */
@property (nonatomic, strong) UILabel *typeLab;
/** 面值*/
@property (nonatomic, strong) UILabel *priceLab;
/** 有效期*/
@property (nonatomic, strong) UILabel *durationLab;
/** 按钮*/
@property (nonatomic, strong) UIView *toolView;
@end

@implementation XMHACCouponListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    self.timeLab.text = @"2017年10月11日 09:00";
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
//        make.height.mas_equalTo(177);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-30);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.timeLab.mas_bottom).mas_offset(10);
    }];
    
    self.statusLab =  [[UILabel alloc]init];
    self.statusLab.font = [UIFont systemFontOfSize:11];
    self.statusLab.textColor = kColor3;
    self.statusLab.textColor = [ColorTools colorWithHexString:@"#FF967A"];
    self.statusLab.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(50);
    }];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font = [UIFont systemFontOfSize:15];
    self.nameLab.textColor = kColor3;
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(self.statusLab.mas_left);
    }];
    
    self.remainNumLab = [[UILabel alloc]init];
    self.remainNumLab.font = [UIFont systemFontOfSize:11];
    self.remainNumLab.textColor = kColor9;
    self.remainNumLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.remainNumLab];
    [self.remainNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.nameLab.mas_right);
    }];
    
    self.typeLab = [[UILabel alloc]init];
    self.typeLab.font = [UIFont systemFontOfSize:11];
    self.typeLab.textColor = kColor9;
    self.typeLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.typeLab];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.remainNumLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self.nameLab.mas_right);
    }];
    
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.font = [UIFont systemFontOfSize:11];
    self.priceLab.textColor = kColor9;
    self.priceLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.typeLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self.typeLab.mas_right);
    }];
    
    self.durationLab = [[UILabel alloc]init];
    self.durationLab.font = [UIFont systemFontOfSize:11];
    self.durationLab.textColor = kColor9;
    self.durationLab.textAlignment = NSTextAlignmentLeft;
    
    [self.bgView addSubview:self.durationLab];
    [self.durationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.priceLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(-15);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"huodongzhongxin_youjiantou"];
    [self.bgView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(6, 11));
        make.centerY.mas_equalTo(self.typeLab.mas_centerY);
    }];
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kSeparatorColor;
    [self.bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.top.mas_equalTo(self.durationLab.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.bgView.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right);
    }];
    
    self.toolView = UIView.new;
    [self.bgView addSubview:self.toolView];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bgView);
        make.top.equalTo(line.mas_bottom).offset(15);
//        make.height.mas_equalTo(37);
        make.bottom.mas_equalTo(-15);
    }];
    

    
}
- (void)configureWithModel:(XMHCouponModel *)model {
    [super configureWithModel:model];
    self.nameLab.text = [NSString stringWithFormat:@"券名称: %@",model.name];
    self.remainNumLab.text = [NSString stringWithFormat:@"剩余库存: %@",model.remain_num];
    self.timeLab.text = [NSString formateDateToYYYYMMddHHmm:model.insert_time];
    NSString *duration;
    if ([model.usable_type integerValue] == 1) {//固定时间
        duration = [NSString stringWithFormat:@"券有效期: %@ - %@",model.start_time,model.end_time];
    }else{
        duration = [NSString stringWithFormat:@"券有效期: 领券后%@天后生效,有效期%@天",model.delay,model.duration];
    }
    self.durationLab.text = duration;
    NSString *type;
    NSString *price;
    if ([model.type isEqualToString:@"3"]) {
        type = @"现金券";
        if ([model.fulfill floatValue] > 0) {
            price = [NSString stringWithFormat:@"%@-%@",model.fulfill,model.price] ;
        }else{
            price = model.price;
        }
        
    }else if ([model.type isEqualToString:@"4"]){
          type = @"折扣券";
          price = [NSString stringWithFormat:@"%@折",model.discount] ;
        
    }else if ([model.type isEqualToString:@"5"]){
        type = @"礼品券";
        price = @"--";
    }
    self.priceLab.text = [NSString stringWithFormat:@"面值: %@",price];
    self.typeLab.text = [NSString stringWithFormat:@"券类型: %@",type];
    NSString *status;
    if ([model.status isEqualToString:@"3"]) {
        status = @"未投放 ";
    }else if ([model.status isEqualToString:@"4"]){
        status = @"已投放";
    }else if ([model.status isEqualToString:@"5"]){
        status = @"已过期";
    }
    self.statusLab.text = status;
   
    [_toolView removeAllSubViews];
    
    NSArray *items = [model itemsTitleFromType];
    if (items.count) {
        for (int i = 0; i < items.count; i++) {
            XMHCouponListStateItemModel *couponListStateItemModel = items[i];
            UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [oneButton setTitle:couponListStateItemModel.title forState:UIControlStateNormal];
            [oneButton setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
            oneButton.titleLabel.font = FONT_SIZE(13);
            oneButton.layer.cornerRadius = 5;
            oneButton.layer.masksToBounds = YES;
            oneButton.layer.borderWidth = kBorderWidth;
            oneButton.layer.borderColor = kBtn_Commen_Color.CGColor;
            [oneButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_toolView addSubview:oneButton];
            oneButton.tag = 1000 + i;
        }
        // 一个按钮布局
        if (_toolView.subviews.count ==  1) {
            UIButton *oneButton = _toolView.subviews.firstObject;
            [oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_toolView);
                make.width.mas_equalTo(70);
                make.right.mas_equalTo(-10);
                make.bottom.equalTo(_toolView);
            }];
        }
        // 多个按钮布局
        else if (_toolView.subviews.count > 1) {
            [_toolView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_toolView);
                make.bottom.equalTo(_toolView);
            }];
            CGFloat leftGap = (SCREEN_WIDTH - 54) - (items.count * 70) - (items.count * 15);
            if (items.count == 4) { // 4个按钮会出现放不下的UI问题,特此修改
                 [_toolView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:15 tailSpacing:15];
            }else{
                [_toolView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:leftGap tailSpacing:15];
            }
        }
    }
    
}
- (void)buttonClick:(UIButton *)sender {
    NSArray *items = [(XMHCouponModel *)self.model itemsTitleFromType];
    NSInteger tag = sender.tag - 1000;
    XMHCouponListStateItemModel *couponListStateItemMode = items[tag];
    if (self.didSelectClickBlock) self.didSelectClickBlock(self, couponListStateItemMode);
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
