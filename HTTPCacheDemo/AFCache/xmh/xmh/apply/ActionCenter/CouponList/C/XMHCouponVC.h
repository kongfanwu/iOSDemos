//
//  XMHCouponVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponVC : UIViewController
/** 数据源 */
@property(nonatomic, strong) NSMutableArray *dataArr;
/** type类型 3:现金券 4：折扣券 5：礼品券*/
@property(nonatomic, assign)NSInteger type;
/** 导航控制器 */
@property(nonatomic, strong)UINavigationController *nc;
/**  */
@property(nonatomic, strong) XMHBaseTableView *tableView;

/** 从 1 开始 不传默认第一页 */
@property (nonatomic, assign)NSInteger page;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)requestListDataParmas:(NSMutableDictionary *)params;

@end

NS_ASSUME_NONNULL_END
