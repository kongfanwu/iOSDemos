//
//  StateNumView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateNumView : UIView
/*
 状态(1)
 人数(2)
 */
@property (strong, nonatomic)UILabel *lb1;
@property (strong, nonatomic)UILabel *lb2;
@property (strong, nonatomic)UILabel *line;
@property (strong, nonatomic)UILabel *line1;
@property (strong, nonatomic)UIButton *btnMore;
- (void)updateStateNumView;
@end
