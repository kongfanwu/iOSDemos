//
//  ViewController.m
//  FWRACDEmo
//
//  Created by kfw on 2019/12/19.
//  Copyright © 2019 神灯智能. All rights reserved.
// https://www.jianshu.com/p/14075b5ec5ff
// https://www.jianshu.com/p/fecbe23d45c1
// https://github.com/Draveness/analyze/blob/master/contents/ReactiveObjC/RACSignal.md
// https://ld246.com/article/1481187709262
// 美团团队 https://tech.meituan.com/2015/09/08/talk-about-reactivecocoas-cold-signal-and-hot-signal-part-1.html

/*
 什么是冷信号与热信号
 冷热信号的概念源于.NET框架Reactive Extensions(RX)中的Hot Observable和Cold Observable，两者的区别是：
 Hot Observable是主动的，尽管你并没有订阅事件，但是它会时刻推送，就像鼠标移动；而Cold Observable是被动的，只有当你订阅的时候，它才会发布消息。
 Hot Observable可以有多个订阅者，是一对多，集合可以与订阅者共享信息；而Cold Observable只能一对一，当有不同的订阅者，消息是重新完整发送。
 */
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
///
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@end

@implementation ViewController
- (UIActivityIndicatorView *)activity {
    if (_activity) return _activity;
    _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];//指定进度轮的大小
    [_activity setCenter:CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2)];//指定进度轮中心点
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleLarge];//设置进度轮显示类型
    [self.view addSubview:_activity];
    return _activity;
}

// 1. RACSignal 信号
- (void)test {
    // 订阅多个信号
    @weakify(self);
    // 这是一个冷信号，每次订阅都会执行信号block，一对一关系
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
    
    /* 由于是冷信号，打印的log。会多执行耗时操作
        2019-12-20 13:52:14.812463+0800 FWRACDEmo[53358:34808357] 信号内容：发送信号
        2019-12-20 13:52:14.812574+0800 FWRACDEmo[53358:34808357] 耗时操作
        2019-12-20 13:52:14.812671+0800 FWRACDEmo[53358:34808357] RACDisposable
        2019-12-20 13:52:14.812766+0800 FWRACDEmo[53358:34808357] 信号内容2：发送信号
        2019-12-20 13:52:14.812842+0800 FWRACDEmo[53358:34808357] 耗时操作
        2019-12-20 13:52:14.812909+0800 FWRACDEmo[53358:34808357] RACDisposable
        */
    
    // 解决方法：为解决冷信号导致的问题。将冷信号转为热信号。
    // 方法1
    RACMulticastConnection *connection = [signal publish]; // 内部其实是 RACSubject 作为热信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"connection信号内容：%@", x);
    }];
//    connection.autoconnect
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"connection信号内容2：%@", x);
    }];
    [connection connect];
    
    // 想要确保第一次订阅就能成功订阅sourceSignal，可以使用- (RACSignal *)autoconnect这个方法，它保证了第一个订阅者触发sourceSignal的订阅，也保证了当返回的信号所有订阅者都关闭连接后sourceSignal被正确关闭连接。
//    [connection.autoconnect subscribeNext:nil];
    
    /*
     // 方法2
     RACSignal *newSignal = [signal replay]; // 内部其实是 RACReplaySubject 作为热信号，有缓存能力
     // 方法3
     RACSignal *newSignal = [signal replayLazily]; // 和replay相同，区别是newSignal被订阅时候才会订阅 signal
     // 方法4
     RACSignal *newSignal = [signal replayLast]; // - (RACSignal *)replayLast就是用Capacity为1的RACReplaySubject来替换- (RACSignal *)replay的`subject。其作用是使后来订阅者只收到最后的历史值。
     */
    
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
    /* 订阅信号（通常在别的视图控制器中订阅，与代理的用法类似） */
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    /* 发送信号 */
    [subject sendNext:@"发送信号"];
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
    
    RACSignal *networkingSignal;
    button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return networkingSignal;
    }];
    
    //按钮的可用信号
    RACSignal *btnEnableSignal = [RACSignal combineLatest:@[_textField.rac_textSignal,_textField.rac_textSignal] reduce:^id(NSString *username,NSString *pwd){
        return @(username.length>0 && pwd.length>0);
    }];
    
    // 按钮是否可点击，可点击回调请求网络
    button.rac_command = [[RACCommand alloc] initWithEnabled:btnEnableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return networkingSignal;
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

/// button 注册信号，返回新信号
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

/// RACCommand
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

/// 实战使用示例：点击事件直接返回请求信号，
- (void)test17 {
    RACSignal *networkSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"请求成功"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    // 按钮事件里添加过滤，返回新信号，订阅新事件
//    [[[_button rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
//        return networkSignal;
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];

    // doNext: 生成新信号，监听旧信号,一般用于在信号回调前增加额外功能
    [[[[_button rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        [self.activity startAnimating];
    }] flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
        return networkSignal;
    }] subscribeNext:^(id  _Nullable x) {
        [self.activity stopAnimating];
        NSLog(@"%@", x);
    }];
}

/// 延迟调用
- (void)test18 {
    // throttle:订阅的 block(subscribeNext)延时被调用
    [[[_button rac_signalForControlEvents:UIControlEventTouchUpInside] throttle:2] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"throttle=%@",x);//2s后调用
    }];

    //  delay:延迟多久后
    [[[_button rac_signalForControlEvents:UIControlEventTouchUpInside] delay:2] subscribeNext:^(id x) {
        NSLog(@"delay=%@",x);//5s后调用
    }];

    // timeout:超时
    RACSignal *buttonSignal = [_button rac_signalForControlEvents:UIControlEventTouchUpInside];
    [[buttonSignal timeout:5 onScheduler:[RACScheduler scheduler]] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);//如果时间超过5s后就不会调用
    }];
}

/// concat :信号串联，必须是一个信号完成之后，才可以开始另一个信号，所以第一个信号必须执行 sendCompleted 才会执行后面的信号
/// merge: 信号并联，信号可以同时并联执行，必定是多线程执行的，后面的信号不一定等到前面的信号执行完才执行
/// then: 信号忽略，会忽略调用此方法的信号，内部实现是串联 concat
- (void)test119 {
    RACSignal *eat = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"吃饭"];
        [subscriber sendNext:@"完毕"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *work = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"上班"];
        [subscriber sendNext:@"完毕"];
        [subscriber sendCompleted];
        return nil;
    }];
    
//    [[eat concat:work]subscribeNext:^(id x) {
//        NSLog(@"%@",x);//吃饭 完毕 上班 完毕  eat没有sendCompleted,就输出 吃饭 完毕
//    }];
    
//    [[eat merge:work]subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    [[eat then:^RACSignal * _Nonnull{
        return work;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x); // 上班 完毕
    }];
}

/// UIKit分类相关
- (void)test120 {
    // 通知
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 手势
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"view被点击");
    }];
    [self.view addGestureRecognizer:tap];

}

/// 1.RACObserve(TARGET,KEYPATH):KVO 监听
/// 2.RAC(TARGET, ...):绑定某个对象的属性
- (void)test121 {
    //监听某个对象的属性是否变化
    //方法一:
    [_textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //方法二:RACObserve(<#TARGET#>, <#KEYPATH#>)
    [RACObserve(_textField,text)subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    RAC(_label,text) = _textField.rac_textSignal;
}

/// 遍历集合
- (void)test122 {
    // 1.数组遍历
//    NSArray *names = @[@"liu",@"wen",@"xiao",@"li"];
//    [names.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//        NSLog(@"[NSThread isMainThread]=%d", [NSThread isMainThread]); // 0  注意是异步的
//    }];
    
    //2.字符串遍历
    NSString *text = @"123456789";
//    [text.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//        NSLog(@"[NSThread isMainThread]+%d", [NSThread isMainThread]); // 0
//    }];
    
    //3.添加过滤条件
    [[text.rac_sequence.signal filter:^BOOL(id value) {
        return [value integerValue] > 5;
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);//输出6,7,8,9
    }];
}

/// 冷信号与热信号
- (void)test23 {
    /*
     RACSubject及其子类(RACReplaySubject)是热信号。
     RACSignal排除RACSubject类以外的是冷信号。
     
     热信号 RACSubject RACReplaySubject
     冷信号 RACSignal
     */
    
    // RACReplaySubject具备为未来订阅者缓冲事件的能力。
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"1"];
    [replaySubject sendNext:@"2"];
    // 先发送，后订阅，也能收到之前发送的消息
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext2:%@", x);
    }];
    
    RACSubject *subject = [RACSubject subject];
    // 没有缓存，先发送，后订阅，接收不了事件
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    [subject sendNext:@"发送信号"];
}

/// 实战示例
- (void)test24 {
    RACSignal *flattenSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@"11"];
            [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
                [subscriber sendError:nil];
            }];
        }];
        return nil;
    }];
    // 如果有错误，显示错误提示，否则将Loading提前self信号显示
    // catchTo: 如果信号是错误，返回新的信号。
    // startWith: 先执行通过@"Loading"生成的新信号。再执行self信号。内部使用 concat :信号串联 技术
    RAC(_label, text) = [[flattenSignal catchTo:[RACSignal return:@"Error"]] startWith:@"Loading"];
}

/// 网络请求示例
- (void)test125 {
    RACCommand * btnPressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"组合参数，准备发送登录请求");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"开始请求");
            NSLog(@"请求成功");
            NSLog(@"处理数据");
            [subscriber sendNext:@"请求完成，数据给你"];
            [subscriber sendNext:@"请求完成，数据给你1"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    
    [btnPressCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面… %@",x);
    }];
    
    [btnPressCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
    }];
    
    [[btnPressCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行中……");
        }else{
            NSLog(@"执行结束了");
        }
    }];
    
    [btnPressCommand execute:@{@"account": @"value"}];
}

/// 信号取值：take、takeLast、takeUntil
- (void)test26 {
//    RACSubject * subject = [RACSubject subject];
    // take 指定哪些信号 正序 取前2条消息
//    [[subject take:2] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    // take 指定哪些信号 倒序 取后2条消息
//    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [subject sendNext:@"A"];
//    [subject sendNext:@"B"];
//    [subject sendNext:@"C"];
//    [subject sendNext:@"D"];
//    [subject sendNext:@"E"];
//    [subject sendCompleted];
    
    
    // takeUntil 标记，需要一个信号作为标记，当标记的信号发送数据，就停止。
    RACSubject * subject = [RACSubject subject];
    RACSubject * subject1 = [RACSubject subject];
    // subject1 发送信号 subject就停止接受订阅
    [[subject takeUntil:subject1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    
    [subject1 sendNext:@"Stop"];
    
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];
}

/// zipWith
- (void)test27 {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signalA1"];
        [subscriber sendNext:@"signalA2"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signalB1"];
        [subscriber sendNext:@"signalB2"];
        [subscriber sendCompleted];
        return nil;
    }];
    //调用
    RACSignal *zipSignal = [signalA zipWith:signalB];
    [zipSignal subscribeNext:^(id  _Nullable x) {
        // x 是一个元祖
        RACTupleUnpack(NSString *a, NSString *b) = x;
        NSLog(@"a=%@ b=%@", a, b);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test27];
    
}

@end
