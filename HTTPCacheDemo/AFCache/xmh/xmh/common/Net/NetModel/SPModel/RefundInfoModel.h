//
//  RefundInfoModel.h
//  xmh
//
//  Created by ald_ios on 2018/11/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApprovalInfo;
@interface RefundInfoModel : NSObject
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * store_code;
@property (nonatomic, copy) NSString * store_name;
@property (nonatomic, copy) NSString * orderNum;
@property (nonatomic, copy) NSString * user_store_id;
@property (nonatomic, copy) NSArray <ApprovalInfo *>* approvalPerson;
@property (nonatomic, copy) NSArray <ApprovalInfo *>* duplicatePerson;
@end

@interface ApprovalInfo : NSObject
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * head_img;
@property (nonatomic, copy) NSString * frame_name;

@end
