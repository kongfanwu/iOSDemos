//
//  XMHAlertVC.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//
/* 使用示例
 
 示例 1 推荐
 // 显示标题和详情
 XMHAlertVC.alertWithStyle(XMHAlertStyleDefault)
 .titleText(@"title")
 .messageText(@"提示内容，告知状态，信息可以以折行，")
 .action([XMHAlertAction actionWithTitle:@"确认" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {
 }])
 .action([XMHAlertAction actionWithTitle:@"取消" style:XMHAlertActionStyleDestructive handler:^(XMHAlertAction * _Nonnull action) {
 }]).show();
 
 示例 2
 // 只显示标题
 [XMHAlertVC alertWithStyle:XMHAlertStyleDefault]
 .titleText(@"尽量控制在两行内提示内容")
 .action([XMHAlertAction actionWithTitle:@"确认" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {
 }]).show();
 
 示例 3
 // 输入框
 XMHAlertVC.alertWithStyle(XMHAlertStyleTextField)
 .textField(^(UITextField *textField){
     textField.text = @"初始值1";
 })
 .action([XMHAlertAction actionWithTitle:@"取消" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {
 }]).show();
// 也可以这样玩
//    XMHAlertTextFieldContentView *textFieldContentView = (XMHAlertTextFieldContentView *)alert.contentView;
//    textFieldContentView.textField.text = @"初始值2";
 */

#import <UIKit/UIKit.h>
#import "XMHAlertContentViewProtocol.h"
#import "XMHAlertAction.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHAlertStyle) {
    XMHAlertStyleDefault = 0,
    XMHAlertStyleTextField
};

@interface XMHAlertVC : UIViewController

/// 内容view
@property (nonatomic, strong, readonly) UIView <XMHAlertContentViewProtocol> *contentView;

/// 初始化方法,推荐
+ (XMHAlertVC *(^)(XMHAlertStyle))alertWithStyle;

/// 初始化方法
/// @param style 样式
+ (instancetype)alertWithStyle:(XMHAlertStyle)style;

/// 初始化方法
/// @param contentView 内容view
+ (instancetype)alertWithContentView:(UIView <XMHAlertContentViewProtocol> *)contentView;

- (instancetype)initWithContentView:(UIView <XMHAlertContentViewProtocol> *)contentView;

/// 显示
- (XMHAlertVC *(^)(void))show;
- (XMHAlertVC *(^)(UIViewController *))showInVC;

@end

#pragma mark - Category

@interface XMHAlertVC(ContentViewConfigure)

- (XMHAlertVC *(^)(NSString *))titleText;
- (XMHAlertVC *(^)(NSString *))messageText;
- (XMHAlertVC *(^)(XMHAlertAction *))action;
- (XMHAlertVC *(^)(void(^)(UITextField *)))textField;

@end

NS_ASSUME_NONNULL_END
