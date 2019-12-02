//
//  CustomerTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTableViewModel.h"
@interface CustomerTableViewCell : UITableViewCell
@property (strong,nonatomic)CustomerTableViewModel *model;
@end
