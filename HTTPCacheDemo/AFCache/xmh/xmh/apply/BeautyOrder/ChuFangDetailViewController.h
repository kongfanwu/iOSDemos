//
//  ChuFangDetailViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChuFangDetailViewController : UIViewController
@property(nonatomic,copy)NSString *billNum;
@property(nonatomic,copy)NSString *token;

@property(nonatomic,copy)NSString *zhixingbiaoStr;

@property(nonatomic,assign)BOOL isToChuFangZhiXingBiao;

@property(nonatomic,copy)NSString *zt;

@property(nonatomic,assign)NSInteger num1byPass;

@property (nonatomic, copy) void (^ChuFangDetailViewControllerBlock)();

@property (nonatomic, assign) BOOL isComeFromMsg;

@property (nonatomic, copy) NSString * userId;
@end
