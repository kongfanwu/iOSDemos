//
//  YJProvince.h
//  0312省市联动
//
//  Created by 张英杰 on 15/3/12.
//  Copyright (c) 2015年 张英杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJProvince : NSObject

@property (nonatomic,strong)NSArray *cities;

@property (nonatomic,copy)NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)provinceWithDict:(NSDictionary *)dict;

@end
