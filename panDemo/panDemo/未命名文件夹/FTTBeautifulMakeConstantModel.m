
//
//  FTTBeautifulMakeConstantModel.m
//  xmh
//
//  Created by KFW on 2019/8/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "FTTBeautifulMakeConstantModel.h"
#import "YYModel/YYModel.h"

@implementation FTTBeautifulMakeConstantModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}
@end
