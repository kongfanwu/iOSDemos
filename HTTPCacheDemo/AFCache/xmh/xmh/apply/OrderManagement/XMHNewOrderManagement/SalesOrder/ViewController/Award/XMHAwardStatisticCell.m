//
//  XMHAwardStatisticCell.m
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAwardStatisticCell.h"
#import "SASaleListModel.h"
@interface XMHAwardStatisticCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation XMHAwardStatisticCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = Color_NormalBG;
        
        self.bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.contentView);
            
        }];
    }
    return self;
}
- (void)refresCellModelArr:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
    [_bgView removeAllSubViews];
    
    self.titleLabel = UILabel.new;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.textColor = kColor3;
    _titleLabel.text = @"奖项赠送";
    
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:UIImageName(@"service_add") forState:UIControlStateNormal];
    [_bgView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
    }];
    UILabel *lastNumLabel;
    UIView *lineView;
    for (int i = 0; i < modelArr.count; i++) {
        
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.textColor = kLabelText_Commen_Color_3;
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:nameLab];
        
        UILabel *numLab = [[UILabel alloc]init];
        numLab.textColor = kLabelText_Commen_Color_3;
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:numLab];
        
        UILabel *priceLab = [[UILabel alloc]init];
        priceLab.textColor = kLabelText_Commen_Color_3;
        priceLab.textAlignment = NSTextAlignmentRight;
        priceLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:priceLab];
        
        if (i == 0) {
            nameLab.text = @"奖赠内容";
            numLab.text = @"奖赠数量";
            priceLab.text = @"奖赠价值";
            
            [numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(18);
                make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(kMargin);
                make.width.mas_equalTo(100);
                make.centerX.mas_equalTo(_bgView.mas_centerX);
            }];
            [nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kMargin);
                make.right.mas_equalTo(numLab.mas_left);
                make.height.mas_equalTo(18);
                make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(kMargin);
            }];
            [priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
                make.height.mas_equalTo(18);
                make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(kMargin);
                make.left.mas_equalTo(numLab.mas_right);
            }];
            lineView = UIView.new;
            lineView.backgroundColor = UIColor.whiteColor;
            [_bgView addSubview:lineView];
            
            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLab.mas_bottom);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(1);
            }];
           
            
        }else{
            
            SaleModel *saleModel = [modelArr safeObjectAtIndex:i];
            numLab.textColor = nameLab.textColor = priceLab.textColor = kLabelText_Commen_Color_9;
            numLab.font = nameLab.font = priceLab.font = [UIFont systemFontOfSize:11];
            numLab.text  = [NSString stringWithFormat:@"%ld",saleModel.mzzAwardCount];
            nameLab.text = saleModel.name;
            priceLab.text = [NSString stringWithFormat:@"%ld",saleModel.mzzAwardCount * saleModel.price_list.pro_11.price.integerValue] ; //[NSString stringWithFormat:@"%ld",saleModel.mzzAwardTotlePrice];
            [numLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(14);
                if (lastNumLabel) {
                    make.top.equalTo(lastNumLabel.mas_bottom).offset(10);
                } else {
                    make.top.equalTo(lineView.mas_bottom).offset(5);
                }
                make.width.mas_equalTo(100);
                make.centerX.mas_equalTo(_bgView.mas_centerX);
            }];
            [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kMargin);
                make.right.mas_equalTo(numLab.mas_left);
                make.height.mas_equalTo(14);
                make.top.mas_equalTo(numLab.mas_top);
            }];
            
            lastNumLabel = numLab;
            
            UIButton *deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deletBtn setImage:UIImageName(@"order_close") forState:UIControlStateNormal];
            deletBtn.tag = 1000 + i;
            [_bgView addSubview:deletBtn];
            [deletBtn addTarget:self action:@selector(delectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(10, 10));
                make.right.mas_equalTo(-15);
                make.centerY.mas_equalTo(priceLab.mas_centerY);
            }];
            
            [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(deletBtn.mas_left).mas_offset(-kMargin);
                make.height.mas_equalTo(14);
                make.top.mas_equalTo(numLab.mas_top);
                make.left.mas_equalTo(numLab.mas_right);
            }];
             self.model = saleModel;
        }
        
    }
}
- (void)addBtnClick
{
    if (_addAward) {
        _addAward();
    }
}
- (void)delectBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - 1000;
    [self.modelArr removeObjectAtIndex:index];
    if (_delectAward) {
        _delectAward(self.modelArr);
    }
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
