//
//  ViewController.m
//  GCD
//
//  Created by 孔凡伍 on 15/9/2.
//  Copyright (c) 2015年 kongfanwu. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController
{
    pthread_mutex_t _lock;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@1,@2];
    
    NSArray *testArr = [array sortedArrayWithOptions:NSSortStable usingComparator:
                        ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                            int value1 = [obj1 intValue];
                            int value2 = [obj2 intValue];
                            if (value1 > value2) {
                                return NSOrderedDescending;
                            }else if (value1 == value2){
                                return NSOrderedSame;
                            }else{
                                return NSOrderedAscending;
                            }
                        }];

    // Do any additional setup after loading the view, typically from a nib.
//    [self createSerial];
    
//    [self createConcurrent];
    
//    [self getSystemConcurrentQueue];
    
//    [self setQueuePriority];
    
//    [self time];
    
//    [self lastBlock];
    
//    [self barrier_async];
    
//    [self dispatch_apply];
    
//    [self dispatch_semaphore];
    
//    [self pthread_mutex_t];
//    [self groupEnterLeave];
    /*
     sync 高
     sync 中
     sync 低
     sync 最后统一
     
     addDependency
     */
    
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            dispatch_semaphore_signal(semaphore);
//        });
//    });
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    NSLog(@"请求开始");
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"请求结束");
//        dispatch_semaphore_signal(semaphore);
//    });
//   long result = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"result: %ld", result);
//    long result2 = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"result2: %ld", result2);
//    long result3 = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"result3: %ld", result3);

    
}

/**
 *  创建串行队列
 */
- (void)createSerial
{
    // 串行队列
    dispatch_queue_t mySerialQueue = dispatch_queue_create("com.xiaowu.mySerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(mySerialQueue, ^{
        
    });
    
    dispatch_async(mySerialQueue, ^{
        NSLog(@"2");
    });
    
    dispatch_async(mySerialQueue, ^{
       NSLog(@"3");
    });
    
    dispatch_async(mySerialQueue, ^{
       NSLog(@"4");
    });
    
}

/**
 *  获取主线程串行队列
 */
- (void)getMainQueue
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"主线程中执行的");
    });
}

/**
 *  创建并行队列
 */
- (void)createConcurrent
{
    // 并行队列
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.xiaowu.myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(myConcurrentQueue, ^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"1");
        }
    });
    
    dispatch_async(myConcurrentQueue, ^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"2");
        }
    });
    
    dispatch_async(myConcurrentQueue, ^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"3");
        }
    });
    
    dispatch_async(myConcurrentQueue, ^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"4");
        }
    });
}

/**
 *  获取系统提供的队列
 */
- (void)getSystemConcurrentQueue
{
    /* 优先级
     DISPATCH_QUEUE_PRIORITY_HIGH       高
     DISPATCH_QUEUE_PRIORITY_DEFAULT    默认
     DISPATCH_QUEUE_PRIORITY_LOW        低
     DISPATCH_QUEUE_PRIORITY_BACKGROUND 后台运行
     */
    dispatch_queue_t highQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t lowQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    dispatch_async(highQueue, ^{
        NSLog(@"highQueue");
    });
    
    dispatch_async(defaultQueue, ^{
        NSLog(@"defaultQueue");
    });
    
    dispatch_async(lowQueue, ^{
        NSLog(@"lowQueue");
    });
    
    dispatch_async(backgroundQueue, ^{
        NSLog(@"backgroundQueue");
    });
}

/**
 *  1 改变队列优先级
 *  2 dispatch Queue 执行层阶
 */
- (void)setQueuePriority
{
    // 1 改变队列优先级
    dispatch_queue_t queue = dispatch_queue_create("com.dev.queue", 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    // queue: 要变更优先级的队列 queue2:要变更成优先级的队列
    dispatch_set_target_queue(queue, queue2);
    
    // 2 dispatch Queue 执行层阶
    dispatch_queue_t queue3 = dispatch_queue_create("com.dev.queue3", 0);
    dispatch_queue_t queue4 = dispatch_queue_create("com.dev.queue4", 0);
    dispatch_queue_t queue5 = dispatch_queue_create("com.dev.queue5", 0);
    /*
     * 将 queue4 queue5 指定目标位 queue3
     * queue3 先执行 queue4 queue5 后执行，
     * 可防止 串行队列并行执行
     */
    dispatch_set_target_queue(queue5, queue3);
    dispatch_set_target_queue(queue4, queue3);
    
    dispatch_async(queue5, ^{
        NSLog(@"queue5");
    });
    
    dispatch_async(queue4, ^{
        NSLog(@"queue4");
        
    });
    
    dispatch_async(queue3, ^{
        NSLog(@"queue3");
    });
}

/**
 *  3秒后执行
 */
- (void)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"三秒后执行");
    });
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
    });
    
}

/**
 *  多线程全部执行完，执行最后的block
 */
- (void)lastBlock
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"2");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"3");
    });
 
    dispatch_group_notify(group, queue, ^{
        NSLog(@"最后执行");
    });
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    /*
     * dispatch_group_wait 此线程一直等待状态
     * DISPATCH_TIME_FOREVER 直到等待全部执行结束 必返回0
     * time 超时时间 为3妙
     */
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        NSLog(@"全部处理结束");
    } else {
        NSLog(@"没有全部处理结束");
    }
}

/**
 *  避免数据竞争
 */
- (void)barrier_async
{
    dispatch_queue_t queue = dispatch_queue_create("com.dev.fanwu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{ NSLog(@"1"); });
    dispatch_async(queue, ^{ NSLog(@"2"); });
    dispatch_async(queue, ^{ NSLog(@"3"); });
    // 与并行对列使用。先等待queue中得线程全部执行完毕，在执行 dispatch_barrier_sync。dispatch_barrier_sync执行完回复 queue状态继续执行剩余的线程
    dispatch_barrier_sync(queue, ^{
        NSLog(@"中间插入数据");
    });
    dispatch_async(queue, ^{ NSLog(@"4"); });
    dispatch_async(queue, ^{ NSLog(@"5"); });
    dispatch_async(queue, ^{ NSLog(@"6"); });
   
}

/**
 *  循环N次
 */
- (void)dispatch_apply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    /*
     * 并行执行 非顺序执行(0 1 2)。
     * dispatch_apply 会等待全部处理结束，最后打印 "done"
     */
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"index:%ld",index);
    });
    NSLog(@"done");
}

/**
 *  queue 挂起 恢复
 */
- (void)queue_suspend_resume
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 挂起 对已经执行的线程没有影响，后续追加的线程且尚未执行，恢复后可继续执行
    dispatch_suspend(queue);
    // 恢复
    dispatch_resume(queue);
}

/**
 *  持有计数信号
 */
- (void)dispatch_semaphore
{
    NSMutableArray *array = [NSMutableArray array];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 初始值计数为1，保证只有一个线程访问数组
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            /**
             *  等待,由于semaphore计数大于1， semaphore执行减1并返回。
             * 此时semaphore计数为0，访问数组线程只有一个，可安全更新
             */
            long result = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            if (result == 0) {
                NSLog(@"插入");
                [array addObject:@(i)];

            } else {
                NSLog(@"待机");
            }
            
            /**
             *  排除其他线程控制结束，dispatch_semaphore_signal 使semaphore 计数加1
             */
            dispatch_semaphore_signal(semaphore);

        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"%@",array);
    });
    
}

- (void)pthread_mutex_t
{
    // http://casatwy.com/pthreadde-ge-chong-tong-bu-ji-zhi.html
    
    /*
     1 互斥锁
     2 读写锁
     3 空转锁
     */
    
    // 初始化互斥量
    pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
    _lock = lock;
//    pthread_mutex_init(&_lock, NULL);
    pthread_mutex_t lock2 = PTHREAD_MUTEX_INITIALIZER;
    
    NSMutableArray *asmissionTickets = [NSMutableArray array];
    dispatch_queue_t queue4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue4, ^{
            // 加锁
            pthread_mutex_lock(&_lock);
            [asmissionTickets addObject:@(i)];
            
            
            // 解锁
            pthread_mutex_unlock(&_lock);
        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        // 释放互斥量
        pthread_mutex_destroy(&_lock);
        NSLog(@"%@", asmissionTickets);
    });
}

/* 使用Dispatch Group与dispatch_block_cancel，取消异步任务
 可以使用group与dispatch_block_cancel将一组编排好的异步任务组中的异步任务进行取消，比方说在某个视图控制器中，发起了N个网络请求，离开界面的时候，如果网络请求没有全部结束，而用户退出该界面，则可以取消这些异步任务回收线程资源，简单实现如下:
 */
- (void)groupEnterLeave {
    //使用Dispatch Group与dispatch_block_cancel，取消异步任务
    NSMutableArray * request_blocks = [NSMutableArray array];
    dispatch_group_t request_blocks_group = dispatch_group_create();
    //开启五个异步网络请求任务
    for (int i = 0; i<5; i++) {
        dispatch_block_t request_block = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
            NSURLRequest * request = [[NSURLRequest alloc]init];
            dispatch_group_enter(request_blocks_group);
//            [self postWithRequest:request completion:^(id responseObjecy, NSURLResponse *response, NSError *error) {
//                //do somethings
//                dispatch_group_leave(request_blocks_group);
//            }];
        });
        [request_blocks addObject:request_block];
        dispatch_async(dispatch_get_main_queue(), request_block);
    }
    //取消这五个任务
    for (dispatch_block_t request_block in request_blocks) {
        dispatch_block_cancel(request_block);
        dispatch_group_leave(request_blocks_group);
    }
    dispatch_group_notify(request_blocks_group, dispatch_get_main_queue(), ^{
        NSLog(@"网络任务请求执行完毕或者全部取消");
    });
}



@end
