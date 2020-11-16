//
//  ViewController.m
//  NSThread+RunLoop
//
//  Created by kfw on 2019/7/30.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesBegan");
    // 创建或获取线程
    NSThread *thread = [self.class networkRequestThread];
    // 如果线程没有执行
    if (!thread.executing) {
        // 启动线程
        [thread start];
    }
    
    [self performSelector:@selector(task:) onThread:thread withObject:@"kong" waitUntilDone:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建或获取线程
    NSThread *thread = [self.class networkRequestThread];
    // 如果线程没有执行
    if (!thread.executing) {
        // 启动线程
        [thread start];
    }
    
    NSLog(@"main thread log 1");
    // 让 thread 线程 执行 task: 方法。 传的参数是 字符串。 waitUntilDone 是否等待上边的任务完成。NO 不等待
    [self performSelector:@selector(task:) onThread:thread withObject:@"kong" waitUntilDone:NO];
//    [self task:nil];
    NSLog(@"main thread log 2");
}

static int num = 0;
- (void)task:(id)obj {
    @autoreleasepool {
        BOOL isMainT = [NSThread isMainThread];
        NSLog(@"isMainT:%d", isMainT);
        
        NSThread *thread = NSThread.currentThread; // 获取当前线程
        for (int i = 0; i < 10; i++) {
            NSLog(@"%d", i);
            num += i;
        }
        
        //    if (num > 100) {
        //        NSLog(@"removePort");
        ////        [[NSRunLoop currentRunLoop] removePort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        //
        //        CFRunLoopStop(CFRunLoopGetMain());
        //
        //
        //    }
        
        // 子线程执行完任务，回到主线程刷线UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = @(num).stringValue;
            
        });
    }
}

+ (void)stopThread {
//    [subThreadRunLoop removePort:self.messagePort forMode:NSDefaultRunLoopMode]; 可能会销毁，不可靠
// 线程里边 调用 exit 方法也是不可靠的。可能会销毁
//    调用void CFRunLoopStop(CFRunLoopRef rl) 来干掉runloop
    CFRunLoopStop(CFRunLoopGetCurrent());
}

+ (NSThread *)networkRequestThread {
    static NSThread * _networkRequestThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 单利创建一个线程。线程启动后 调用 self(ViewController) networkRequestThreadEntryPoint: 方法
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
    });
    return _networkRequestThread;
}

+ (void)networkRequestThreadEntryPoint:(id)__unused obj {
    // 创建自动释放池
    @autoreleasepool {
        // 设置当前线程的名字，以便在调试的时候可以看到是哪个线程
        [[NSThread currentThread] setName:@"AFNetworking"];
        
        // 获取当前线程 RunLoop. 如果当前线程没有RunLoop 那就创建后在返回
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        /*
         RunLoop 默认没有 Source\Time\Observe 没事就睡眠了。
         因为咱们某些时候需要让线程干活。唤醒线程好像是系统底层的API干的，所以让线程一直处于监听状态。目的不让线程睡眠
         
         如果一个 mode 中一个 item 都没有，则 RunLoop 会直接退出，不进入循环。
         */
        // 让 runloop 监听一个端口，目的不让线程睡眠
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        // 运行线程
        [runLoop run];
        NSLog(@"runLoop 退出了");
    }
}


@end
