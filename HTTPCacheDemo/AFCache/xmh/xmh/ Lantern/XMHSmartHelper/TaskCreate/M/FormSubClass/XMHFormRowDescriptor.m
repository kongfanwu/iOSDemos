//
//  XMHFormRowDescriptor.m
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormRowDescriptor.h"

@implementation XMHFormRowDescriptor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskType = XMHFormTaskCreateVCTypeCreate;
    }
    return self;
}

+(instancetype)formRowDescriptorWithTag:(NSString *)tag rowType:(NSString *)rowType
{
    return [[self class] formRowDescriptorWithTag:tag rowType:rowType title:nil];
}

+(instancetype)formRowDescriptorWithTag:(NSString *)tag rowType:(NSString *)rowType title:(NSString *)title
{
    return [[[self class] alloc] initWithTag:tag rowType:rowType title:title];
}

@end
