//
//  ViewController.m
//  FWAVPlayer
//
//  Created by kfw on 2020/12/7.
// https://blog.csdn.net/wenzfcsdn/article/details/84950194

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
///
@property (nonatomic, strong) AVPlayer *player;
///
@property (nonatomic, strong) id timeObserver;
///
@property (nonatomic, strong) NSArray *musicArray;
///
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UISlider *progressSlide;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) NSInteger currentIndex;
///
@property (nonatomic) CGFloat duration;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressSlide.minimumValue = 0;
    self.progressSlide.maximumValue = 1;//CMTimeGetSeconds(item.duration);
    self.progressSlide.value = 0;
    self.progressView.progress = 0;
    _timeLabel.text = @"00:00/00:00";
    
    self.musicArray = @[@"https://test.capnet.net.cn/micstatic/file/test/20201020/AC16031588892715906.aac"];
    self.currentIndex = 0;
}


- (AVPlayer *)player {
    if (!_player) {
//        根据链接数组获取第一个播放的item， 用这个item来初始化AVPlayer
        AVPlayerItem *item = [self getItemWithIndex:self.currentIndex];
//        初始化AVPlayer
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
        __weak typeof(self)weakSelf = self;
//        监听播放的进度的方法，addPeriodicTime: ObserverForInterval: usingBlock:
        /*
         DMTime 每到一定的时间会回调一次，包括开始和结束播放
         block回调，用来获取当前播放时长
         return 返回一个观察对象，当播放完毕时需要，移除这个观察
         */
        _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            float current = CMTimeGetSeconds(time);
            if (current) {
                [weakSelf.progressView setProgress:current / CMTimeGetSeconds(item.duration) animated:YES];
                weakSelf.progressSlide.value = current / CMTimeGetSeconds(item.duration);
                
                weakSelf.timeLabel.text = [NSString stringWithFormat:@"%f/%f", current, _duration];
            }
        }];
    }
    return _player;
}

- (AVPlayerItem *)getItemWithIndex:(NSInteger)index {
    NSURL *url = [NSURL URLWithString:self.musicArray[index]];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //KVO监听播放状态
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //KVO监听缓存大小
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //通知监听item播放完毕
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playOver:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    return item;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    AVPlayerItem *item = object;
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"未知状态，不能播放");
                break;
            case AVPlayerStatusReadyToPlay: {
                NSLog(@"准备完毕，可以播放");
                NSLog(@"item.duration=%f", CMTimeGetSeconds(item.duration));
                self.progressSlide.minimumValue = 0;
                self.progressSlide.maximumValue = 1;;
                self.progressView.progress = 0;
                self.duration =  CMTimeGetSeconds(item.duration);
                _timeLabel.text = [NSString stringWithFormat:@"%@/%f", @"00:00", _duration];
                break;
            }
            case AVPlayerStatusFailed:
                NSLog(@"加载失败, 网络相关问题");
                break;
                
            default:
                break;
        }
    }
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = item.loadedTimeRanges;
        //本次缓存的时间
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        NSTimeInterval totalBufferTime = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration); //缓存的总长度
//        self.bufferProgress.progress = totalBufferTime / CMTimeGetSeconds(item.duration);
        CGFloat progress = totalBufferTime / CMTimeGetSeconds(item.duration);
        NSLog(@"本次缓存的时间%f", progress);
    }
}

//  播放
- (IBAction)play:(id)sender {
    [self.player play];
}
 
//暂停
- (IBAction)pause:(id)sender {
    [self.player pause];
}
//重播
- (IBAction)repPlay:(id)sender {
    [self removeObserver];
//  这个方法是用一个item取代当前的item
    [self.player replaceCurrentItemWithPlayerItem:[self getItemWithIndex:self.currentIndex]];
    [self.player play];
}

- (IBAction)changeProgress:(UISlider *)sender {
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        [self.player seekToTime:CMTimeMake(CMTimeGetSeconds(self.player.currentItem.duration) * sender.value, 1)];
    }
}

- (void)playOver:(NSNotification *)not {
    NSLog(@"通知监听item播放完毕");
//    [self removeObserver];
}

//- (IBAction)next:(UIButton *)sender {
//    [self removeObserver];
//   self.currentIndex ++;
//    if (self.currentIndex >= self.musicArray.count) {
//        self.currentIndex = 0;
//    }
////  这个方法是用一个item取代当前的item
//    [self.player replaceCurrentItemWithPlayerItem:[self getItemWithIndex:self.currentIndex]];
//    [self.player play];
//}
//
//- (IBAction)last:(UIButton *)sender {
//    [self removeObserver];
//    self.currentIndex --;
//    if (self.currentIndex < 0) {
//        self.currentIndex = 0;
//    }
////  这个方法是用一个item取代当前的item
//    [self.player replaceCurrentItemWithPlayerItem:[self getItemWithIndex:self.currentIndex]];
//    [self.player play];
//}
 
// 在播放另一个时，要移除当前item的观察者，还要移除item播放完成的通知
- (void)removeObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
