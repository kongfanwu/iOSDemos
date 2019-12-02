//
//  ChuFangReporterViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerMessageModel.h"
#import "GuKeChuFang.h"
@interface ChuFangReporterViewController : UIViewController
@property(nonatomic,strong)CustomerMessageModel *info;
@property(nonatomic,strong)GuKeChuFang *subinfo;

@property(nonatomic,copy)NSString *billNum;
@property(nonatomic,copy)NSString *token;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *num1;
@property(nonatomic,copy)NSString *num;

@end
