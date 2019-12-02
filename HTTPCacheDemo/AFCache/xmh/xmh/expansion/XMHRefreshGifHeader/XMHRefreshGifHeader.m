//
//  XMHRefreshGifHeader.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/7.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHRefreshGifHeader.h"

@implementation XMHRefreshGifHeader
#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
    
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:40];
    //普通状态
    [self setImages:nil forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:nil forState:MJRefreshStatePulling];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setTitle:@"下拉松开刷新~" forState:MJRefreshStatePulling];
    
}
- (void)placeSubviews {
    [super placeSubviews];
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
    if (self.state == MJRefreshStateRefreshing) {
        self.stateLabel.hidden = YES;
        self.gifView.contentMode = UIViewContentModeScaleToFill;
    }else{
        self.stateLabel.hidden = NO;
    }
    self.gifView.mj_h = 63;
    self.gifView.mj_w = 63;
    self.gifView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%ld.gif",(unsigned long)i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}
@end
