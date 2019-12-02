//
//  LDealCountView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/8/23.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTopModel.h"
@interface LDealCountView : UIView
@property (nonatomic, strong)OTopModel * topModel;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@end
