//
//  LDatePickView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LDatePickViewBlock)(NSString *start,NSString *end);
@interface LDatePickView : UIView
@property (nonatomic, strong)UIButton * btn;

//显示的 格式：2018年-03月-01日
@property (nonatomic, copy)NSString * startShow;
@property (nonatomic, copy)NSString * endShow;
//传参的 格式：2018-03-01
@property (nonatomic, copy)NSString * startParam;
@property (nonatomic, copy)NSString * endParam;
//传参的格式：2018-03-01
@property (nonatomic, copy)void (^LDatePickViewBlock)(NSString *start,NSString *end);
/** <#type#> */
@property (nonatomic, copy) void (^removeBlock)(LDatePickView *datePickView);
- (instancetype)initWithFrame:(CGRect)frame dateBlock:(LDatePickViewBlock)block;
/** 凭证管理需要传开始时间与结束时间 */
- (instancetype)initWithFrame:(CGRect)frame startTime:(NSString *)startTime endTime:(NSString *)endTime dateBlock:(LDatePickViewBlock)block;

/**
 显示
 */
- (void)show;
@end
