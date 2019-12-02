//
//  XMHSuccessAlertView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ButtonOnlick)(NSInteger index);
typedef void(^TextFieldOnlick)(NSInteger index,NSString *text);
@interface XMHSuccessAlertView : UIView

@property (nonatomic, copy)void (^closeAlertView)();
@property (nonatomic, copy)void (^cancelBlock)();
@property (nonatomic, copy)void (^otherBlock)();
@property (nonatomic ,copy)ButtonOnlick onclick;
@property (nonatomic ,copy)TextFieldOnlick textFieldOnclick;
@property (nonatomic, assign) BOOL kucunLimit;// 库存限制

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *otherBtn;

/**
 带图片的两个按钮弹窗的构造方法

 @param title 弹框title
 @param cancelButtonTitle str
 @param otherButtonTitle str
 @return Y/N
 */
- (instancetype)initWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitle click:(ButtonOnlick)click;

/**
 提示弹框

 @param title 提示
 @return 返回弹框
 */
- (instancetype)initWithTitle:(NSString *)title;


/**
 两个按钮弹窗的构造方法

 @param title 提示文字
 @param click 点击事件
 @return 返回弹框
 */
- (instancetype)initWithTitle:(nullable NSString *)title withTwoBtnclick:(ButtonOnlick)click;

/**
 输入框两个按钮弹窗的构造方法
 @param title 弹窗标题
 */
-(instancetype)initWithTextFieldTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(TextFieldOnlick)click;


/**
 带tableView的构造方法

 @param title 提示文字
 @param dataSource tableView的数据源
 @param sureButtonTitle 确认按钮文字
 @param click 点击事件
 @return 返回弹框
 */
- (instancetype)initWithTitle:(nullable NSString *)title tableViewDataSource:(nullable NSArray *)dataSource sureButtonTitle:(NSString *)sureButtonTitle click:(ButtonOnlick)click;

/** show出这个弹窗 */
- (void)show;

/** dismiss这个弹窗 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
