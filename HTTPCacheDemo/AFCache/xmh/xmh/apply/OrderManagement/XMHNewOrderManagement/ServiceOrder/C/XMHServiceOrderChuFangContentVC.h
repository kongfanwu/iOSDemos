//
//  XMHServiceOrderChuFangContentVC.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 处方内容VC

#import "XMHServiceOrderBaseContentVC.h"
#import "XMHServiceChuFangModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderChuFangContentVC : XMHServiceOrderBaseContentVC

/** <##> */
@property (nonatomic, strong) NSArray <XMHServiceChuFangModel *>*modelArray;
@end

NS_ASSUME_NONNULL_END
