//
//  TJParamModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/4.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJParamModel.h"

@implementation TJParamModel
+ (instancetype)createParamModelName:(NSString *)name type:(NSString *)type
{
    TJParamModel * model = [[TJParamModel alloc] initWithName:name type:type storeCode:nil];
    return model;
}
+ (instancetype)createParamModelName:(NSString *)name storeCode:(NSString *)storeCode
{
    TJParamModel * model = [[TJParamModel alloc] initWithName:name type:nil storeCode:storeCode];
    return model;
}

+ (instancetype)createParamModelName:(NSString *)name
{
    TJParamModel * model = [[TJParamModel alloc] initWithName:name type:nil storeCode:nil];
    return model;
}
- (instancetype)initWithName:(NSString *)name type:(NSString *)type storeCode:(NSString *)storeCode
{
    if (self = [super init]) {
        _name = name;
        _type = type;
        _storeCode = storeCode;
    }
    return self;
}
@end
