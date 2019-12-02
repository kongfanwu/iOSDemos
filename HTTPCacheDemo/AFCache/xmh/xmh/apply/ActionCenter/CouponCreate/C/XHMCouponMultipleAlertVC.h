//
//  XHMCouponMultipleAlertVC.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 多选alert vc

#import <UIKit/UIKit.h>
#import "XMHItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XHMCouponMultipleAlertVC : UIViewController
/** default YES */
@property (nonatomic) BOOL edit;
/** <##> */
@property (nonatomic, strong) NSArray <XMHItemModel *>*dataArray;
/** 选中的 */
@property (nonatomic, strong) NSArray *selectArray;
/** 保存多选数据集合 是否是全部数据 默认 NO
    如果是 YES 优先级比 selectArray 高
 */
@property (nonatomic, getter=isDataArrayAll) BOOL dataArrayAll;

/** <##> */
@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, copy) void (^selectBlock)(NSMutableArray <XMHItemModel *>* selectList, BOOL isAll);
@end

NS_ASSUME_NONNULL_END
