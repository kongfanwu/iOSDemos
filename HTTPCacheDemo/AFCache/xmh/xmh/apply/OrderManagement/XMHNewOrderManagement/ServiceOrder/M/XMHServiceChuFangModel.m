//
//  XMHServiceChuFangModel.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceChuFangModel.h"

@implementation XMHServiceChuFangModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pro_list" : [XMHServiceProjectModel class]};
}

@end
