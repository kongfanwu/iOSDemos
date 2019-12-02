//
//  XMHShopModel.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 店铺model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHShopModel : NSObject
/** 门店编码 */
@property (nonatomic, copy) NSString *code;
/** 销售单单数 */
@property (nonatomic, copy) NSString *sales_num;
/** 服务单单数 */
@property (nonatomic, copy) NSString *serv_num;
/** 门店名称 */
@property (nonatomic, copy) NSString *name;
/** 岗位id */
@property (nonatomic, copy) NSString *fram_id;
/** 账号 */
@property (nonatomic, copy) NSString *inId;
@end

NS_ASSUME_NONNULL_END
