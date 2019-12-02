//
//  LMsgNavView.h
//  xmh
//
//  Created by ald_ios on 2018/8/31.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNavView : UIView
@property (nonatomic, copy)void (^NavViewBlock)();
@property (nonatomic, copy)void (^NavViewBackBlock)();
@property (nonatomic, copy)void (^NavViewRightBlock)();
@property (weak, nonatomic) IBOutlet UIButton *btnTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (void)setNavViewTitle:(NSString *)title;
- (void)setNavViewTitle:(NSString *)title titleImage:(NSString *)titleImage;
- (void)setNavViewTitle:(NSString *)title backBtnShow:(BOOL)show;
- (void)setNavViewTitle:(NSString *)title backBtnShow:(BOOL)show rightBtnTitle:(NSString *)rightTitle;
- (void)setNavViewTitle:(NSString *)title backBtnShow:(BOOL)show rightBtnImage:(NSString *)imageStr;
@end
