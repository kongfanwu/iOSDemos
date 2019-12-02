//
//  LolSingleGuKeCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolGuKeStateModelList,LolGuKeStateModel;
@interface LolSingleGuKeCell : UITableViewCell
@property (nonatomic, strong)LolGuKeStateModelList * model;
@property (copy, nonatomic)void (^LolSingleGuKeCellBlock)(LolGuKeStateModel *model, NSInteger index);
@end
