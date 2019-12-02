//
//  XMHSegmentVCManager.h
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 左侧双层列表，右侧内容控制器管理者

#import <UIKit/UIKit.h>
@class XMHSegmentVCModel;

NS_ASSUME_NONNULL_BEGIN

/* 显示暂无数据vc
   如果 XMHSegmentVCManager dataArray 数据源有二级视图。一级设置此VC.用于处理二级无数据情况(二级无数据，就显示一级的VC)显示此VC
 */
@interface XMHSegmentVCManagerEmptyDataVC : UIViewController
@property (nonatomic, strong) UIImageView *defaultImageView;
@end

@interface XMHSegmentVCManager : UIViewController

/** <##> */
@property (nonatomic, strong) NSMutableArray <XMHSegmentVCModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
