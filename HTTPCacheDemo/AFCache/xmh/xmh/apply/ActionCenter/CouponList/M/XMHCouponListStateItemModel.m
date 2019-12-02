//
//  XMHCouponListStateItemModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponListStateItemModel.h"

@implementation XMHCouponListStateItemModel
+ (XMHCouponListStateItemModel *)createTitle:(NSString *)title tag:(NSInteger)tag; {
    XMHCouponListStateItemModel *model = XMHCouponListStateItemModel.new;
    model.title = title;
    model.tag = tag;
    return model;
}
@end
