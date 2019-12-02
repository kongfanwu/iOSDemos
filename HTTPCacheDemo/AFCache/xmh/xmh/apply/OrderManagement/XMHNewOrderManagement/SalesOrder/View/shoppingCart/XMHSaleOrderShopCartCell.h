//
//  XMHSaleOrderShopCartCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class XMHNumberView;
@interface XMHSaleOrderShopCartCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) XMHNumberView *numberView;
@property (nonatomic, copy) void (^didDeleteBlock)(XMHSaleOrderShopCartCell *cell);

- (void)configModel:(id)model;
@end

NS_ASSUME_NONNULL_END
