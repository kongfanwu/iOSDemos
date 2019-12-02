//
//  OrderChoiseView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderChoiseView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIImageView *redLine;
@property (copy, nonatomic) void (^OrderChoiseViewBlock)(NSInteger index);
@end
