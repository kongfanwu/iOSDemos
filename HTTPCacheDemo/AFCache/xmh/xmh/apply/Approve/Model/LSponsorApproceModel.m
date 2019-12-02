//
//  LSponsorApproceModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSponsorApproceModel.h"
@implementation LSponsorApproceModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"approvalPerson" : [LApprocePersonModel class],@"duplicatePerson":[LDuplicatePersonModel class]};
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
@implementation LApprocePersonModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"u_id":@"id"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
@implementation LDuplicatePersonModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"u_id":@"id"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
