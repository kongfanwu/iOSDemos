//
//  MzzTags.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTags.h"



@implementation MzzTagDatas

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [MzzSectionTags class]};
}


@end


@implementation MzzSectionTags

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"content_list" : [MzzTag class],@"pro":[MzzTag class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end


@implementation MzzTag
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end



