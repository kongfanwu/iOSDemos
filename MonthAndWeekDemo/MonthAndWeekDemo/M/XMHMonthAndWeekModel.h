//
//  XMHMonthAndWeekModel.h
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/2.
//  Copyright © 2019 kfw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHMonthAndWeekModel : NSObject
/** <##> */
@property (nonatomic, strong) NSDate *firstDate, *lastDate;
/** <##> */
@property (nonatomic, copy) NSString *title, *subTitle;
/** <##> */
@property (nonatomic) BOOL select;

+ (NSNumberFormatter *)sharedformatter;
@end

NS_ASSUME_NONNULL_END
