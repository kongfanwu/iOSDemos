//
//  XMHCouponStoreModel.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponStoreModel : NSObject

/** <##> */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
/** <##> */
@property (nonatomic) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
