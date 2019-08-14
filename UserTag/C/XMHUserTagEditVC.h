//
//  XMHUserTagEditVC.h
//  xmh
//
//  Created by kfw on 2019/8/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@class XMHUserTagSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHUserTagEditVC : BaseCommonViewController

@property (nonatomic, strong) NSMutableArray <XMHUserTagSectionModel *> *selectDataArray;
/** su */
@property (nonatomic, copy) void (^sureBlock)(NSMutableArray <XMHUserTagSectionModel *> *selectDataArray);

@end

NS_ASSUME_NONNULL_END
