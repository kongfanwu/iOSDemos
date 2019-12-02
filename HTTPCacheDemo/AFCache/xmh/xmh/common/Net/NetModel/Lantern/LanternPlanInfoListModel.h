//
//  LanternPlanInfoListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LanternPlanInfoModel,LanternPlanProModel;
@interface LanternPlanInfoListModel : NSObject
@property (nonatomic, strong)NSArray <LanternPlanInfoModel *>*list;
@end
@interface LanternPlanInfoModel : NSObject
@property (nonatomic, copy)NSString *join_code;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *grade;
@property (nonatomic, copy)NSString *store_code;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *rate;
@property (nonatomic, assign)BOOL selected;
@property (nonatomic, strong)NSMutableArray <LanternPlanProModel *>*pro;
@end
@interface LanternPlanProModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *selectNum;
/** 判断是否是消耗 1是  0不是 */
@property (nonatomic, copy)NSString *isXH;
@property (nonatomic, assign)BOOL selected;
/** 判断是否是系统 或者 后添加的 */
@property (nonatomic, assign)BOOL isAdd;
@property (nonatomic, assign)BOOL isEdit;
@end
