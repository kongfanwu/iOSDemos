//
//  MzzWorkListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzWork;
@interface MzzWorkListModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSMutableArray<MzzWork *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MzzWork : NSObject

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *fq_img;

@property (nonatomic, copy) NSString *fq_name;

@property (nonatomic, copy) NSString *store;

@property (nonatomic, copy) NSString *state;


@property (nonatomic, copy) NSString *appo_time;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy) NSString *cue;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger money;

@property (nonatomic, copy) NSString *denomination;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *grade;
@end


