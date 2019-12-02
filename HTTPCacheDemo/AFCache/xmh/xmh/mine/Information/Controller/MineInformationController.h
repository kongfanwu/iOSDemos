//
//  MineInformationController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/14.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
@interface MineInformationController : BaseCommonViewController
@property (nonatomic,strong) NSArray *selections; //!< 选择的三个下标
@property (nonatomic,copy) NSString *pushAddress; //!< 展示的地址
@end
