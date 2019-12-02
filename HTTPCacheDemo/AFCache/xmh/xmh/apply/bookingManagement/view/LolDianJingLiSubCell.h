//
//  LolDianJingLiSubCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LolMarkView.h"
@class LolHomeModel;
@interface LolDianJingLiSubCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet LolMarkView *imgV1;
@property (strong,  nonatomic) LolHomeModel * model;
@end
