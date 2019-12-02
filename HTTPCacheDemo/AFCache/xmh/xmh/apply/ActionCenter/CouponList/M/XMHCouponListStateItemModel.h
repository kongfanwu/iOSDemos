//
//  XMHCouponListStateItemModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponListStateItemModel : NSObject
/** <##> */
@property (nonatomic, copy) NSString *title;
/** */
@property (nonatomic) NSInteger tag;

+ (XMHCouponListStateItemModel *)createTitle:(NSString *)title tag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
