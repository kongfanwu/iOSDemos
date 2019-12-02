//
//  SPCongealModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPCongealPersonModel;

@interface SPCongealModel : NSObject

@property (nonatomic, copy) NSString *join_name;

@property (nonatomic, assign) NSInteger user_serNum;

@property (nonatomic, copy) NSString *user_mobile;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_mdname;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, assign) NSInteger user_surplus;

@property (nonatomic, assign) NSInteger user_awardNum;

@property (nonatomic, strong) NSArray<SPCongealPersonModel *> *duplicatePerson;

@property (nonatomic, strong) NSArray<SPCongealPersonModel *> *approvalPerson;

@property (nonatomic, copy) NSString *initiator;

@property (nonatomic, copy) NSString *user_jis_name;

@end



@interface SPCongealPersonModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *head_img;

@end


