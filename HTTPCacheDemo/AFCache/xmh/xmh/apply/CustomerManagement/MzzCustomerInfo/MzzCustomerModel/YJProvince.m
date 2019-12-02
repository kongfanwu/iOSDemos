//
//  YJProvince.m
//  0312省市联动
//
//  Created by 张英杰 on 15/3/12.
//  Copyright (c) 2015年 张英杰. All rights reserved.
//

#import "YJProvince.h"

@implementation YJProvince

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)provinceWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
