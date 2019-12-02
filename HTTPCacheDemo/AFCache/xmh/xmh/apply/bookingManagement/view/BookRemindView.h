//
//  BookRemindView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookRemindView : UIView
- (instancetype)initWithFrame:(CGRect)frame oneBtnTitle:(NSString *)title content:(NSString *)contentText;
- (instancetype)initWithFrame:(CGRect)frame leftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle content:(NSString *)contentText;
@property (strong, nonatomic)UIButton * btnLeft;
@property (strong, nonatomic)UIButton * btnRight;
@property (strong ,nonatomic)UILabel * lbTitle;
@property (strong, nonatomic)UIButton * btnCenter;
@property (strong, nonatomic)UIButton * btnCancel;

@property (strong, nonatomic)UIView * view;
@property (copy ,nonatomic)void(^cencelBtn)();

- (void)afterFreshHeight:(NSInteger)height;
- (void)refreshTitleFrame;

/** <##> */
@property (nonatomic, strong) UILabel * lbContent;
@end
