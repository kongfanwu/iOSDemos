//
//  LolYuanGongCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeModel;
@interface LolDianZhangCell : UITableViewCell
@property (nonatomic, copy)void (^LolDianZhangCellBlock)(LolHomeModel * obj);
@property (nonatomic, strong)NSMutableArray<LolHomeModel *> * modelArr;
- (void)updateLolYuanGongCell;
@end
