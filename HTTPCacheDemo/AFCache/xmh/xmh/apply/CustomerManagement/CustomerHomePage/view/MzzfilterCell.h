//
//  MzzfilterCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzfilterCell : UITableViewCell
@property (nonatomic, strong)NSArray * contentArr;
@property (nonatomic, copy)void (^MzzfilterCellBlock)(NSInteger index);
@end
