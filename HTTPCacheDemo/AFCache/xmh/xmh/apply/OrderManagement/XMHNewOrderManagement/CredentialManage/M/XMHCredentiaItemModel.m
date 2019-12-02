//
//  XMHCredentiaItemModel.m
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaItemModel.h"

@implementation XMHCredentiaItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = XMHCredentiaItemModelTypeNormal;
    }
    return self;
}

/**
 销售凭证元数据
 */
+ (NSArray *)salesTongJiArray {
    NSMutableArray *array = NSMutableArray.new;
    [array addObject:@{@"name" : @"销售业绩", @"key" : @"count_a", @"imageName" : @"shouye-huikuandanshu", @"arrow" : @(XMHCredentiaItemModelTypeArrow)}];
    [array addObject:@{@"name" : @"销售单数", @"key" : @"count_d", @"imageName" : @"shouye-xiaoshoudanshu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"销售项目数", @"key" : @"count_pro", @"imageName" : @"shouye-xiaoshouxiangmushu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"销售人数", @"key" : @"count_r", @"imageName" : @"shouye-xiaoshourenshu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"回款单数", @"key" : @"count_h", @"imageName" : @"shouye-huikuandanshu", @"arrow" : @(XMHCredentiaItemModelTypeArrow)}];
    [array addObject:@{@"name" : @"未还清金额", @"key" : @"count_w", @"imageName" : @"shouye-weihuanqingjinge", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"退款金额", @"key" : @"count_t", @"imageName" : @"shouye-tuikuanjine", @"arrow" : @(XMHCredentiaItemModelTypeArrow)}];
    [array addObject:@{@"name" : @"配合消费", @"key" : @"count_ph", @"imageName" : @"shouye-peihexiaofei", @"arrow" : @(XMHCredentiaItemModelTypeArrow)}];
    return array;
}

/**
 服务凭证元数据
 */
+ (NSArray *)serviceTongJiArray {
    NSMutableArray *array = NSMutableArray.new;
    [array addObject:@{@"name" : @"服务业绩", @"key" : @"fuwuyeji", @"imageName" : @"shouye-fuwuyeji", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"服务单数", @"key" : @"fuwudanshu", @"imageName" : @"shouye-fuwudanshu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"服务项目数", @"key" : @"fuwuxiangmushu", @"imageName" : @"shouye-fuwuxiangmushu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"服务人数", @"key" : @"fuwurenshu", @"imageName" : @"shouye-fuwurenshu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"销售服务单数", @"key" : @"xiaoshoudanshu", @"imageName" : @"shouye-xiaoshoufuwudanshu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"销售服务金额", @"key" : @"xiaoshoujine", @"imageName" : @"shoye-xioashoufuwujine", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"服务项目次数", @"key" : @"fuwuxiangmucishu", @"imageName" : @"shouye-fuwuxiangmucishu", @"arrow" : @(XMHCredentiaItemModelTypeNormal)}];
    [array addObject:@{@"name" : @"配合耗卡", @"key" : @"peihe", @"imageName" : @"shouye-peihehaoka", @"arrow" : @(XMHCredentiaItemModelTypeArrow)}];
    return array;
}

@end
