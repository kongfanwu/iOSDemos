//
//  XMHSalesOrderTableView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSalesOrderTableView : UITableView

@property (nonatomic, strong) NSMutableArray *dataArr; //数据源
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *cardName;
@property (nonatomic, assign) CGFloat cellH;
/** 是否搜索状态 */
@property (nonatomic) BOOL isSearch;
@property (nonatomic, copy) void(^didSelectModel)(SaleModel *model);
@end

NS_ASSUME_NONNULL_END
