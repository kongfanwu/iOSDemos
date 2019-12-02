//
//  MzzFilterTbSectionHeaderViewTextfiled.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzFilterTbSectionHeaderViewTextfiled : UIView

@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (copy, nonatomic) void (^MzzFilterTbSectionHeaderViewTextfiledBlock)(NSString * title,NSString *start,NSString *end);
@end
