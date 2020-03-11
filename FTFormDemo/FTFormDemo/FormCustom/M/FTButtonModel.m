//
//  FTButtonModel.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/17.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTButtonModel.h"

@implementation FTButtonModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = FTButtonModelTypeNormal;
    }
    return self;
}

@end
