//
//  LYuanGongTbHeader.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LolMarkView.h"
#import "LolHomeModel.h"
@interface LYuanGongTbHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet LolMarkView *imgV;
@property (strong, nonatomic)LolHomeModel * model;
@end
