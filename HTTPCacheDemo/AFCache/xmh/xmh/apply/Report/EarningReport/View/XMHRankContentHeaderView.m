//
//  XMHRankContentHeaderView.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRankContentHeaderView.h"
#import "XMHRankModel.h"
@interface XMHRankContentHeaderView ()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *companyLab;
@property (nonatomic, strong) UILabel *regionLab;
@property (nonatomic, strong) UILabel *storeLab;
@property (nonatomic, strong) UIView *detailView;
@end

@implementation XMHRankContentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.titleLab = UILabel.new;
    self.companyLab = UILabel.new;
    self.regionLab = UILabel.new;
    self.storeLab = UILabel.new;
    self.detailView = UIView.new;
    [self addSubview:self.titleLab];
    [self addSubview:self.detailView];
//    [self.detailView addSubview:self.regionLab];
    [self.detailView addSubview:self.companyLab];
    [self.detailView addSubview:self.storeLab];
   
   
    self.titleLab.textColor =  kColor3;
    self.titleLab.font = FONT_SIZE(15);
    self.companyLab.textColor =  self.regionLab.textColor = self.storeLab.textColor = kColor6;
    self.companyLab.font = self.regionLab.font = self.storeLab.font = FONT_SIZE(12);
    self.storeLab.textAlignment = NSTextAlignmentRight;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(15);
    }];
   
//    [self.detailView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:58 leadSpacing:0 tailSpacing:0];
    [self.detailView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:0 tailSpacing:0];
    [self.detailView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
}
- (void)updateHeaderViewhWithType:(XMHRankContentType)type model:(nullable id)model
{
    XMHRankModel *rankModel = (XMHRankModel *)model;
    if (type == XMHRankContentTypeSale) {
        self.titleLab.text = @"销售排名详情";
        self.companyLab.text = [NSString stringWithFormat:@"公司排名:%@",rankModel.join_sales_pai];
        self.storeLab.text = [NSString stringWithFormat:@"门店排名:%@",rankModel.men_sales_pai];
    }else{
        self.titleLab.text = @"消耗排名详情";
        self.companyLab.text = [NSString stringWithFormat:@"公司排名:%@",rankModel.join_serv_pai];
        self.storeLab.text = [NSString stringWithFormat:@"门店排名:%@",rankModel.men_serv_pai];
    }
   
}
@end
