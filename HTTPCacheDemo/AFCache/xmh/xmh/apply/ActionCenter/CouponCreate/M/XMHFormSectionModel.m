//
//  XMHFormSectionModel.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormSectionModel.h"

@implementation XMHFormSectionModel

- (XMHFormSectionModel *)createTitle:(NSString *)title {
    XMHFormSectionModel *model = XMHFormSectionModel.new;
    model.title = title;
    return model;
}

- (NSMutableArray *)sectionArray {
    if (_sectionArray) return _sectionArray;
    _sectionArray = NSMutableArray.new;
    return _sectionArray;
}

@end
