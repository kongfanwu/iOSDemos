//
//  MzzDaiYuYueModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzDaiYuYue;
@interface MzzDaiYuYueModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<MzzDaiYuYue *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MzzDaiYuYue : NSObject

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *jis_name;

@end


