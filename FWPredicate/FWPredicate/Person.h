//
//  Person.h
//  FWPredicate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
/** hi */
@property (nonatomic) BOOL hidden;
/** <##> */
@property (nonatomic, copy) NSString *name;
/** <##> */
@property (nonatomic) NSInteger age;
@end

NS_ASSUME_NONNULL_END
