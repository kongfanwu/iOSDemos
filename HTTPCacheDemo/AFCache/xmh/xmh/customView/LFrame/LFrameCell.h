//
//  LFrameCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhuzhiModel.h"
@interface LFrameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (nonatomic, strong)List * model;
@end
