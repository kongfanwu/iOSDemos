//
//  TJDatePickView.h
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJDatePickView : UIView
@property (nonatomic, copy)void (^TJDatePickView)(NSString * startTime, NSString *endTime);
- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;
@end
