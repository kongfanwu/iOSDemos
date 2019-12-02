//
//  GKGLHomeCustomerListModel.h
//  xmh
//
//  Created by ald_ios on 2019/1/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GKGLHomeCustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface GKGLHomeCustomerListModel : NSObject
@property (nonatomic, strong)NSArray <GKGLHomeCustomerModel *>*list;
@end


@interface GKGLHomeCustomerModel : NSObject
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *headimgurl;
@property (nonatomic, copy)NSString *grade;
@property (nonatomic, copy)NSString *last_fw_time;
@property (nonatomic, copy)NSString *insert_time;
@property (nonatomic, copy)NSString *xiaofei;
@property (nonatomic, copy)NSString *xiaohao;
@property (nonatomic, copy)NSString *daodian;
@property (nonatomic, copy)NSString *last_xiaofei_time;
@property (nonatomic, copy)NSString *grade_name;
@property (nonatomic, copy)NSString *show;
@property (nonatomic, copy)NSString *zt;
@property (nonatomic, copy) NSString *store_code;
@property (nonatomic, assign)BOOL selected;
/** 是否预约，0否，1是 */
@property (nonatomic, copy)NSString *is_appo;
@end

NS_ASSUME_NONNULL_END
