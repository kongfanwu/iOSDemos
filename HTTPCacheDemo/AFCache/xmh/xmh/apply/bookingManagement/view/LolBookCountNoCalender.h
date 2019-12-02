//
//  LolBookCountNoCalender.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LolGuKeListModel;
@interface LolBookCountNoCalender : UITableViewCell
@property (nonatomic, strong)LolGuKeListModel *guKeListModel;
- (void)updateLolBookCountNoCalender;
@end
