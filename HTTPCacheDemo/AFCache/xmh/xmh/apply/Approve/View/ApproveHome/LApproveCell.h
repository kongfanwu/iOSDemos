//
//  LApproveCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LApproveCell : UITableViewCell
@property (strong, nonatomic)NSMutableArray * arrs;
@property (copy, nonatomic)void (^LApproveCellBlock)(NSInteger tag);
@end
