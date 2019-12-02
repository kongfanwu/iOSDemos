//
//  OneDateView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneDateView : UIView
@property (nonatomic, copy)void(^OneDateViewBlock)(NSString * dateStr, NSIndexPath * path);
@end
