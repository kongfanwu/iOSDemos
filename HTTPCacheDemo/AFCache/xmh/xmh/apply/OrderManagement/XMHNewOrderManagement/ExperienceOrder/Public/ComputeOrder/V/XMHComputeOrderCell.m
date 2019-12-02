//
//  XMHComputeOrderCell.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOrderCell.h"
#import "XMHComputeOredrModel.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "XMHShoppingCartManager.h"
#import "XMHServiceGoodsModel.h"
#import "XMHServiceProjectModel.h"

@interface XMHComputeOrderCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation XMHComputeOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = kColorF5F5F5;
        
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

- (UILabel *)createLabel {
    UILabel *nameLabel = UILabel.new;
    nameLabel.font = FONT_SIZE(11);
    nameLabel.textColor = kColor9;
    return nameLabel;
}

- (void)configureWithModel:(id)model {
    [super configureWithModel:model];
    
    [_bgView removeAllSubViews];
    
    self.titleLabel = UILabel.new;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.textColor = kColor3;
    _titleLabel.text = @"结算统计";
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.mas_equalTo(15);
    }];
    
    XMHComputeOredrModel *computeOredrModel = (XMHComputeOredrModel *)model;
    NSInteger count = computeOredrModel.modelArray.count + 1;
    
    UILabel *lastNumLabel;
    UIView *lineView, *lineView2;
    for (int i = 0; i < count; i++) {
        UILabel *nameLabel = [self createLabel];
        [_bgView addSubview:nameLabel];
        
        UILabel *numLabel = [self createLabel];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:numLabel];
        
        UILabel *typeLabel = [self createLabel];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:typeLabel];
        
        UILabel *xiaoHaoLabel = [self createLabel];
        xiaoHaoLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:xiaoHaoLabel];
        
        if (i == 0) {
            nameLabel.font = FONT_SIZE(14);
            nameLabel.textColor = kColor3;
            nameLabel.text = @"商品名称";
            
            numLabel.font = FONT_SIZE(14);
            numLabel.textColor = kColor3;
            numLabel.text = @"数量";
            
            typeLabel.font = FONT_SIZE(14);
            typeLabel.textColor = kColor3;
            typeLabel.text = @"服务类型";
            
            xiaoHaoLabel.font = FONT_SIZE(14);
            xiaoHaoLabel.textColor = kColor3;
            xiaoHaoLabel.text = @"消耗";
            
            [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom).offset(15);
                make.width.mas_equalTo(50);
                make.right.equalTo(_bgView.mas_centerX);
            }];
            
            [nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel);
                make.left.mas_equalTo(15);
                make.right.equalTo(numLabel.mas_left);
            }];
            
            [typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel);
                make.left.equalTo(_bgView.mas_centerX);
                make.width.mas_equalTo(70);
            }];
            
            [xiaoHaoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel);
                make.left.equalTo(typeLabel.mas_right);
                make.right.mas_equalTo(-15);
            }];
            
            lineView = [self createLineView];
            [_bgView addSubview:lineView];
            [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel.mas_bottom).offset(15);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(kSeparatorHeight);
            }];
        } else {
            id model = computeOredrModel.modelArray[i-1];
            // 项目 产品 体验服务-项目 体验服务-产品
            if ([model isKindOfClass:[SLS_Pro class]] ||
                [model isKindOfClass:[SLGoodModel class]] ||
                [model isKindOfClass:[SLPro_ListM class]] ||
                [model isKindOfClass:[SLGoods_ListM class]]) {
                SLS_Pro *amodel = (SLS_Pro *)model;
                nameLabel.text = amodel.name;
                numLabel.text = @(amodel.selectCount).stringValue;
                typeLabel.text = [amodel stringFromType];
                xiaoHaoLabel.text = [NSString stringWithFormat:@"¥%.2f", [amodel computeTotalPrice]];
                //[NSString stringWithFormat:@"¥%.2f", [amodel.inputPrice floatValue] * amodel.selectCount];
            }
            else if ([model isKindOfClass:[XMHServiceGoodsModel class]] || [model isKindOfClass:[XMHServiceProjectModel class]]) {
                XMHServiceGoodsModel *amodel = (XMHServiceGoodsModel *)model;
                nameLabel.text = amodel.name;
                numLabel.text = @(amodel.selectCount).stringValue;
                typeLabel.text = [amodel stringFromType];
//                xiaoHaoLabel.text = [NSString stringWithFormat:@"¥%.2f", [amodel.price floatValue] * amodel.selectCount];
                xiaoHaoLabel.text = [NSString stringWithFormat:@"¥%.2f", [amodel computeTotalPrice]];
            }
            
            
            [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (lastNumLabel) {
                    make.top.equalTo(lastNumLabel.mas_bottom).offset(10);
                } else {
                    make.top.equalTo(lineView.mas_bottom).offset(10);
                }
                make.width.mas_equalTo(50);
                make.right.equalTo(_bgView.mas_centerX);
            }];
            
            [nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel);
                make.left.mas_equalTo(15);
                make.right.equalTo(numLabel.mas_left);
            }];
            
            [typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel);
                make.left.equalTo(_bgView.mas_centerX);
                make.width.mas_equalTo(70);
            }];
            
            [xiaoHaoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(numLabel);
                make.left.equalTo(typeLabel.mas_right);
                make.right.mas_equalTo(-15);
            }];
            
            lastNumLabel = numLabel;
            
            if (i == count - 1) {
                lineView2 = [self createLineView];
                [_bgView addSubview:lineView2];
                [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastNumLabel.mas_bottom).offset(10);
                    make.left.mas_equalTo(15);
                    make.right.mas_equalTo(-15);
                    make.height.mas_equalTo(kSeparatorHeight);
                }];
            }
        }
    }
    UIView *shiChangView = [self createBgViewTitle:@"服务总时长" value:[NSString stringWithFormat:@"%@分钟", computeOredrModel.shiChang]];
    [_bgView addSubview:shiChangView];
    [shiChangView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (lineView2) {
            make.top.equalTo(lineView2.mas_bottom).offset(10);
        } else {
            make.top.equalTo(lineView.mas_bottom).offset(10);
        }
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    UIView *projectNumView = [self createBgViewTitle:@"服务总项目数" value:@(computeOredrModel.modelArray.count).stringValue];
    [_bgView addSubview:projectNumView];
    [projectNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shiChangView.mas_bottom).offset(10);
        make.left.right.height.equalTo(shiChangView);
    }];
    
//    NSString *jiShiStr = [self jishiStringJiShiList:[self jiShiListComputeOredrModel:computeOredrModel]];
//    NSString *jiShiStr = [self jishiStringJiShiList:computeOredrModel.jiShiList];
//    UIView *jiShiView = [self createBgViewTitle:@"服务技师" value:jiShiStr];
    
    UIView *jiShiView = [self createJiShiViewTitle:@"服务技师" value:computeOredrModel.jiShiList];
    [_bgView addSubview:jiShiView];
    [jiShiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(projectNumView.mas_bottom).offset(10);
        make.left.right.equalTo(projectNumView);
    }];
    
    // 提卡价格
    CGFloat tikaPrice = XMHShoppingCartManager.sharedInstance.tiKaPrice;
    if (computeOredrModel.tikaPrice > 0) {
        tikaPrice = computeOredrModel.tikaPrice;
    }
    
    // 总价格
//    NSString *price = [NSString stringWithFormat:@"¥%.2f", XMHShoppingCartManager.sharedInstance.originPrice];
    NSString *price = [NSString stringWithFormat:@"¥%.2f", XMHShoppingCartManager.sharedInstance.allPrice];
    // 查看，服务端返回的价格
    if (computeOredrModel.price > 0) {
        price = computeOredrModel.price;
    }
    UIView *moneyView;
    if (_createOrderType == XMHCreateOrderTypeExperience) {
        moneyView = [self createBgViewTitle:@"销售服务总金额" value:price];
    } else if (_createOrderType == XMHCreateOrderTypeService) {
        moneyView = [self createBgViewTitle:@"总消耗金额" value:price];
    }
    
    [_bgView addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiShiView.mas_bottom).offset(10);
        make.left.right.equalTo(jiShiView);
        make.height.mas_equalTo(17);
        
        // 服务单，没有提卡金额
        if (_createOrderType == XMHCreateOrderTypeService && !(tikaPrice > 0)) {
            make.bottom.equalTo(_bgView).offset(-15);
        }
    }];
    
    // 提卡金额
    UIView *tiKaMoneyView;
    if (tikaPrice > 0) {
        tiKaMoneyView = [self createBgViewTitle:@"提卡金额" value:[NSString stringWithFormat:@"¥%.2f", tikaPrice]];
        [_bgView addSubview:tiKaMoneyView];
        [tiKaMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyView.mas_bottom).offset(10);
            make.left.right.equalTo(jiShiView);
            make.height.mas_equalTo(17);
            if (_createOrderType == XMHCreateOrderTypeService) {
                make.bottom.equalTo(_bgView).offset(-15);
            }
        }];
    }
    
    // 需支付金额
    UIView *payMoneyView;
    if (_createOrderType == XMHCreateOrderTypeExperience) {
        // 需支付金额 ： 总金额 - 折扣卷金额
        NSString *price;
        if (computeOredrModel.price) {
            price = computeOredrModel.price;
        } else {
            price = [NSString stringWithFormat:@"¥%.2f", XMHShoppingCartManager.sharedInstance.allPrice];
        }
        payMoneyView = [self createBgViewTitle:@"需支付金额" value:price];
        [_bgView addSubview:payMoneyView];
        [payMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tiKaMoneyView) {
                make.top.equalTo(tiKaMoneyView.mas_bottom).offset(10);
            } else {
                make.top.equalTo(moneyView.mas_bottom).offset(10);
            }
            make.left.right.equalTo(jiShiView);
            make.height.mas_equalTo(17);
            make.bottom.equalTo(_bgView).offset(-15);
        }];
    }
}

- (UIView *)createJiShiViewTitle:(NSString *)title value:(NSArray <MLJiShiModel *> *)jishiArray {
    UIView *bgView = UIView.new;
    
    UILabel *shiChangLabel = [self createLabel];
    shiChangLabel.font = FONT_SIZE(14);
    shiChangLabel.textColor = kColor3;
    [bgView addSubview:shiChangLabel];
    shiChangLabel.text = title;
    [shiChangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *lastShiChangValueLabel;
    for (int i = 0; i < jishiArray.count; i++) {
        MLJiShiModel *jishiModel = jishiArray[i];
        UILabel *shiChangValueLabel = [self createLabel];
        shiChangValueLabel.font = FONT_SIZE(14);
        shiChangValueLabel.textColor = kColor6;
        shiChangValueLabel.textAlignment = NSTextAlignmentRight;
        shiChangValueLabel.text = jishiModel.name;
        [bgView addSubview:shiChangValueLabel];
        
        [shiChangValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shiChangLabel.mas_right).offset(10);
            make.right.mas_equalTo(bgView).offset(-15);
            make.height.mas_equalTo(17);
            if (i == 0) {
                make.top.mas_equalTo(0);
            } else {
                make.top.equalTo(lastShiChangValueLabel.mas_bottom).offset(10);
            }
            if (i == jishiArray.count - 1) {
                make.bottom.mas_equalTo(0);
            }
        }];
        lastShiChangValueLabel = shiChangValueLabel;
    }
    
    return bgView;
}

- (UIView *)createBgViewTitle:(NSString *)title value:(NSString *)value {
    UIView *bgView = UIView.new;
    
    UILabel *shiChangLabel = [self createLabel];
    shiChangLabel.font = FONT_SIZE(14);
    shiChangLabel.textColor = kColor3;
    [bgView addSubview:shiChangLabel];
    shiChangLabel.text = title;
    [shiChangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *shiChangValueLabel = [self createLabel];
    shiChangValueLabel.font = FONT_SIZE(14);
    shiChangValueLabel.textColor = kColor6;
    shiChangValueLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:shiChangValueLabel];
    shiChangValueLabel.text = value;
    [shiChangValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shiChangLabel.mas_right).offset(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(bgView).offset(-15);
    }];
    return bgView;
}

- (UIView *)createLineView {
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    return lineView;
}

/**
 获取技师列表。剔除不同产品一个技师服务情况

 @return 技师集合
 */
- (NSMutableArray *)jiShiListComputeOredrModel:(XMHComputeOredrModel *)computeOredrModel {
    NSMutableArray *allJiShiList = NSMutableArray.new;
    for (SLS_Pro *model in computeOredrModel.modelArray) {
        [allJiShiList addObjectsFromArray:model.jiShiList];
    }

    NSMutableArray *jiShiList = NSMutableArray.new;
    for (MLJiShiModel *jishiModel in allJiShiList) {
        if (![self isExistJiShiModel:jishiModel jiShiList:jiShiList]) {
            [jiShiList addObject:jishiModel];
        }
    }
    return jiShiList;
}

/**
 技师集合是否存在技师model

 @param jishiModel 技师mdoel
 @param jiShiList 集合
 @return YES 存在，
 */
- (BOOL)isExistJiShiModel:(MLJiShiModel *)jishiModel jiShiList:(NSArray *)jiShiList {
    __block BOOL exist = NO;
    for (MLJiShiModel *obj in jiShiList) {
        if (obj.ID == jishiModel.ID) {
            exist = YES;
        }
        if (exist) return exist;
    }
    return exist;
}

/**
 拼接所有技师名，返回字符串

 @param jiShiList 技师集合
 @return 技师名字符串
 */
- (NSString *)jishiStringJiShiList:(NSArray *)jiShiList {
    NSMutableString *string = NSMutableString.new;
    for (int i = 0; i < jiShiList.count; i++) {
        MLJiShiModel *jishiModel = jiShiList[i];
        if (i == jiShiList.count - 1) {
            [string appendString:jishiModel.name];
        } else {
            [string appendFormat:@"%@  ", jishiModel.name];
        }
    }
    return string;
}

@end
