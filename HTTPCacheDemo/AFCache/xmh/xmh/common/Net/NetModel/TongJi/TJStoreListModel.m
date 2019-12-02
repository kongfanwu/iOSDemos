//
//  TJStoreListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJStoreListModel.h"

@implementation TJStoreListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJStoreModel class]};
}
@end

@implementation TJStoreModel

@end
