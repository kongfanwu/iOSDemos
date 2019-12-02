//
//  LolMenDianCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/21.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolHomeModel;
@interface LolMenDianCell : UITableViewCell
@property (nonatomic, copy)void (^LolMenDianCellBlock)(LolHomeModel * obj);
@property (nonatomic, strong)NSMutableArray<LolHomeModel *> * modelArr;
@end
