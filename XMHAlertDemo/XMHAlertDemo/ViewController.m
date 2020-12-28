//
//  ViewController.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//
/*
 
 */
#import "ViewController.h"
#import "XMHAlertVC.h"
#import "XMHAlertDefaultContentView.h"
#import "XMHAlertTextFieldContentView.h"
#import "AppDelegate.h"
#import "ViewController2.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:ViewController2.new animated:YES completion:nil];
}

- (IBAction)click1:(id)sender {
    // 只显示标题
    XMHAlertVC.alertWithStyle(XMHAlertStyleDefault)
    .titleText(@"尽量控制在两行内提示内容")
    .action([XMHAlertAction actionWithTitle:@"确认" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {

    }]).show();
}

- (IBAction)click2:(id)sender {
    // 显示标题和详情
    XMHAlertVC.alertWithStyle(XMHAlertStyleDefault)
    .titleText(@"")
    .messageText(@"")
    .action([XMHAlertAction actionWithTitle:@"确认" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {
        
    }])
    .action([XMHAlertAction actionWithTitle:@"取消" style:XMHAlertActionStyleDestructive handler:^(XMHAlertAction * _Nonnull action) {
        
    }]).show();
    
}
- (IBAction)click3:(id)sender {
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
    
    
}

- (IBAction)click4:(id)sender {
    // 自定义UI 示例
    XMHAlertTextFieldContentView *contentView = [[XMHAlertTextFieldContentView alloc] init];
    contentView.textField.placeholder = @"请输入自定义标签名称";
    
    XMHAlertVC *alert = [XMHAlertVC alertWithContentView:contentView]
    .action([XMHAlertAction actionWithTitle:@"取消" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {
        
    }]);
    [self presentViewController:alert animated:YES completion:nil];
}

@end
