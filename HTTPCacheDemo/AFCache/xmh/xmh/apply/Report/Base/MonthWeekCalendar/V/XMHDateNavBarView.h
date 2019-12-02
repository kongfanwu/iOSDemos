//
//  XMHDateNavBarView.h
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/2.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHDateNavBarView : UIView
/** <#type#> */
@property (nonatomic, copy) void (^changeYearBlock)(NSInteger tag);

- (void)setYear:(NSInteger)year;
@end

NS_ASSUME_NONNULL_END
