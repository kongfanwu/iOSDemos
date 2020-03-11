//
//  FTFormParamVerify.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/15.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormParamVerify.h"

@implementation FTFormParamVerifyResult

+ (instancetype)createSuccess:(BOOL)success msg:(NSString *)msg {
    FTFormParamVerifyResult *obj = FTFormParamVerifyResult.new;
    obj.success = success;
    obj.msg = msg;
    return obj;
}

@end

@implementation FTFormParamVerify

/**
 校验必填
 
 @return 校验结果
 */
- (FTFormParamVerifyResult *)verify {
    if (self.verifyBlock) {
        return self.verifyBlock(self.row);
    }
    NSString *msg = [NSString stringWithFormat:@"FTFormRow:Tag = %@ requeit 属性为 YES.必须实现 verify 属性 verifyBlock", self.row.tag];
    NSAssert(self.verifyBlock != nil, msg);
    return nil;
}

@end
