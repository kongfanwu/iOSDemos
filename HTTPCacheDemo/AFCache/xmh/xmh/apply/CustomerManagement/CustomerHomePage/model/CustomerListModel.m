//
//  CustomerListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerListModel.h"

@implementation CustomerListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [CustomerModel class]};
}
@end

@implementation CustomerModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return@{
//            @"name" :@"uname",
//            @"level" :@"grade",
//            @"store" :@"mdname",
//            @"waiter" :@"jis",
//            @"to" :@"tdname",
//            @"toType" :@"tdtype",
//            @"iconUrl" :@"headimgurl",
//            @"status" :@"bfb",
//            };
//}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"uid" : @[@"user_id",@"uid"],
             @"uname" : @[@"uname", @"user_name"],
             };
}

/**
 返回 mobile 字段安全手机号。

 @return string
 */
- (NSString *)safeMobile {
    if (_mobile.length == 11) {
        NSString *firstStr = [_mobile substringToIndex:3];
        NSString *lastStr = [_mobile substringFromIndex:7];
        return [NSString stringWithFormat:@"%@****%@", firstStr, lastStr];
    }
    return nil;
}

/**
 判断顾客是否有归属技师

 @return YES 有
 */
- (BOOL)isUserExistJishi {
    return !(IsEmpty(self.jis) || [self.jis isEqualToString:@"0"]);
}

@end
