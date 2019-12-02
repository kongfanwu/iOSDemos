//
//  LFWDNoticeView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFWDNoticeView : UIView
@property (copy, nonatomic)NSString * title;
@property (copy, nonatomic)NSString * content;
@property (copy, nonatomic)NSString * input;
@property (copy, nonatomic)NSString * left;
@property (copy, nonatomic)NSString * right;
@property (copy, nonatomic)void (^LFWDNoticeViewBlock)(NSInteger index,NSString * time);
@property (copy, nonatomic)void (^reverseViewBlock)(NSInteger index,NSString * payStr);
@property (copy, nonatomic)NSString * from;

- (void)showWithTitle:(NSString *)title content:(NSString *)content input:(NSString *)input leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle;
- (void)showWithTitle:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle;

@end
