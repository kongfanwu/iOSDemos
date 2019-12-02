//
//  FWDYeJiCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSelectBaseModel.h"
@interface FWDYeJiCell : UITableViewCell
@property (nonatomic, copy)void (^FWDYeJiCellBlock)(NSInteger index);
@property (nonatomic, copy)void (^FWDYeJiCellDelBlock)(NSMutableArray * arr);
@property (nonatomic, copy)void (^FWDYeJiCellGuiShuBlock)(NSMutableArray * arr);
@property (nonatomic, strong)NSMutableDictionary * selectDic;
@property (nonatomic, copy)NSMutableArray * MrenjisArr;

@end
