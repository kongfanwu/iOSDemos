//
//  BookBillHomeSubVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookBillHomeSubVC : UIViewController
@property (nonatomic, assign)NSInteger tag;
@property (nonatomic, copy)NSString * userid;
@property (nonatomic, copy)void (^BookBillHomeSubVCBlock)(NSString * count);
@property (nonatomic, copy)void (^BookBillHomeSubVCCountBlock)(NSString * num1,NSString * num2,NSString * num3);
@end

NS_ASSUME_NONNULL_END
