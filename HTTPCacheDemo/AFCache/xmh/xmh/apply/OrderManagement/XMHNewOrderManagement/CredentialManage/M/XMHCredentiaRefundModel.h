//
//  XMHCredentiaRefundModel.h
//  xmh
//
//  Created by KFW on 2019/4/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 退款model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaRefundModel : NSObject
/** 编码 */
@property (nonatomic, copy) NSString *code;
/** 用户id */
@property (nonatomic, copy) NSString *ids;
/** 发起人 */
@property (nonatomic, copy) NSString *inper_name;
/** 发起时间 */
@property (nonatomic, copy) NSString *create_time;
/** 退款金额 */
@property (nonatomic, copy) NSString *actual;
/** 用户姓名 */
@property (nonatomic, copy) NSString *user_name;
/** 用户手机号 */
@property (nonatomic, copy) NSString *user_mobile;
/** 所属门店 */
@property (nonatomic, copy) NSString *store_name;
@end

NS_ASSUME_NONNULL_END
