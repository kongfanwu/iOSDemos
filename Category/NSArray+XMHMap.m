//
//  NSObject+XMHMap.m
//  tableViewSepDemo
//
//  Created by kfw on 2019/12/2.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "NSArray+XMHMap.h"

@implementation NSArray (XMHMap)

- (void(^)(void(^block)(id)))xmh_map {
    return ^(void(^block)(id)){
        if ([self isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)self;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                block(obj);
            }];
        }
    };
}

@end
