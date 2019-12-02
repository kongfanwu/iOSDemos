//
//  RefundPerformanceModel.h
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundPerformanceModel : NSObject
/** 业绩名称 */
@property (nonatomic, copy)NSString * name;
/** 判断怎么展示
    1、业绩归属
    2、门店归属
    3、店长归属
    4、员工归属
    5、公共业绩
    6、员工
 */
@property (nonatomic, assign)NSInteger type;
/** 业绩归属名称 */
@property (nonatomic, assign)NSString * valueName;
/** 业绩多少 */
@property (nonatomic, assign)NSString * valueInput;
/** 员工账号 */
@property (nonatomic, copy)NSString * account;
/** 业绩归属 */
@property (nonatomic, copy)NSString * belong;
+ (instancetype)createModelName:(NSString *)name Type:(NSInteger)type valueName:(NSString *)valueName;
+ (instancetype)createModelName:(NSString *)name Type:(NSInteger)type valueName:(NSString *)valueName account:(NSString *)account;
@end
