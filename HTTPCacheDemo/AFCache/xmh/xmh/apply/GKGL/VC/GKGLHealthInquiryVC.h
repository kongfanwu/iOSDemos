//
//  GKGLHealthInquiryVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  身体问诊

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"

NS_ASSUME_NONNULL_BEGIN

@interface GKGLHealthInquiryVC : BaseViewController1
/** 是否来自顾客管理 */
@property (nonatomic, assign) BOOL isFromGKGL;
@property (nonatomic, copy)NSString * userid;
@property (nonatomic, copy)NSString * questionid;
@end

NS_ASSUME_NONNULL_END
