//
//  NSDictionary+XMHMap.m
//  tableViewSepDemo
//
//  Created by kfw on 2019/12/2.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "NSDictionary+XMHMap.h"

@implementation NSDictionary (XMHMap)
- (void(^)(void(^block)(id key, id obj)))xmh_map {
    return ^(void(^block)(id key, id obj)){
        if ([self isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)self;
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                block(key, obj);
            }];
        }
    };
}


@end
