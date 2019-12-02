//
//  GKGLCardDetailVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  卡项详情

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKGLCardDetailVC : BaseViewController1
@property (nonatomic, copy)NSDictionary * param;
@property (nonatomic, copy)NSString * cardType;
@property (nonatomic, copy)NSString * userid;
@end

NS_ASSUME_NONNULL_END
