//
//  MzzDaiFuWuModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzDaiFuWu,MzzXsnr,MzzFwnr;
@interface MzzDaiFuWuModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) MzzDaiFuWu *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MzzDaiFuWu : NSObject

@property (nonatomic, strong) NSArray<MzzFwnr *> *fwnr;

@property (nonatomic, strong) NSArray<MzzXsnr *> *xsnr;

@end

@interface MzzXsnr : NSObject

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, copy) NSString *denomination;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, copy) NSString *user_mobile;

@property (nonatomic, copy) NSString *cue;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, copy) NSString *name;

@end

@interface MzzFwnr : NSObject

@property (nonatomic, assign) NSInteger appo_pro_id;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, copy) NSString *appo_time;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, copy) NSString * cue;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *user_mobile;

@property (nonatomic, copy) NSString *store_code;
@end

