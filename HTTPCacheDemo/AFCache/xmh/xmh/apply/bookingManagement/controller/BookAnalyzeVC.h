//
//  BookAnalyzeVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  预约分析

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,BookAnalyzePageType)
{
    BookAnalyzePageTypeStaff,               /** 员工 */
    BookAnalyzePageTypeDJL,                 /** 店经理 */
    BookAnalyzePageTypeDZ,                  /** 店长 */
    BookAnalyzePageTypeManagement           /** 管理层 */
};
@interface BookAnalyzeVC : BaseViewController1
@property (nonatomic, assign) BookAnalyzePageType pageType;
@property (nonatomic, copy)NSString * framID;
@property (nonatomic, copy)NSString * INID;
//@property (nonatomic, assign) BookAnalyzePageType ptype;
@end

NS_ASSUME_NONNULL_END
