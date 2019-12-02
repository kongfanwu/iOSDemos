//
//  LApproveCommonModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LApproveUserModel,LApproveDetailModel;
@interface LApproveCommonModel : NSObject
@property (nonatomic, strong)NSArray <LApproveDetailModel *>* list;
@property (nonatomic, assign)NSInteger noReadNum;
@property (nonatomic, assign)NSInteger total;
@end
@interface LApproveDetailModel : NSObject
@property (nonatomic, assign)NSInteger u_id;
@property (nonatomic, strong)NSString * head_img;
@property (nonatomic, strong)NSString * code;
@property (nonatomic, assign)NSInteger ptype;
@property (nonatomic, strong)NSString * create_time;
@property (nonatomic, strong)NSString * state;
@property (nonatomic, strong)LApproveUserModel * data;
@property (nonatomic, assign)NSInteger isRead;
@property (nonatomic, strong)NSString * ordernum;
@end
@interface LApproveUserModel : NSObject
@property (nonatomic, strong)NSString * initiator;
@property (nonatomic, strong)NSString * uname;
@property (nonatomic, strong)NSString * mdname;
@property (nonatomic, assign)NSInteger actual;
@property (nonatomic, strong)NSString * cause;
@property (nonatomic, strong)NSString * outStore;
@property (nonatomic, strong)NSString * inStore;
@property (nonatomic, strong)NSString * chmdtype;
@property (nonatomic, strong)NSString * utel;
@property (nonatomic, strong)NSString * type;
@property (nonatomic, strong)NSString * difference;
@property (nonatomic, assign)NSInteger price_s;
@property (nonatomic, assign)NSInteger price;
@end
