//
//  XMHCredentiaManageVenditionSaleCell.h
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCredentiaSalesOrderMdoel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaManageVenditionSaleCell : UITableViewCell

@property (nonatomic, copy) void (^didSelectClickBlock)(XMHCredentiaManageVenditionSaleCell *cell, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel);
@end

NS_ASSUME_NONNULL_END
