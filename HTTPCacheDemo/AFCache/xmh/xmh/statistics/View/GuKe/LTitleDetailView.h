//
//  LTitleDetailView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJGuKeTopModel.h"
#import "TJCardTopModel.h"
@interface LTitleDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (strong , nonatomic)TJGuKeTopSubModel * model;
@property (strong , nonatomic)TJCardTopSubModel * subCardmodel;
@end
