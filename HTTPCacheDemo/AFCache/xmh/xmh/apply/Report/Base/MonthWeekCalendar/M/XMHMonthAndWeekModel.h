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
@property (nonatomic, copy) NSString *ID;
/** 开始、结束时间 */
@property (nonatomic, strong) NSDate *firstDate, *lastDate;
/** <##> */
@property (nonatomic, copy) NSString *title, *subTitle;
/** <##> */
@property (nonatomic) BOOL select;
/** 第几周 默认 1*/
@property (nonatomic) NSUInteger weekNum;
/** 第几月 默认 1*/
@property (nonatomic) NSUInteger monthNum;
/** 当前num */
@property (nonatomic) NSUInteger currentNum;
/** 是否能点击 默认：YES*/
@property (nonatomic) BOOL enable;
/** 是否是当前周或月 */
@property (nonatomic) BOOL isCurrentDate;

+ (NSNumberFormatter *)sharedformatter;
/** nsin */
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
