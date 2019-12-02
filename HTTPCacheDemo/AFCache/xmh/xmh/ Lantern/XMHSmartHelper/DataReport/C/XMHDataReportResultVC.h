//
//  XMHDataReportResultVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@class XMHDataReportModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHDataReportResultVC : BaseCommonViewController
/** 任务id */
@property(nonatomic, copy) NSString *cute_hand_rec_id;
@property(nonatomic, copy) XMHDataReportModel *model;
@end

NS_ASSUME_NONNULL_END
