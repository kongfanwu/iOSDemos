//
//  SLServAppoModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLAppo_Pres,SLPro,SLAppo_Pro;

@interface SLServAppoModel : NSObject

@property (nonatomic, strong) NSArray<SLAppo_Pres *> *appo_pres;

@property (nonatomic, strong) NSArray<SLAppo_Pro *> *appo_pro;

@end

@interface SLAppo_Pres : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) NSArray<SLPro *> *pro_list;

@end

@interface SLPro : NSObject

@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *appo_time;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, assign) NSInteger numDisplay;

@end

@interface SLAppo_Pro : NSObject

@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *appo_time;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, assign) NSInteger numDisplay;

@end


