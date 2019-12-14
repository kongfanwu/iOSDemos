//
//  NSDictionary+XMHMap.h
//  tableViewSepDemo
//
//  Created by kfw on 2019/12/2.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (XMHMap)
- (void(^)(void(^block)(id key, id obj)))xmh_map;
@end

NS_ASSUME_NONNULL_END
