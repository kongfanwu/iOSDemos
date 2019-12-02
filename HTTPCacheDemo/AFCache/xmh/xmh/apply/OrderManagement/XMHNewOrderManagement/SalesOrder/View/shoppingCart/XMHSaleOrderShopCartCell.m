//
//  XMHSaleOrderShopCartCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderShopCartCell.h"
#import "XMHNumberView.h"
#import "SASaleListModel.h"
#import "XMHShoppingCartManager.h"
@interface XMHSaleOrderShopCartCell()
@property (nonatomic, strong)SaleModel *model;
@end

@implementation XMHSaleOrderShopCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.numberView = [[XMHNumberView alloc] init];
        _numberView.minNumber = 0;
        [self.contentView addSubview:self.numberView];
        [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
        WeakSelf
//
//        [self.numberView setDelectChangeBlock:^(XMHNumberView * _Nonnull numberView) {
//            
//            // 1 购买数量减到0，移除购物车
//            if (numberView.currentNumber == 0) {
//                [XMHShoppingCartManager.sharedInstance deleteModel:weakSelf.model];
//                if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
//                return;
//            }
//            [weakSelf configModel:weakSelf.model];
//        }];
//        [self.numberView setAddChangeBlock:^(XMHNumberView * _Nonnull numberView) {
//            weakSelf.numberView.currentNumber = 1;
//        }];
        
        [self.numberView setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
            // 1 购买数量减到0，移除购物车
            if (numberView.currentNumber == 0) {
                [XMHShoppingCartManager.sharedInstance deleteModel:weakSelf.model];
                if (weakSelf.didDeleteBlock) weakSelf.didDeleteBlock(weakSelf);
                return;
            }
            if ([weakSelf.model respondsToSelector:@selector(setSelectCount:)]) {
                // 最大购买数
                NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:weakSelf.model];
                // 限制最大购买
                if (numberView.currentNumber > maxNum) {
                    numberView.currentNumber = maxNum;
                    
                    [XMHProgressHUD showOnlyText:@"库存不足"];
                    return;
                }
                [weakSelf.model setValue:@(numberView.currentNumber) forKey:@"selectCount"];
                [XMHShoppingCartManager.sharedInstance computePrice];
            }
            
            [weakSelf configModel:weakSelf.model];
        }];
        self.priceLab = UILabel.new;
        _priceLab.font = FONT_SIZE(15);
        _priceLab.textColor = kColor3;
        _priceLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        [self.priceLab sizeToFit];
        
        self.titleLabel = UILabel.new;
        self.titleLabel.font = FONT_SIZE(15);
        self.titleLabel.textColor = kColor3;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(_priceLab.mas_left).mas_offset(-10);
            make.centerY.equalTo(self.contentView);
        }];

    }
    return self;
}
- (void)configModel:(id)model
{

    self.model = (SaleModel *)model;
    if ([self.model.cardType isEqualToString:@"pro"]) {
         self.titleLabel.text = [NSString stringWithFormat:@"%@(%@次)",self.model.name,self.model.ciShu];
    }
//    else if ([self.model.cardType isEqualToString:@"card_course"]){
//         self.titleLabel.text = self.model.name;
//        
//        NSDictionary *baohanJsonDic = [self.model.baohanJsonStr dictionaryWithJsonString:self.model.baohanJsonStr];
//        NSMutableArray *tempArr = [NSMutableArray array];
//        NSArray *arr = [baohanJsonDic safeObjectForKey:@"daixuan"];
//        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
//            NSDictionary *dic = (NSDictionary *)obj;
//            CGFloat group_price = [[dic safeObjectForKey:@"group_price"] floatValue];
//            NSInteger num = [[dic safeObjectForKey:@"num"]integerValue];
//            CGFloat price = group_price / num;
//            CGFloat finalPrice =  price * self.model.selectCount;
//            [tempDic setDictionary:dic];
//            [tempDic setValue:@(finalPrice) forKey:@"group_price"];
//            [tempDic setValue:@(self.model.selectCount) forKey:@"num"];
//            [tempArr safeAddObject:tempDic];
//        }];
//        [baohanJsonDic  setValue:tempArr forKey:@"daixuan"];
//        self.model.baohanJsonStr = baohanJsonDic.jsonData;
//        NSLog(@"购物车加减self.model.baohanJsonStr= %@",self.model.baohanJsonStr);
//    }
    else{
        self.titleLabel.text = self.model.name;
    }
  
  
    //零售价
    self.priceLab.text = [NSString stringWithFormat:@"￥%.2f",[self.model computeTotalPrice]];//[self.model.inputPrice floatValue]
    self.numberView.maxNumber = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:model];
    self.numberView.currentNumber = self.model.selectCount;
    
    NSLog(@"self.detailModel setBaohanJsonStr = %@",self.model.baohanJsonStr);
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
