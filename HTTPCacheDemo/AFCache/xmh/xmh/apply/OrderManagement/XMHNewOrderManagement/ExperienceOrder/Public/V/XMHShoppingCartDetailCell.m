//
//  XMHShoppingCartDetailCell.m
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHShoppingCartDetailCell.h"
#import "XMHNumberView.h"
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"
#import "SLSCourseExper.h"
#import "XMHShoppingCartManager.h"
#import "XMHBillReListModel.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceGoodsModel.h"

@interface XMHShoppingCartDetailCell()

/** <##> */
@property (nonatomic, strong) id model;
@end

@implementation XMHShoppingCartDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.numberView = [[XMHNumberView alloc] init];
        _numberView.minNumber = 0;
        [self.contentView addSubview:_numberView];
        [_numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
        WeakSelf
        [_numberView setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
            // 服务单,优先处理次类型。因为 XMHServiceProjectModel XMHServiceGoodsModel 也有num属性，但代表不同意义
//            if ([weakSelf.model isKindOfClass:[XMHServiceProjectModel class]] || [weakSelf.model isKindOfClass:[XMHServiceGoodsModel class]]) {
//                XMHServiceProjectModel *goodModel = (XMHServiceProjectModel *)weakSelf.model;
//                goodModel.selectCount = numberView.currentNumber;
//                [XMHShoppingCartManager.sharedInstance computePrice];
//            }
            if ([weakSelf.model respondsToSelector:@selector(setSelectCount:)]) {
                SLS_Pro *goodModel = (SLS_Pro *)weakSelf.model;
                
                // 1 购买数量减到0，移除购物车
                if (numberView.currentNumber == 0) {
                    [XMHShoppingCartManager.sharedInstance deleteModel:goodModel];
                    if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
                    return;
                }
                
                // 最大购买数
                NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:goodModel];
                // 2 限制最大购买
                if (numberView.currentNumber > maxNum) {
                    numberView.currentNumber = maxNum;
                    
                    [XMHProgressHUD showOnlyText:@"库存不足"];
                    return;
                }
                
                goodModel.selectCount = numberView.currentNumber;
                [XMHShoppingCartManager.sharedInstance computePrice];
            }
        }];
        
        self.titleLabel = UILabel.new;
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = kColor3;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(_numberView.mas_left);
            make.centerY.equalTo(self.contentView);
        }];
        _titleLabel.text = @"测试";
    }
    return self;
}

- (void)configModel:(id)model {
    self.model = model;
    // 项目
    if ([model isKindOfClass:[SLS_Pro class]]) {
        SLS_Pro *projectModel = (SLS_Pro *)model;
        _titleLabel.text = projectModel.name;
        _numberView.currentNumber = projectModel.selectCount;
    }
    // 产品
    else if ([model isKindOfClass:[SLGoodModel class]]) {
        SLGoodModel *goodModel = (SLGoodModel *)model;
        _titleLabel.text = goodModel.name;
        _numberView.currentNumber = goodModel.selectCount;
    }
    // SLPro_ListM SLGoods_ListM
    // 体验服务-项目
    else if ([model isKindOfClass:[SLPro_ListM class]]) {
        SLPro_ListM *projectModel = (SLPro_ListM *)model;
        _titleLabel.text = projectModel.name;
        _numberView.currentNumber = projectModel.selectCount;
    }
    // 体验服务-产品
    else if ([model isKindOfClass:[SLGoods_ListM class]]) {
        SLGoods_ListM *goodModel = (SLGoods_ListM *)model;
        _titleLabel.text = goodModel.name;
        _numberView.currentNumber = goodModel.selectCount;
    }
    
    // 服务单
    else if ([model isKindOfClass:[XMHServiceProjectModel class]] || [model isKindOfClass:[XMHServiceGoodsModel class]]) {
        XMHServiceProjectModel *goodModel = (XMHServiceProjectModel *)model;
        _titleLabel.text = goodModel.name;
        _numberView.currentNumber = goodModel.selectCount;
    }
}

@end
