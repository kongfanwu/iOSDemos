//
//  MzzDaiGenJinModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzDaiGenJin,MzzKqwh,MzzSqgk,MzzKfgk;
@interface MzzDaiGenJinModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) MzzDaiGenJin *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MzzDaiGenJin : NSObject

@property (nonatomic, strong) NSArray<MzzKqwh *> *kqwh;

@property (nonatomic, strong) NSArray<MzzSqgk *> *sqgk;

@property (nonatomic, strong) NSArray<MzzKfgk *> *kfgk;

@end

@interface MzzKqwh : NSObject

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *type;

@end

@interface MzzSqgk : NSObject

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_name;

@end

@interface MzzKfgk : NSObject

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *type;

@end


