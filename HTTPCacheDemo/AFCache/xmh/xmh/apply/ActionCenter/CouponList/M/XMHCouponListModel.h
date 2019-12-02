//
//  XMHCouponListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  XMHCouponModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHCouponModel *> *list;
@end

NS_ASSUME_NONNULL_END
