//
//  SPShowChangeInfo.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/8/20.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPShowPersonModel;
@interface SPShowChangeInfo : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *chinfo_type;
@property (nonatomic, copy) NSString *join_name;
@property (nonatomic, copy) NSString *initiator;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, copy) NSString *account_id;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_mobile;
@property (nonatomic, copy) NSString *user_mdname;
@property (nonatomic, copy) NSString *user_jis_name;
@property (nonatomic, strong)NSMutableArray <SPShowPersonModel *>* approvalPerson;
@end


@interface SPShowPersonModel : NSObject

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *frame_name;

@property (nonatomic, assign)NSInteger type;

@end
