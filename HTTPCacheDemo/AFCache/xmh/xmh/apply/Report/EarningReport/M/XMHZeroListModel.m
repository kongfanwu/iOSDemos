//
//  XMHZeroModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHZeroListModel.h"

@implementation XMHZeroListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [XMHZeroModel class] };
}
@end

@implementation XMHZeroModel

@end
