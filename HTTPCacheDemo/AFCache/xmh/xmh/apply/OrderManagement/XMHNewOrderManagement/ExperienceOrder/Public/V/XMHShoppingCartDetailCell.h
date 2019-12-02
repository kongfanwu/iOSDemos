//
//  XMHShoppingCartDetailCell.h
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XMHNumberView;
@interface XMHShoppingCartDetailCell : UITableViewCell

/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) XMHNumberView *numberView;

/** <#type#> */
@property (nonatomic, copy) void (^didDeleteBlock)(XMHShoppingCartDetailCell *cell);

- (void)configModel:(id)model;

@end

NS_ASSUME_NONNULL_END
