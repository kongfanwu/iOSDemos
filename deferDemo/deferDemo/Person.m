//
//  Person.m
//  deferDemo
//
//  Created by kfw on 2020/9/22.
//  Copyright © 2020 kfw. All rights reserved.
//

#import "Person.h"

@implementation Person
//- (UILabel *(^)(NSString *))xmhText {
//    return ^UILabel *(NSString *text){
//
//        return self;
//    };
//}

- (Person *(^)(NSString *, ...))xmhText {
    return ^Person *(NSString *text, ...){
        va_list args;
        va_start(args, text); // scan for arguments after firstObject.
        // get rest of the objects until nil is found
        for (NSString *str = text; str != nil; str = va_arg(args,NSString*)) {
            NSLog(@"------:%@", str);
        }
        
        va_end(args);
        return self;
    };
}
@end
