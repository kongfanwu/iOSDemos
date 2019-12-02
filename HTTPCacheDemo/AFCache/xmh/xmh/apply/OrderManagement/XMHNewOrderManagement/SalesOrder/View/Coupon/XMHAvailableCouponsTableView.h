//
//  XMHAvailableCouponsTableView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseTableView.h"
@class SATicketModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHAvailableCouponsTableView : XMHBaseTableView
@property (nonatomic, strong) NSMutableArray *dataArr; //数据源
@property (nonatomic, copy)void(^selectedCouponsModel)(SATicketModel *ticketModel);
@property (nonatomic, strong)SATicketModel *model;//x已选中的
@end

NS_ASSUME_NONNULL_END
