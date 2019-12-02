//
//  FWDDetailViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWDDetailViewController : UIViewController
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, copy)NSString * comeFrom;
/** pop 回调，如果实现此block 原pop会被取消 */
@property (nonatomic, copy) void (^popViewControllerBlock)(FWDDetailViewController *vc);
@end
