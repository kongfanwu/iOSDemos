//
//  XMHVipDisDetailCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHVipDisDetailCell.h"
#import "ZheKouModel.h"
#import "UIButton+EnlargeTouchArea.h"
@interface XMHVipDisDetailCell()
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *storePrLab;//储值卡余额
@property (nonatomic, strong) UILabel *salePrLab;//折扣卡余额
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) ZheKouStored_Card *model;
@end

@implementation XMHVipDisDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化子视图
        [self initLayout];
    }
    return self;
    
}
- (void)refreshCellModel:(ZheKouStored_Card *)model
{
    self.nameLab.text = model.name;
    if (model.xm_discount != 0 && model.cp_discount != 0) {
        NSString *xmZhekou = [NSString stringWithFormat:@"%.1ld",model.xm_discount /10];
        NSString *cpZhekou = [NSString stringWithFormat:@"%.1ld",model.cp_discount /10];
        self.storePrLab.text = [NSString stringWithFormat:@" 项目折扣: %@折 ",xmZhekou];
        self.salePrLab.text = [NSString stringWithFormat:@" 产品折扣: %@折 ",cpZhekou];
        self.salePrLab.hidden = NO;
        self.salePrLab.hidden = NO;
    }else{
        self.storePrLab.text = @" VIP折扣 ";
        self.salePrLab.hidden = YES;
    }
    
    self.selectBtn.selected = model.selected;
    self.model = model;
    [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
}
-(void)initLayout
{
    
    
//    self.bgView = [[UIView alloc]init];
//    self.bgView.backgroundColor = UIColor.whiteColor;
//    [self.contentView addSubview:self.bgView];
    
    self.bgImageView = [[UIImageView alloc]init];
    self.bgImageView.image = [UIImage imageNamed:@"youhuiquan_zhekouquan"];
    [self.contentView addSubview:self.bgImageView];
    self.bgImageView.userInteractionEnabled = YES;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-7);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];

    
    //设置阴影
//    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
//    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
//    self.bgView.layer.shadowOpacity = 1.5;
//    self.bgView.layer.shadowRadius = 3;
    //clipsToBounds为true不会显示阴影
    //shadowView.clipsToBounds = true

    self.nameLab = [[UILabel alloc]init];
    self.nameLab.text = @"储值卡";
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.textColor = kLabelText_Commen_Color_6;
    self.nameLab.font = [UIFont systemFontOfSize:22];
    [self.bgImageView addSubview:self.nameLab];
    
    self.storePrLab = [[UILabel alloc]init];
    self.storePrLab.textAlignment = NSTextAlignmentCenter;
    self.storePrLab.backgroundColor = [ColorTools colorWithHexString:@"#FC558B"];
    self.storePrLab.text = @"项目折扣:";
    self.storePrLab.layer.cornerRadius = 3;
    self.storePrLab.layer.masksToBounds = YES;
    self.storePrLab.textColor = UIColor.whiteColor;
    self.storePrLab.font = [UIFont systemFontOfSize:12];
    [self.bgImageView addSubview:self.storePrLab];
    
    self.salePrLab = [[UILabel alloc]init];
    self.salePrLab.textAlignment = NSTextAlignmentCenter;
    self.salePrLab.backgroundColor = [ColorTools colorWithHexString:@"#FC558B"];
    self.salePrLab.text = @"产品折扣:";
    self.salePrLab.layer.cornerRadius = 3;
    self.salePrLab.layer.masksToBounds = YES;
    self.salePrLab.textColor = UIColor.whiteColor;
    self.salePrLab.font = [UIFont systemFontOfSize:12];
    [self.bgImageView addSubview:self.salePrLab];
    
   
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:self.selectBtn];
   [self.selectBtn setEnlargeEdgeWithTop:100 right:30 bottom:40 left:100];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(kMargin);
        make.right.mas_equalTo(self.mas_right).mas_offset(-50);
    }];

    [self.storePrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(12);
        make.height.mas_equalTo(19);
        
    }];
    [self.storePrLab sizeToFit];

    [self.salePrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storePrLab.mas_right).mas_offset(kMargin);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(12);
        make.height.mas_equalTo(19);
        
    }];
    
     [self.salePrLab sizeToFit];
  
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(30);

    }];

   
    [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
}
- (void)btnClick
{
    self.model.selected = !self.model.selected;
    if (self.selectedDetail) {
        self.selectedDetail(self.model);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    if (selected) {
//        self.selectBtn.selected = YES;
//    }else{
//         self.selectBtn.selected = NO;
//    }

    // Configure the view for the selected state
}

@end
