//
//  XMHUserTagSectionModel.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagSectionModel.h"
#import "XMHUserTagModel.h"

@implementation XMHUserTagSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = XMHUserTagSectionModelTypeNormal;
    }
    return self;
}

- (NSMutableArray <XMHUserTagModel *> *)childs {
    if (_childs) return _childs;
    _childs = NSMutableArray.new;
    return _childs;
}


@end
