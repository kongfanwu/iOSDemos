//
//  LClearCardCell2.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 98

#import <UIKit/UIKit.h>

@interface LClearCardCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UITextView *tf1;
@property (copy, nonatomic) void (^LClearCardCell2Block)(NSString *cause);
@end
