//
//  BookJisTimeList.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookJisTimeList.h"

@implementation BookJisTimeList
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"calendar" : [BookJisTime class] };
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end


@implementation BookJisTime

@end
