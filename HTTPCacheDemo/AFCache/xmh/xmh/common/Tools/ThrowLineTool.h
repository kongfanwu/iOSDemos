//
//  ThrowLineTool.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ThrowLineToolDelegate <NSObject>

/**
 *  抛物线结束的回调
 */
- (void)animationDidFinish;

@end

@interface ThrowLineTool : NSObject

@property (nonatomic, weak) id<ThrowLineToolDelegate>delegate;
@property (nonatomic, strong) UIView *showingView;

+ (ThrowLineTool *)sharedTool;

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end;

@end





