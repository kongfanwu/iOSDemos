//
//  TJBBListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJBBModel;
@interface TJBBListModel : NSObject
@property (nonatomic, strong)NSArray <TJBBModel *>*next;
@end

@interface TJBBModel : NSObject
/** 名称 */
@property (nonatomic, copy)NSString *name;
/** 岗位id */
@property (nonatomic, copy)NSString *fram_id;
/** 主角色 */
@property (nonatomic, copy)NSString *main_role;
/** 账号 */
@property (nonatomic, copy)NSString *account;
/** 接待客次 */
@property (nonatomic, copy)NSString *keci;
/** 有效顾客 */
@property (nonatomic, copy)NSString *youxiaoguke;
/** 销售业绩 */
@property (nonatomic, copy)NSString *xiaoshouyeji;
/** 实操项目数 */
@property (nonatomic, copy)NSString *shicaoxianmushu;
/** 消耗业绩 */
@property (nonatomic, copy)NSString *xiaohaoyeji;
/** 月活动顾客 */
@property (nonatomic, copy)NSString *yuehuodongguke;
/** 消耗/销售占比 */
@property (nonatomic, copy)NSString *bfb;
/** 数据选择 */
@property (nonatomic, copy)NSString *type;
@end
