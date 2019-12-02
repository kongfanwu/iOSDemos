

//
//  FTTBeautifultMakeModel.m
//  xmh
//
//  Created by KFW on 2019/8/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "FTTBeautifultMakeModel.h"

@implementation FTTBeautifultMakeModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//
//    return @{@"FTTBeautifulMakeConstantModel":@"info"};
//}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。 Model 包含其他 Model
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"info" : [FTTBeautifulMakeConstantModel class]}; // value 有三种写法;

}
@end
