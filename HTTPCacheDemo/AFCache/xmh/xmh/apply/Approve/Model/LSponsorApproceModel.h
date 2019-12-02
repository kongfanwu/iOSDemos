//
//  LSponsorApproceModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class LApprocePersonModel,LDuplicatePersonModel;
@interface LSponsorApproceModel : NSObject
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * join_name;
@property (nonatomic, copy)NSString * initiator;
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * user_mobile;
@property (nonatomic, copy)NSString * user_mdname;
@property (nonatomic, copy)NSString * user_jis_name;
@property (nonatomic, assign)NSInteger user_surplus;
@property (nonatomic, assign)NSInteger user_serNum;
@property (nonatomic, assign)NSInteger user_awardNum;
@property (nonatomic, copy)NSString * user_store_id;

//顾客清卡使用
@property (nonatomic, assign)NSInteger pre_surplus;
@property (nonatomic, assign)NSInteger user_freeze;
///
@property (nonatomic, strong)NSArray <LApprocePersonModel *>* approvalPerson;
@property (nonatomic, strong)NSArray <LDuplicatePersonModel *>* duplicatePerson;
@end
@interface LApprocePersonModel : NSObject
@property (nonatomic, assign)NSInteger u_id;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * head_img;
@property (nonatomic, copy)NSString * frame_name;
@property (nonatomic, assign)BOOL isSelect;
@end
@interface LDuplicatePersonModel : NSObject
@property (nonatomic, assign)NSInteger u_id;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * head_img;
@end
