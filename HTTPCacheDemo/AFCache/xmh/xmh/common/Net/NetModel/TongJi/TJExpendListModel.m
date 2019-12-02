//
//  TJExpendListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJExpendListModel.h"

@implementation TJExpendListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"next" : [TJExpendModel class]};
}
@end

@implementation TJExpendModel

@end
