//
//  BookDetailsViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约详情界面

#import <UIKit/UIKit.h>
@class DaiYuYueModel,LolSkipToDetailMode;
@interface BookDetailsViewController : UIViewController
//待预约界面跳转到此页 需要的数据model
@property (nonatomic, strong)DaiYuYueModel * dModel;
//除待预约以外的界面跳转到此页 需要的数据模型
@property (nonatomic, strong)LolSkipToDetailMode * skipModel;
@end
