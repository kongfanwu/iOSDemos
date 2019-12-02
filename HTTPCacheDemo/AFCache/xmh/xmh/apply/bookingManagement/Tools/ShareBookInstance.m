//
//  ShareBookInstance.m
//  xmh
//
//  Created by 李晓明 on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ShareBookInstance.h"

@implementation ShareBookInstance
+ (ShareBookInstance *)shareInstance{
    static dispatch_once_t onceToken;
    static ShareBookInstance * shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance=[[ShareBookInstance alloc] init];
    });
    return shareInstance;
}
@end
