//
//  XMHRankExpendCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRankExpendCell.h"

@interface XMHRankExpendCell ()
/** 白色背景 */
@property (nonatomic, strong) UIView *bgView;
/** 项目名 */
@property (nonatomic, strong) UILabel *nameLab;
/** 排名 */
@property (nonatomic, strong) UILabel *rankLab;
/** 下划线 */
@property (nonatomic, strong) UIView  *lineView;
/** 消耗人数 */
@property (nonatomic, strong) UILabel *lab1;
/** 消耗业绩 */
@property (nonatomic, strong) UILabel *lab2;
/** 业绩占比 */
@property (nonatomic, strong) UILabel *lab3;
/** 下划线 */
@property (nonatomic, strong) UIView *expendLineView;
/** 疗程消耗 */
@property (nonatomic, strong) UILabel *liaochengLab;
/** 储值卡消耗 */
@property (nonatomic, strong) UILabel *chuzhikaLab;
/** 疗程消耗 - 消耗人数 */
@property (nonatomic, strong) UILabel *expendLab1;
/** 疗程消耗 - 消耗业绩 */
@property (nonatomic, strong) UILabel *expendLab2;
/** 疗程消耗 - 业绩占比 */
@property (nonatomic, strong) UILabel *expendLab3;
/** 储值卡消耗 - 消耗人数 */
@property (nonatomic, strong) UILabel *expendLab4;
/** 储值卡消耗 - 消耗业绩 */
@property (nonatomic, strong) UILabel *expendLab5;
/** 储值卡消耗 - 业绩占比 */
@property (nonatomic, strong) UILabel *expendLab6;
/** 收起图标 */
@property (nonatomic, strong) UIImageView *expendImage;
@end

@implementation XMHRankExpendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBackgroundColor;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.bgView = UIView.new;
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.bgView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.bgView];
    
    self.nameLab = UILabel.new;
    self.nameLab.textColor = kColor3;
    self.nameLab.font = FONT_SIZE(15);
    [self.bgView addSubview:self.nameLab];
    
    self.rankLab = UILabel.new;
    self.rankLab.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    self.rankLab.font = FONT_SIZE(14);
    [self.bgView addSubview:self.rankLab];
    
    self.lineView = UIView.new;
    self.lineView.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:self.lineView];
    
    self.lab1 = UILabel.new;
    self.lab1.textColor = kLabelText_Commen_Color_6;
    self.lab1.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab1];
    
    self.lab2 = UILabel.new;
    self.lab2.textColor = kLabelText_Commen_Color_6;
    self.lab2.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab2];
    
    self.lab3 = UILabel.new;
    self.lab3.textColor = kLabelText_Commen_Color_6;
    self.lab3.font = FONT_SIZE(12);
    [self.bgView addSubview:self.lab3];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.rankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.bgView.centerX);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom);
        make.left.right.mas_equalTo(self.bgView);
        make.height.mas_equalTo(kSeparatorHeight);
        
    }];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
    }];
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-15);
    }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lab1.mas_bottom).mas_offset(5);
         make.height.mas_equalTo(16);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
    }];
   

    self.expendLineView = UIView.new;
    self.expendLineView.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:self.expendLineView];
    
    self.liaochengLab = UILabel.new;
    self.liaochengLab.text = @"疗程消耗";
    self.chuzhikaLab = UILabel.new;
    self.chuzhikaLab.text = @"储值卡消耗";
    self.expendLab1 = UILabel.new;
    self.expendLab2 = UILabel.new;
    self.expendLab3 = UILabel.new;
    self.expendLab4 = UILabel.new;
    self.expendLab5 = UILabel.new;
    self.expendLab6 = UILabel.new;
    
    self.liaochengLab.font = self.chuzhikaLab.font = FONT_SIZE(14);
    self.liaochengLab.textColor = self.chuzhikaLab.textColor = kColor3;
    self.expendLab1.font = self.expendLab2.font = self.expendLab3.font =
    self.expendLab4.font = self.expendLab5.font = self.expendLab6.font = FONT_SIZE(12);
    self.expendLab1.textColor = self.expendLab2.textColor = self.expendLab3.textColor =
    self.expendLab4.textColor = self.expendLab5.textColor = self.expendLab6.textColor = kColor6;
    
    [self.bgView addSubview:self.liaochengLab];
    [self.bgView addSubview:self.chuzhikaLab];
    [self.bgView addSubview:self.expendLab1];
    [self.bgView addSubview:self.expendLab2];
    [self.bgView addSubview:self.expendLab3];
    [self.bgView addSubview:self.expendLab4];
    [self.bgView addSubview:self.expendLab5];
    [self.bgView addSubview:self.expendLab6];
    
    self.expendImage = [[UIImageView alloc]init];
    // 默认收起
    [self.expendImage setImage:[UIImage imageNamed:@"paimingxiangqing_zhankai"]];
    [self.bgView addSubview:self.expendImage];
    
 
    
    [self.expendLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lab3.mas_bottom).mas_offset(15);
        make.left.right.mas_equalTo(self.bgView);
        make.height.mas_equalTo(kSeparatorHeight);
    }];
    
    [self.liaochengLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(self.expendLineView.mas_bottom).mas_offset(15);
        
        
    }];

    [self.chuzhikaLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.top.mas_equalTo(self.expendLineView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(-15);
    }];

    [self.expendLab1  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.chuzhikaLab.mas_bottom).mas_offset(10);
    }];
    [self.expendLab2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.expendLab1.mas_bottom).mas_offset(5);
    }];
    [self.expendLab3  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.expendLab2.mas_bottom).mas_offset(5);
    }];

    [self.expendLab4  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.top.mas_equalTo(self.chuzhikaLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-15);
    }];
    [self.expendLab5  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.top.mas_equalTo(self.expendLab4.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(16);
        make.right.mas_equalTo(-15);
    }];
    
    [self.expendLab6  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(40);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(16);
//        make.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(self.expendLab5.mas_bottom).mas_offset(5);
    }];

    [self.expendImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.expendLab6.mas_bottom).mas_offset(15);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(19, 7));

    }];
}

- (void)updateCellWithModel:(XMHXiaohaoYeJiModel *)model rank:(NSInteger)rank
{

    self.nameLab.text = IsEmpty(model.name) ? @"" : model.name;
    self.rankLab.text = [NSString stringWithFormat:@"消耗排名:  %ld",rank];
    self.lab1.text = [NSString stringWithFormat:@"消耗人数:  %@人",model.total_num];
    self.lab2.text = [NSString stringWithFormat:@"消耗业绩:  %@元",model.total_price];
    self.lab3.text = [NSString stringWithFormat:@"业绩占比:  %.2f%%",[model.total_bfb floatValue]];
    self.expendLab1.text = [NSString stringWithFormat:@"消耗人数:  %@人",model.liao_num];
    self.expendLab2.text = [NSString stringWithFormat:@"消耗业绩:  %@元",model.liao_price];
    self.expendLab3.text = [NSString stringWithFormat:@"业绩占比:  %.2f%%",[model.liao_bfb floatValue]];
    self.expendLab4.text = [NSString stringWithFormat:@"消耗人数:  %@人",model.ti_num];
    self.expendLab5.text = [NSString stringWithFormat:@"消耗业绩:  %@元",model.ti_price];;
    self.expendLab6.text = [NSString stringWithFormat:@"业绩占比:  %.2f%%",[model.ti_bfb floatValue]];
//    if ([model.type isEqualToString:@"goods"]) { // 只有项目会出现消耗的列表
//        self.liaochengLab.hidden = self.chuzhikaLab.hidden = self.expendLab1.hidden = self.expendLab2.hidden = self.expendLab3.hidden
//        = self.expendLab4.hidden = self.expendLab5.hidden = self.expendLab6.hidden = self.expendImage.hidden = YES;
//        self.expendLineView.backgroundColor = UIColor.whiteColor;
//        [self.lab3 mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.top.mas_equalTo(self.lab1.mas_bottom).mas_offset(5);
//            make.bottom.mas_equalTo(-10);
//            make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
//        }];
//
//        [self.expendLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.lab3.mas_bottom);
//            make.left.right.mas_equalTo(self.bgView);
//            make.height.mas_equalTo(kSeparatorHeight);
//        }];
//    }else{
       
        self.liaochengLab.hidden = self.chuzhikaLab.hidden = self.expendLab1.hidden = self.expendLab2.hidden = self.expendLab3.hidden
        = self.expendLab4.hidden = self.expendLab5.hidden = self.expendLab6.hidden = !model.isExpand;
        
        self.expendImage.hidden = NO;
        
        [self.lab3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.lab1.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-40);
        }];
        
        [self.expendLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lab3.mas_bottom).mas_offset(15);
            make.left.right.mas_equalTo(self.bgView);
            make.height.mas_equalTo(kSeparatorHeight);
        }];
        
        if (model.isExpand) {
            
            [self.expendImage setImage:[UIImage imageNamed:@"paimingxiangqing_shousuo"]];
            self.expendLineView.backgroundColor = kSeparatorLineColor;
            
           
            [self.expendImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.expendLab6.mas_bottom).mas_offset(15);
                make.centerX.mas_equalTo(self.bgView.mas_centerX);
                make.bottom.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(19, 7));
                
            }];
        }else{
            [self.expendImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.expendLineView.mas_bottom);
                make.centerX.mas_equalTo(self.bgView.mas_centerX);
                make.bottom.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(19, 7));
                
            }];
            [self.expendImage setImage:[UIImage imageNamed:@"paimingxiangqing_zhankai"]];
            self.expendLineView.backgroundColor = UIColor.whiteColor;
        }
//    }
    
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
