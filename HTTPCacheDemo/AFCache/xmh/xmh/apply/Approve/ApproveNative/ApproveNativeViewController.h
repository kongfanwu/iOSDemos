//
//  ApproveNativeViewController.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/21.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"
@interface ApproveNativeViewController : UIViewController
@property (nonatomic ,copy)NSString *store_code;
@property (nonatomic ,strong)NSDictionary *data;
@property (nonatomic ,copy) void (^BackBlock)();
@end
