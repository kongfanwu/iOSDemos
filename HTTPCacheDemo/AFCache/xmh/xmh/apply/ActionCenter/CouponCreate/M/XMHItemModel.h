//
//  XMHItemModel.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHItemModel : NSObject
/** 是否选中 */
@property (nonatomic) BOOL isSelect;
/** title */
@property (nonatomic, copy) NSString *title;
/** title */
@property (nonatomic) NSInteger ID;
@property (nonatomic, copy) NSString *idStr;
/** <##> */
@property (nonatomic) XMHActionCouponType type;

+ (XMHItemModel *)createTitle:(NSString *)title type:(XMHActionCouponType)type select:(BOOL)isSelect;

+ (XMHItemModel *)createTitle:(NSString *)title idStr:(NSString *)idstr;
@end

NS_ASSUME_NONNULL_END
