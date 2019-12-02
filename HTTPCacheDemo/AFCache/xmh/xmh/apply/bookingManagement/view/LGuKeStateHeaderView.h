//
//  LGuKeStateHeaderView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/18.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LolGuKeStateModelList.h"
@interface LGuKeStateHeaderView : UIView
@property (nonatomic, strong)LolGuKeStateModelList * model;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbState;
@end
