//
//  NSDictionary+Safe.h
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (id)safeObjectForKey:(id)aKey;

@end
