//
//  XMHSaleOrderStatisticCell.m
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderStatisticCell.h"
#import "SASaleListModel.h"
#import "XMHBillRecoveryListModel.h"
@interface XMHSaleOrderStatisticCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation XMHSaleOrderStatisticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor redColor];
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
- (void)refresCellModelArr:(NSArray *)modelArr
{
     [_bgView removeAllSubViews];
   
    self.titleLabel = UILabel.new;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.textColor = kColor3;
    _titleLabel.text = @"结算统计";

    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *lastNumLabel;
    UIView *lineView, *lineView2;
    CGFloat totalPrice = 0;
  
    for (int i = 0; i < modelArr.count; i++) {

        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.textColor = kLabelText_Commen_Color_3;//kLabelText_Commen_Color_9;
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:nameLab];

        UILabel *numLab = [[UILabel alloc]init];
        numLab.textColor = kLabelText_Commen_Color_3;//kLabelText_Commen_Color_9;
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:numLab];

        UILabel *priceLab = [[UILabel alloc]init];
        priceLab.textColor = kLabelText_Commen_Color_3;//kLabelText_Commen_Color_9;
        priceLab.textAlignment = NSTextAlignmentRight;
        priceLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:priceLab];
//        self.cellH = 53;//20 + 18 + 15;
        if (i == 0) {
            nameLab.text = @"商品名称";
            numLab.text = @"数量";
            priceLab.text = @"金额总价";

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
            lineView.backgroundColor = kSeparatorColor;
            [_bgView addSubview:lineView];

            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLab.mas_bottom).offset(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(kSeparatorHeight);
            }];

        }
        else{

            SaleModel *saleModel = [modelArr safeObjectAtIndex:i];
             numLab.textColor = nameLab.textColor = priceLab.textColor = kLabelText_Commen_Color_9;
            numLab.font = nameLab.font = priceLab.font = [UIFont systemFontOfSize:11];

            numLab.text  = [NSString stringWithFormat:@"%ld",saleModel.selectCount];
            nameLab.text = saleModel.name;
            if (_buYeji) {
                priceLab.text = [NSString stringWithFormat:@"¥%.2f",[[saleModel inputPrice] floatValue]];
            }else{
                priceLab.text = [NSString stringWithFormat:@"¥%.2f",[saleModel computeTotalPrice]];
            }
            
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
            [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
                make.height.mas_equalTo(14);
                make.top.mas_equalTo(numLab.mas_top);
                make.left.mas_equalTo(numLab.mas_right);
            }];
            lastNumLabel = numLab;
            if (_buYeji) {
                totalPrice = totalPrice + [[saleModel inputPrice] floatValue];
            }else{
                totalPrice = totalPrice + [saleModel computeTotalPrice];
            }
            
            if (i == modelArr.count-1) {

                lineView2 = UIView.new;
                lineView2.backgroundColor = kSeparatorColor;
                [_bgView addSubview:lineView2];

                [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastNumLabel.mas_bottom).offset(5);
                    make.right.left.mas_equalTo(_bgView);
                    make.height.mas_equalTo(kSeparatorHeight);
                }];

            }


        }

    }
//    NSInteger count = modelArr.count - 2;
//    self.cellH =  self.cellH +( count *itemH)+ (count - 1)*10 + 44;
    UILabel *yingfuLab = [[UILabel alloc]init];
    yingfuLab.textColor = kLabelText_Commen_Color_3;
    yingfuLab.textAlignment = NSTextAlignmentLeft;
    yingfuLab.font = [UIFont systemFontOfSize:14];
    yingfuLab.text = @"应付金额";
    [_bgView addSubview:yingfuLab];
    
    UILabel *yinfuPriceLab = [[UILabel alloc]init];
    yinfuPriceLab.textAlignment  =NSTextAlignmentRight;
    yinfuPriceLab.font = [UIFont systemFontOfSize:14];
    yinfuPriceLab.textColor =  kLabelText_Commen_Color_3;
    yinfuPriceLab.text = [NSString stringWithFormat:@"¥%.2f",totalPrice];
    NSDictionary *dict = @{@"totalPrice":@(totalPrice)};
    NSNotification *notification =[NSNotification notificationWithName:@"YINGFUJINERERNotification" object:nil userInfo:dict];
     [[NSNotificationCenter defaultCenter] postNotification:notification];
    [_bgView addSubview:yinfuPriceLab];

    
    if (self.yingfuPrice) { //按产品要求逆向开单增加订单金额
        UILabel *dingdanLab = [[UILabel alloc]init];
        dingdanLab.textColor = kLabelText_Commen_Color_3;
        dingdanLab.textAlignment = NSTextAlignmentLeft;
        dingdanLab.font = [UIFont systemFontOfSize:14];
        dingdanLab.text = @"订单金额";
        [_bgView addSubview:dingdanLab];
        UILabel *dingdanPriceLab = [[UILabel alloc]init];
        dingdanPriceLab.textAlignment  =NSTextAlignmentRight;
        dingdanPriceLab.font = [UIFont systemFontOfSize:14];
        dingdanPriceLab.textColor =  kLabelText_Commen_Color_3;
        dingdanPriceLab.text = [NSString stringWithFormat:@"¥%.2f",totalPrice];
        [_bgView addSubview:dingdanPriceLab];

        [dingdanLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView2.mas_bottom);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(kMargin);
            make.width.mas_equalTo(100);
        }];

        yinfuPriceLab.text = [NSString stringWithFormat:@"¥%.2f",[self.yingfuPrice floatValue]];
        [dingdanPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView2.mas_bottom);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(yingfuLab.mas_right);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
        }];
        [yingfuLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dingdanLab.mas_bottom);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(kMargin);
            make.width.mas_equalTo(100);
        }];
        [yinfuPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dingdanLab.mas_bottom);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(yingfuLab.mas_right);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
        }];
    }else{
         [[NSNotificationCenter defaultCenter]postNotificationName:@"yingfujinerNotification" object:nil];
    
        if (lineView2) {
            [yingfuLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView2.mas_bottom);
                make.height.mas_equalTo(44);
                make.left.mas_equalTo(kMargin);
                make.width.mas_equalTo(100);
            }];
            
            [yinfuPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView2.mas_bottom);
                make.height.mas_equalTo(44);
                make.left.mas_equalTo(yingfuLab.mas_right);//
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
            }];
        }else{
            [yingfuLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(44);
                make.left.mas_equalTo(kMargin);
                make.width.mas_equalTo(100);
            }];
            
            [yinfuPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(44);
                make.left.mas_equalTo(yingfuLab.mas_right);
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
            }];
        }
        
      
        }
}
//账单回收
- (void)refresCellBillRecoverModelArr:(NSArray *)modelArr
{
    [_bgView removeAllSubViews];
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.titleLabel = UILabel.new;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.textColor = kColor3;
    _titleLabel.text = @"结算统计";
    
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *lastNumLabel;
    UIView *lineView, *lineView2;
    CGFloat totalPrice = 0;
    
    for (int i = 0; i < modelArr.count; i++) {

        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.textColor = kLabelText_Commen_Color_3;//kLabelText_Commen_Color_9;
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:nameLab];

        UILabel *numLab = [[UILabel alloc]init];
        numLab.textColor = kLabelText_Commen_Color_3;//kLabelText_Commen_Color_9;
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:numLab];

        UILabel *priceLab = [[UILabel alloc]init];
        priceLab.textColor = kLabelText_Commen_Color_3;//kLabelText_Commen_Color_9;
        priceLab.textAlignment = NSTextAlignmentRight;
        priceLab.font = [UIFont systemFontOfSize:14];
        [_bgView addSubview:priceLab];
        //        self.cellH = 53;//20 + 18 + 15;
        if (i == 0) {
            nameLab.text = @"回收商品";
            numLab.text = @"回收数量";
            priceLab.text = @"回收面额";

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
            lineView.backgroundColor = kSeparatorColor;
            [_bgView addSubview:lineView];

            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLab.mas_bottom).offset(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(kSeparatorHeight);
            }];

        }
        else{

            XMHBillRecoveryStatiscModel *saleModel = [modelArr safeObjectAtIndex:i];
            numLab.textColor = nameLab.textColor = priceLab.textColor = kLabelText_Commen_Color_9;
            numLab.font = nameLab.font = priceLab.font = [UIFont systemFontOfSize:11];

            numLab.text  = saleModel.num;
            nameLab.text = saleModel.name;
            priceLab.text = [NSString stringWithFormat:@"¥%.2f",[saleModel.price floatValue]];
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
            [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
                make.height.mas_equalTo(14);
                make.top.mas_equalTo(numLab.mas_top);
                make.left.mas_equalTo(numLab.mas_right);
            }];
            lastNumLabel = numLab;
            totalPrice = totalPrice + [saleModel.price floatValue];
            if (i == modelArr.count-1) {

                lineView2 = UIView.new;
                lineView2.backgroundColor = kSeparatorColor;
                [_bgView addSubview:lineView2];

                [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastNumLabel.mas_bottom).offset(5);
                    make.right.left.mas_equalTo(_bgView);
                    make.height.mas_equalTo(kSeparatorHeight);
                }];

            }


        }

    }

    UILabel *yingfuLab = [[UILabel alloc]init];
    yingfuLab.textColor = kLabelText_Commen_Color_3;
    yingfuLab.textAlignment = NSTextAlignmentLeft;
    yingfuLab.font = [UIFont systemFontOfSize:14];
    yingfuLab.text = @"回收金额";
    [_bgView addSubview:yingfuLab];
    UILabel *yinfuPriceLab = [[UILabel alloc]init];
    yinfuPriceLab.textAlignment  =NSTextAlignmentRight;
    yinfuPriceLab.font = [UIFont systemFontOfSize:14];
    yinfuPriceLab.textColor =  kLabelText_Commen_Color_3;
    yinfuPriceLab.text = [NSString stringWithFormat:@"¥%.2f",totalPrice];
    NSDictionary *dict = @{@"totalPrice":@(totalPrice)};
    NSNotification *notification =[NSNotification notificationWithName:@"YINGFUJINERERNotification" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [_bgView addSubview:yinfuPriceLab];
    [yingfuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(kMargin);
        make.width.mas_equalTo(100);
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yingfujinerNotification" object:nil];
    [yinfuPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(yingfuLab.mas_right);
        make.right.mas_equalTo(_bgView.mas_right).mas_offset(-kMargin);
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
