//
//  ViewController2.m
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/25.
//

#import "ViewController2.h"
#import "XMHAlertVC.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) _self = self;
    XMHAlertVC.alertWithStyle(XMHAlertStyleDefault)
    .titleText(@"尽量控制在两行内提示内容")
    .action([XMHAlertAction actionWithTitle:@"确认" style:XMHAlertActionStyleDefault handler:^(XMHAlertAction * _Nonnull action) {
        __strong typeof(_self) self = _self;
        NSLog(@"%@", self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }])
    .showInVC(self);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
