//
//  LolDianJingLiCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeModel;
@interface LolDianJingLiCell : UITableViewCell
@property (nonatomic, copy)void (^LolDianJingLiCellBlock)(LolHomeModel * obj);
@property (nonatomic, strong)NSMutableArray<LolHomeModel *> * modelArr;
@end
