//
//  FWRunLoop.h
//  HashTableDemo
//
//  Created by kfw on 2019/7/29.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWRunLoop : NSObject

/** qui */
@property (nonatomic) BOOL quit;
- (void)loop;
@end

NS_ASSUME_NONNULL_END
