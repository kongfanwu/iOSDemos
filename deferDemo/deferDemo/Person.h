//
//  Person.h
//  deferDemo
//
//  Created by kfw on 2020/9/22.
//  Copyright © 2020 kfw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
- (Person *(^)(NSString *, ...))xmhText;
@end

NS_ASSUME_NONNULL_END
