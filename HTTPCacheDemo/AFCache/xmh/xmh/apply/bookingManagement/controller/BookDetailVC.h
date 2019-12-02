//
//  BookDetailVC.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//  除待预约一键预约外使用

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
@class BookParamModel;
@interface BookDetailVC : BaseCommonViewController
/** 跳转模型 */
@property (nonatomic, strong)BookParamModel * paramModel;
@end
