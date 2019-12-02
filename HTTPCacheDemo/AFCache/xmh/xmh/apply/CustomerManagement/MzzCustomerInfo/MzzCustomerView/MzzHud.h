//
//  MzzHud.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MzzTipAwardView.h"
#import "BookRemindView.h"
typedef void(^ButtonOnlick)(NSInteger index);
typedef void(^AwardOnclick)(NSInteger index,id something);
typedef void(^TextFieldOnlick)(NSInteger index,NSString *text);
@interface MzzHud : UIView
@property (nonatomic ,copy)ButtonOnlick onclick;
@property (nonatomic ,copy)AwardOnclick awardOnclick;
@property (nonatomic ,copy)TextFieldOnlick textFieldOnclick;
@property (nonatomic ,strong)MzzTipAwardView *tipAwardView;
/** 弹窗主内容view */
@property (nonatomic,strong) BookRemindView   *contentTipView;

/**
 两个按钮弹窗的构造方法
 
 @param title 弹窗标题
 @param message 弹窗message
 @param leftButtonTitle 左边按钮的title
 @param rightButtonTitle 右边按钮的title
 @return 一个弹窗
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(ButtonOnlick)click;

/**
 两个按钮弹窗的构造方法
 
 @param title 弹窗标题
 @param message 弹窗message
 @param leftButtonTitle 左边按钮的title
 @param rightButtonTitle 右边按钮的title
 @param hidden 隐藏叉号
 @return 一个弹窗
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(ButtonOnlick)click hiddenCancelBtn:(BOOL)hidden;

/**
 一个按钮弹窗的构造方法
 
 @param title 弹窗标题
 @param message 弹窗message
 @param centerButtonTitle 中间按钮的title
 @return 一个弹窗
 */

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  centerButtonTitle:(NSString *)centerButtonTitle click:(ButtonOnlick)click;

/**
 弹窗的构造方法
 @return 一个弹窗
 */

- (instancetype)initWithAwardClick:(AwardOnclick)click;
/** show出这个弹窗 */
- (void)show;

/** dismiss这个弹窗 */
- (void)dismiss;

/**
 弹窗的构造方法
 
 @param title 弹窗标题
 @param message 弹窗message
 */

- (void)toastWithTitle:(NSString *)title message:(NSString *)message;
+ (void)toastWithTitle:(NSString *)title message:(NSString *)message;
+(void)toastWithTitle:(NSString *)title message:(NSString *)message complete:(void (^)())complete;
/**
 输入框两个按钮弹窗的构造方法
 @param title 弹窗标题
 */
-(instancetype)initWithTextFieldTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(TextFieldOnlick)click;
/**
 带图片的两个按钮弹窗的构造方法
 @param title 弹窗标题
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle iconStr:(NSString *)iconStr click:(ButtonOnlick)click;
/**
 带图片的一个按钮弹窗的构造方法
 @param title 弹窗标题
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  centerButtonTitle:(NSString *)centerButtonTitle iconStr:(NSString *)iconStr click:(ButtonOnlick)click;
@end
