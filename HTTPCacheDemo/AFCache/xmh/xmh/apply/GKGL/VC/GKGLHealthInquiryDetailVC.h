//
//  GKGLHealthInquiryDetailVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  问诊详情界面

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKGLHealthInquiryDetailVC : BaseCommonViewController
@property (nonatomic, copy)NSString * userid;
@property (nonatomic, strong)NSDictionary * param;
@end

NS_ASSUME_NONNULL_END
