//
//  TJParamModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJParamModel : NSObject

@property (nonatomic ,strong)NSString * startTime;
@property (nonatomic ,strong)NSString * endTime;
@property (nonatomic ,strong)NSString * type;
@property (nonatomic ,strong)NSString * name;
@property (nonatomic ,strong)NSString * level;
@property (nonatomic ,strong)NSString * storeCode;
@property (nonatomic, assign)BOOL selected;
+ (instancetype)createParamModelName:(NSString *)name type:(NSString *)type;
+ (instancetype)createParamModelName:(NSString *)name;
+ (instancetype)createParamModelName:(NSString *)name storeCode:(NSString *)storeCode;
@end
