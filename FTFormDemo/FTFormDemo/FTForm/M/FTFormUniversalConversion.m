//
//  FTFormUniversalConversion.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/13.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormUniversalConversion.h"

@implementation FTFormUniversalConversion

/**
 转换Value
 */
- (NSString *)conversionValue {
    if (self.conversionValueBlock) {
        //如果实现这个block的话  走的就是就是自定义的Value值
        return self.conversionValueBlock(self.row);
    }
    //默认显示的Value
    if ([self.row.value isKindOfClass:[NSString class]]) {
        return self.row.value;
    }
    return @"";
}

/**
 获取表单转换
 */
- (NSDictionary *)conversionParam {
    // 走自定义转换器
    if (self.conversionParamBlock) {
        return self.conversionParamBlock(self.row);
    }
    // 默认值
    if (self.row.tag && self.row.value) {
        return @{self.row.tag : self.row.value};
    }
    return nil;
}



@end
