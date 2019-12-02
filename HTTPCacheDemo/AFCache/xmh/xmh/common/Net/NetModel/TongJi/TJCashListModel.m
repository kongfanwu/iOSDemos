//
//  TJCashListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJCashListModel.h"

@implementation TJCashListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"next" : [TJCashModel class]};
}
@end

@implementation TJCashModel

@end
