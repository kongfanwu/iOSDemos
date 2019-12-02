//
//  LYuanGongBigCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeModel,LGuKeDetail;
@interface LYuanGongBigCell : UITableViewCell
@property (nonatomic, copy)void (^LYuanGongBigCellBlock)(LolHomeModel* homeModel,LGuKeDetail * obj);
@property (nonatomic, strong)NSMutableArray<LolHomeModel *> * modelArr;
@end
