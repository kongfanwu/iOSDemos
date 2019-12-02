//
//  BookJisTimeList.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class BookJisTime;
@interface BookJisTimeList : NSObject
/** 技师姓名 */
@property (nonatomic, copy)NSString * name;
/** 技师账号 */
@property (nonatomic, copy)NSString * account;
/** 技师头像 */
@property (nonatomic, copy)NSString * img;
/** 是否请假 */
@property (nonatomic, copy)NSString * is_leave;
/** 开店时间 */
@property (nonatomic, copy)NSString * open_time;
/** 关店时间 */
@property (nonatomic, copy)NSString * close_time;
@property (nonatomic, copy)NSArray <BookJisTime *>* calendar;
@end

@interface BookJisTime : NSObject
/** 时间 */
@property (nonatomic, copy)NSString * time;
/** 状态 */
@property (nonatomic, assign)NSString * state;
/** 是否选中 */
@property (nonatomic, assign)BOOL isSelect;
@end
