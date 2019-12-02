//
//  XMHHostUrlManager.h
//  xmh
//
//  Created by ald_ios on 2019/7/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMHModuleType) {
    XMHModuleTypeDefault,/**  */
    XMHModuleTypeReport, /** 旧报表 */
    XMHModuleTypeReportNew, /** 新报表 */
    XMHModuleTypeCount, /** 统计 */
};
@interface XMHHostUrlManager : NSObject
+ (NSString *)urlWithModuleType:(XMHModuleType)moduleType subUrl:(NSString *)subUrl;
+ (NSString *)url:(NSString *)subUrl;
@end

NS_ASSUME_NONNULL_END
