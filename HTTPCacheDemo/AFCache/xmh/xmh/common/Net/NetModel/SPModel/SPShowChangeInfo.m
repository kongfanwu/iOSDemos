//
//  SPShowChangeInfo.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/8/20.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "SPShowChangeInfo.h"

@implementation SPShowChangeInfo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"approvalPerson" : [SPShowPersonModel class] };
}
@end

@implementation SPShowPersonModel : NSObject


@end
