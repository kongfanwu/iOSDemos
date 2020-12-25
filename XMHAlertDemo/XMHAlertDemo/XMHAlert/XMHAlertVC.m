//
//  XMHAlertVC.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#import "XMHAlertVC.h"
#import "UIView+Exting.h"
#import "XMHAlertAction.h"
#import "XMHAlertDefaultContentView.h"
#import "XMHAlertTextFieldContentView.h"

@interface XMHAlertVC ()
/// 内容view
@property (nonatomic, strong) UIView <XMHAlertContentViewProtocol> *contentView;
@end

@implementation XMHAlertVC

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    [self.view addSubview:_contentView];
}

#pragma mark - Public

- (instancetype)initWithContentView:(UIView <XMHAlertContentViewProtocol> *)contentView
{
    self = [super init];
    if (self) {
        self.contentView = contentView;
    }
    return self;
}

/// 链式初始化方法
+ (XMHAlertVC *(^)(XMHAlertStyle))alertWithStyle {
    return ^XMHAlertVC *(XMHAlertStyle style){
        return [XMHAlertVC alertWithStyle:style];
    };
}

///  初始化方法
/// @param style 样式
+ (instancetype)alertWithStyle:(XMHAlertStyle)style {
    if (style == XMHAlertStyleDefault) {
        return [XMHAlertVC alertWithContentView:[[XMHAlertDefaultContentView alloc] init]];
    }
    else if (style == XMHAlertStyleTextField) {
        XMHAlertTextFieldContentView *contentView = [[XMHAlertTextFieldContentView alloc] init];
        contentView.textField.placeholder = @"请输入自定义标签名称";
        return [XMHAlertVC alertWithContentView:contentView];
    }
    return nil;
}

/// 初始化方法
/// @param contentView 内容view
+ (instancetype)alertWithContentView:(UIView <XMHAlertContentViewProtocol> *)contentView {
    NSAssert(contentView != nil, @"contentView 不能为nil");
    XMHAlertVC *alert = [[XMHAlertVC alloc] initWithContentView:contentView];
    alert.contentView = contentView;
    return alert;
}

/// 显示
- (XMHAlertVC *(^)(void))show {    
    return ^XMHAlertVC *(){
        UIViewController *vc = [UIView getCurrentWindow].rootViewController;
        return self.showInVC(vc);
    };
}
- (XMHAlertVC *(^)(UIViewController *))showInVC {
    return ^XMHAlertVC *(UIViewController *vc){
        NSAssert(vc != nil, @"vc 不能为nil");
        [vc presentViewController:self animated:YES completion:nil];
        return self;
    };
}

@end

#pragma mark - Category

@implementation XMHAlertVC (ContentViewConfigure)

- (XMHAlertVC *(^)(NSString *))titleText {
    return ^XMHAlertVC *(NSString * titleText){
        self.contentView.titleText = titleText;
        return self;
    };
}

- (XMHAlertVC *(^)(NSString *))messageText {
    return ^XMHAlertVC *(NSString * messageText){
        self.contentView.messageText = messageText;
        return self;
    };
}

- (XMHAlertVC *(^)(XMHAlertAction *))action {
    return ^XMHAlertVC *(XMHAlertAction * action){
        NSAssert(action != nil, @"action 不能为nil");
        [self.contentView.actions addObject:action];
        return self;
    };
}

- (XMHAlertVC *(^)(void(^)(UITextField *)))textField {
    return ^XMHAlertVC *(void(^block)(UITextField *textField)){
        if ([self.contentView isKindOfClass:[XMHAlertTextFieldContentView class]]) {
            XMHAlertTextFieldContentView *textFieldContentView = (XMHAlertTextFieldContentView *)self.contentView;
            if (block) { block(textFieldContentView.textField); }
        }
        return self;
    };
}

@end
