//
//  ReportBJController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportBJController : UIViewController

@property(nonatomic,strong)NSString *ordernum;
@property(nonatomic,strong)NSString *token;

@property (nonatomic, copy) void (^ReportBJControllerPopBlock)();
@end
