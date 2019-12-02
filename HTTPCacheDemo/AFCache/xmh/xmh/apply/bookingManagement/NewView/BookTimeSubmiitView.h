//
//  BookTimeSubmiitView.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTimeSubmiitView : UIView
@property (nonatomic, copy) void (^BookTimeSubmiitViewBlock)();
- (void)updateBookTimeSubmiitView:(NSString *)time;
@end
