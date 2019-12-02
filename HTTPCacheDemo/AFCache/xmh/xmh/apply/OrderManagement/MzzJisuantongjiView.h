//
//  MzzJisuantongjiView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzJisuantongjiView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setupRequestUrl:(NSString *)url andEvaluateJavaScript:(NSString *)js;
@property (nonatomic ,copy) void (^webHeight)(CGFloat height);
@end
