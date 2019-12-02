//
//  ShareWorkInstance.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ShareWorkInstance.h"

@implementation ShareWorkInstance
 static ShareWorkInstance * shareInstance;
+ (ShareWorkInstance *)shareInstance{
    if (shareInstance == nil) {
         shareInstance=[[ShareWorkInstance alloc] init];
    }
    return shareInstance;
}

+(void)releaseInstance{
    if (shareInstance) {
        shareInstance = nil;
    }
}
@end
