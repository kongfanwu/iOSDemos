//
//  MzzFilterDatePickerCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzFilterDatePickerCell : UITableViewCell
@property (nonatomic, copy)void (^MzzFilterDatePickerCellBlock)(NSString * startStr, NSString * endStr);
@property (nonatomic, copy)NSString * startStr;
@property (nonatomic, copy)NSString * endStr;
@end
