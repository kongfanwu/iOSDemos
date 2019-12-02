//
//  LWaitCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWaitCell : UITableViewCell
@property (strong, nonatomic)NSArray * titleArr;
@property (copy, nonatomic)void (^LWaitCellBlock)(NSInteger ptype,NSString *title);
@end
