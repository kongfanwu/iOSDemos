//
//  MzzTagViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MzzTagViewController;
@protocol MzzTagViewControllerDelegate<NSObject>
- (void)tagViewController:(MzzTagViewController *)tagViewController andTagInfo:(NSDictionary *)infoDic;
@end
@interface MzzTagViewController : UIViewController
@property (nonatomic ,copy)NSString *user_id;
@property (nonatomic ,weak)id <MzzTagViewControllerDelegate> delegate;
@end
