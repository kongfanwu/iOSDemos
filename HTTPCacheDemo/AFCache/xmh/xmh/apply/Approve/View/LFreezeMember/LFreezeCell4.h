//
//  LFreezeCell4.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 125

#import <UIKit/UIKit.h>
#import "LSponsorApproceModel.h"
@interface LFreezeCell4 : UITableViewCell
@property (nonatomic, strong)UILabel * lb1;
@property (nonatomic, strong)UILabel * lb2;
@property (nonatomic, strong)UIImageView * imgV;
@property (strong, nonatomic)NSArray<LApprocePersonModel *> *approcePersonList;
@property (copy, nonatomic)void (^LFreezeCell4Block)();
@property (strong, nonatomic)LApprocePersonModel * model;
@end
