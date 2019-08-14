//
//  XMHUserTagVC.h
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 顾客标签
/*
 XMHUserTagVC *userTagVC = XMHUserTagVC.new;
 userTagVC.type = XMHUserTagVCTypeEdit;
 self.window.rootViewController = userTagVC;
 */
#import "BaseCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHUserTagVCType) {
    XMHUserTagVCTypeLook, // 查看
    XMHUserTagVCTypeEdit, // 编辑
};

@interface XMHUserTagVC : BaseCommonViewController

/** 类型 默认 XMHUserTagVCTypeLook */
@property (nonatomic) XMHUserTagVCType type;

@end

NS_ASSUME_NONNULL_END
