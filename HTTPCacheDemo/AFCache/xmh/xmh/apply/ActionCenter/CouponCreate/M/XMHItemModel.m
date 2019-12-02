//
//  XMHItemModel.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHItemModel.h"

@implementation XMHItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"title": @[@"title", @"name"],
             @"idStr": @[@"idStr", @"id"],
             @"ID": @[@"ID", @"id"],
             };
}

+ (XMHItemModel *)createTitle:(NSString *)title type:(XMHActionCouponType)type select:(BOOL)isSelect {
    XMHItemModel *model = XMHItemModel.new;
    model.title = title;
    model.type = type;
    model.isSelect = isSelect;
    return model;
}

+ (XMHItemModel *)createTitle:(NSString *)title idStr:(NSString *)idstr {
    XMHItemModel *model = XMHItemModel.new;
    model.title = title;
    model.idStr = idstr;
    return model;
}

@end
