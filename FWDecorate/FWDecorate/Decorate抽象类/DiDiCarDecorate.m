//
//  DiDiCarDecorate.m
//  FWDecorate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "DiDiCarDecorate.h"

@interface DiDiCarDecorate()
/** <##> */

@end

@implementation DiDiCarDecorate

- (id)initWithCarComponent:(id <DiDiCarComponent>) component {
    if (self = [super init]) {
        self.component = component;
    }
    return self;
}


- (void)run {
    [self.component run];
    NSLog(@"DiDiCarDecorate run 子类重载");
}

@end
