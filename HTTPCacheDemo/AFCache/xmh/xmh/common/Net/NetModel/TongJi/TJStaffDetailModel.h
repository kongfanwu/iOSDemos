//
//  TJStaffDetailModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJStaffDetailModel : NSObject
/** 职务 */
@property (nonatomic, copy)NSString *position;
/** 级别 */
@property (nonatomic, copy)NSString *level;
/** 图像 */
@property (nonatomic, copy)NSString *img;
/** 员工名称 */
@property (nonatomic, copy)NSString *name;
/** 年龄 */
@property (nonatomic, copy)NSString *age;
/** 保有顾客数 */
@property (nonatomic, copy)NSString *baoyou_num;
/** 技术力 */
@property (nonatomic, copy)NSString *jishuli;
/** 管理力 */
@property (nonatomic, copy)NSString *guanlili;
/** 服务力 */
@property (nonatomic, copy)NSString *fuwuli;
/** 销售力 */
@property (nonatomic, copy)NSString *xiaoshouli;
/** 销售排名 */
@property (nonatomic, copy)NSString *xiaoshouye_s;
/** 消耗排名 */
@property (nonatomic, copy)NSString *xiaohao_s;
/** 客次排名 */
@property (nonatomic, copy)NSString *keci_s;
/** 成交排名 */
@property (nonatomic, copy)NSString *chengjiao_s;
/** 项目数排名 */
@property (nonatomic, copy)NSString *xiaohaoxiangmu_s;
/** 门店名称 */
@property (nonatomic, copy)NSString *store_name;
@end
