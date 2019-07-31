//
//  FWRunLoop.m
//  HashTableDemo
//
//  Created by kfw on 2019/7/29.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "FWRunLoop.h"

@implementation FWRunLoop

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loop {
    self.quit = YES;
    do {
        NSString *str = [self nextMsg];
        NSLog(@"%@", str);
    } while (_quit);
}

static int var = 0;
- (NSString *)nextMsg {
    if (var == 10) {
        self.quit = NO;
        return nil;
    }
    NSString *str = [NSString stringWithFormat:@"%d", var++];
    return str;
}

- (void)setQuit:(BOOL)quit {
    _quit = quit;
}

@end
