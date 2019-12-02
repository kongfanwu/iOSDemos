//
//  MzzDaiShenPiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>



@class MzzDaiShenPi;
@interface MzzDaiShenPiModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<MzzDaiShenPi *> *data;

@property (nonatomic, assign) NSInteger code;

@end

@interface MzzDaiShenPi : NSObject

@property (nonatomic, copy) NSString *tab;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString *fq_name;

@property (nonatomic, copy) NSString *fq_img;

@property (nonatomic, assign) NSInteger fq_id;

@property (nonatomic, assign) NSInteger next_person;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *store;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *cue;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, assign) NSInteger ptype;


@end
