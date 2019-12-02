//
//  LolGukeXiangMuCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 65

#import <UIKit/UIKit.h>
#import "LolGuKeStateModelList.h"
#import "LolMarkView.h"
@interface LolSingleGuKeSubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet LolMarkView *imgV;
@property (nonatomic, strong)LolGuKeStateModel * model;
@end
