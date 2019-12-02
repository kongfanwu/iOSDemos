//
//  TJAlertView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJAlertView : UIView
@property (nonatomic, strong)NSArray * data;
//@property (nonatomic, copy)void (^TJAlertView)(NSObject *)
+ (void)show;
@end
