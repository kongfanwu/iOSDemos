//
//  workBtnChoice.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface workBtnChoice : UIView
//对应的按钮触发事件
@property (nonatomic, copy)void(^workBtnChoiceBlock)(NSString *btnTitleStr);
@end
