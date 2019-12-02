//
//  LolJiShiTimeView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  技师时间的View

#import <Foundation/Foundation.h>
#import "LolJiShiTimeModel.h"
#import "DaiYuYueModel.h"
@interface LolJiShiTimeView : UIView
@property (weak,   nonatomic) IBOutlet UILabel *lb1;
@property (weak,   nonatomic) IBOutlet UILabel *lb2;
@property (strong, nonatomic) LolJiShiTimeModel *model;
@property (strong, nonatomic) NSMutableArray<DaiYuYueModel *> * modelArr;
@end
