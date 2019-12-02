//
//  XMHCredentiaOrderStateItemModel.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaOrderStateItemModel.h"

@implementation XMHCredentiaOrderStateItemModel

+ (XMHCredentiaOrderStateItemModel *)createTitle:(NSString *)title tag:(NSInteger)tag {
    XMHCredentiaOrderStateItemModel *model = XMHCredentiaOrderStateItemModel.new;
    model.title = title;
    model.tag = tag;
    return model;
}

@end
