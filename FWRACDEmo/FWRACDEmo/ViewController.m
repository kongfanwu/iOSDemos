//
//  ViewController.m
//  FWRACDEmo
//
//  Created by kfw on 2019/12/19.
//  Copyright © 2019 神灯智能. All rights reserved.
// https://www.jianshu.com/p/14075b5ec5ff
// https://www.jianshu.com/p/fecbe23d45c1
// https://github.com/Draveness/analyze/blob/master/contents/ReactiveObjC/RACSignal.md
#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ReactiveObjC-umbrella.h"

#define aba(a)

@interface ViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) RACDisposable *disposable;
/** <##> */
@property (nonatomic, strong) RACSignal *signal;
@end

@implementation ViewController

/*
 信号映射：map、flattenMap

 信号过滤：filter、ignore、distinctUntilChanged

 信号合并：combineLatest、reduce、merge、zipWith

 信号连接：concat、then

 信号操作时间：timeout、interval、dely

 信号跳过：skip

 信号取值：take、takeLast、takeUntil

 信号发送顺序：donext、cocompleted

 获取信号中的信号：switchToLatest

 信号错误重试：retry
 */

// 1. RACSignal 信号
- (void)test {
    // 订阅多个信号
    @weakify(self);
    /* 创建信号 */
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        /* 发送信号 */
        [subscriber sendNext:@"发送信号"];
        NSLog(@"耗时操作");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"RACDisposable");
        }];
    }];
    self.signal = signal;
    /* 订阅信号 */
//    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        NSLog(@"信号内容：%@", x);
//    }];
//
//    [signal subscribeNext:^(id  _Nullable x) {
////        @strongify(self);
//        NSLog(@"信号内容2：%@", x);
//    }];
//    /* 取消订阅 */
//    [disposable dispose];
    
    /* 打印的log。会多执行耗时操作
        2019-12-20 13:52:14.812463+0800 FWRACDEmo[53358:34808357] 信号内容：发送信号
        2019-12-20 13:52:14.812574+0800 FWRACDEmo[53358:34808357] 耗时操作
        2019-12-20 13:52:14.812671+0800 FWRACDEmo[53358:34808357] RACDisposable
        2019-12-20 13:52:14.812766+0800 FWRACDEmo[53358:34808357] 信号内容2：发送信号
        2019-12-20 13:52:14.812842+0800 FWRACDEmo[53358:34808357] 耗时操作
        2019-12-20 13:52:14.812909+0800 FWRACDEmo[53358:34808357] RACDisposable
        */
    
    
    // 解决方法
    
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"connection信号内容：%@", x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"connection信号内容2：%@", x);
    }];
    [connection connect];
    /*
     2019-12-20 13:57:40.251990+0800 FWRACDEmo[53480:34821906] connection信号内容：发送信号
     2019-12-20 13:57:40.252099+0800 FWRACDEmo[53480:34821906] connection信号内容2：发送信号
     2019-12-20 13:57:40.252170+0800 FWRACDEmo[53480:34821906] 耗时操作
     2019-12-20 13:57:40.263729+0800 FWRACDEmo[53480:34821906] RACDisposable
     */
}

// 2. RACSubject 信号
//和代理的用法类似，通常用来代替代理，有了它，就不必要定义代理了。
- (void)test2 {
    /* 创建信号 */
    RACSubject *subject = [RACSubject subject];
    /* 发送信号 */
    [subject sendNext:@"发送信号"];
    /* 订阅信号（通常在别的视图控制器中订阅，与代理的用法类似） */
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
}

//监听 TextField 的输入改变
//可以省去设置 delegate 和实现代理方法的步骤。
- (void)test3 {
    /* 监听 TextField 的输入（内容改变就会调用） */
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        if (x.length > 3) {
            self.textField.text = [x substringToIndex:3];
        }
    }];
    
    /* 添加监听条件 */
    
    [[[self.textField.rac_textSignal distinctUntilChanged] filter:^BOOL(NSString * _Nullable value) {
        return value.length <= 3; // 表示输入文字长度 > 5 时才会调用下面的 block
    }] subscribeNext:^(NSString * _Nullable x) {
         NSLog(@"输入框内容：%@", x);
    }];
}

//监听 Button 点击事件
- (void)test4 {
    UIButton *button;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        NSLog(@"%@ 按钮被点击了", x); // x 是 button 按钮对象
    }];
}

//登录按钮状态实时监听
- (void)test5 {
    UIButton *button;
    UITextField *_username, *_password;
    // 多个心血号监听处理
    RAC(button, enabled) = [RACSignal combineLatest:@[_username.rac_textSignal, _password.rac_textSignal] reduce:^id _Nullable(NSString * username, NSString * password){
        
        return @(username.length && password.length);
    }];
    
    // 单个信号监听处理
    RAC(button, enabled) = [_username.rac_textSignal map:^id _Nullable(NSString * _Nullable username) {
        return @(username.length);
    }];
    
    
}

//8. 监听 Notification 通知事件
//可省去在 -(void)dealloc {} 中清除通知和监听通知创建方法的步骤。
- (void)test6 {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSLog(@"%@ 键盘弹起", x); // x 是通知对象
    }];
}

//9. 代替 Delegate 代理方法
//可以省去监听以及设置 delegate 的步骤，下面表示只要 view 中执行了 btnClick 这个方法，就会发送信号执行这个回调。
- (void)test7 {
    NSObject *obj;
    [[obj rac_signalForSelector:@selector(btnClick)] subscribeNext:^(RACTuple * _Nullable x) {

        NSLog(@" view 中的按钮被点击了");
    }];
}

//10. 代替 KVO 监听
//可以代替 KVO 监听，下面表示把监听 view 的 frame 属性改变转换成信号，只要值改变就会发送信号。
- (void)test8 {
    UIView *view;
    [[view rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"属性的改变：%@", x); // x 是监听属性的改变结果
    }];
    // 还有一种更简单的写法，就是利用 RAC 的宏，和上面的效果是一样的。
    [RACObserve(view, frame) subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"属性的改变：%@", x); // x 是监听属性的改变结果
    }];
}

//代替 NSTimer 计时器
- (void)test9 {
    /* 定义计时器监听 */
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        
        NSLog(@"当前时间：%@", x); // x 是当前的系统时间
        
        /* 关闭计时器 */
        [_disposable dispose];
    }];
}

//一个方法同时接受多个信号
- (void)test10 {
    // 处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，selector的方法就几个参数，每个参数对应信号发出的数据。
    // 不需要订阅:不需要主动订阅,内部会主动订阅
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
}

// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@ %@",data,data1);
}

//用来给某个对象的某个属性绑定信号，只要产生信号内容，就会把内容给属性赋值
- (void)test11 {
    //创建一个文本输入框
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, 200, 50)];
    field.backgroundColor = [UIColor grayColor];
    [self.view addSubview:field];
    //创建一个label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 200, 50)];
    [self.view addSubview:label];
    //将输入框内容给label
    RAC(label,text) = field.rac_textSignal;
}

// 代理
// 以UITextField为例，当需要对UITextField逻辑处理时，往往需要实现其各类代理方法，大大增加了代码量。当使用RAC之后
- (void)test12 {
    _textField.delegate = self; // 一定要设置代理
    RACSignal *sig = [self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)];
    [sig subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"textFieldDidBeginEditing");
    }];
    
}

// --------------------映射
// map映射用法。
- (void)test13 {
    UITextField *textField;
    // 生成新信号
    [[textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        return [RACReturnSignal return:[NSString stringWithFormat:@"zidignyi%@", value]];
    }] subscribeNext:^(id  _Nullable x) {
        
    }];
    // 返回新value
    [[textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"zidignyi%@", value];
    }] subscribeNext:^(id  _Nullable x) {
        
    }];
}
// --------------------过滤
//信号过滤有以下几种方法：filter、ignore、ignoreValue、distinctUntilChanged
- (void)test14 {
    @weakify(self);
    
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        //过滤判断条件
        @strongify(self)
        if (self.textField.text.length >= 6) {
            self.textField.text = [self.textField.text substringToIndex:6];
            self.textField.text = @"已经到6位了";
            self.textField.textColor = [UIColor redColor];
        }
        return value.length <= 6;
        
    }] subscribeNext:^(NSString * _Nullable x) {
        //订阅逻辑区域
        NSLog(@"filter过滤后的订阅内容：%@",x);
    }];
    
    [[self.textField.rac_textSignal ignoreValues] subscribeNext:^(id  _Nullable x) {
        //将self.testTextField的所有textSignal全部过滤掉
    }];
    
    [[self.textField.rac_textSignal ignore:@"1"] subscribeNext:^(id  _Nullable x) {
        //将self.testTextField的textSignal中字符串为指定条件的信号过滤掉
    }];
    
    
//    distinctUntilChanged
//    用于判断当前信号的值跟上一次的值相同，若相同时将不会收到订阅信号。
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [subject sendNext:@1111];
    [subject sendNext:@2222];
    [subject sendNext:@2222];
    
    [[RACObserve(self.textField, hidden) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        
    }];
//    [[self.textField.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
//
//    }];
}

- (void)test15 {
    // 点击按钮，触发l过滤block,返回请求信号（网络请求），注册这个信号（请求完成后会回调）。
    [[[_button rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^id _Nullable(__kindof UIControl * _Nullable value) {
        return [RACSignal createSignal:^RACDisposable *(id subscriber){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@(1)];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"Sign in result: %@", x);
    }];
}

- (void)test16 {
    //创建command信号
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            [subscriber sendNext:@"this is signal of command2"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key":@"error"}];
            [subscriber sendError:error];
//            [subscriber sendCompleted]; // 结束 和error 二选一
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
//    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"executing == %@",x);
//    }];
    
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing2 == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    //command信号中的signal信号发送出来的订阅信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals == %@",x);
    }];
    
    //监听最后一次发送的信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals switchToLatest == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}

- (void)test17 {
    
}

- (void)test18 {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test12];

}

@end
