//
//  XMHHostUrlManager.m
//  xmh
//
//  Created by ald_ios on 2019/7/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHHostUrlManager.h"

@implementation XMHHostUrlManager
+ (NSString *)urlWithModuleType:(XMHModuleType)moduleType subUrl:(NSString *)subUrl{
    NSString * hostUrl = @"";
    switch (moduleType) {
        case XMHModuleTypeCount:
            hostUrl = [NSString stringWithFormat:@"%@%@",SERVER_COUNT,subUrl];
            break;
        case XMHModuleTypeReport:
            hostUrl = [NSString stringWithFormat:@"%@%@",SERVER_REPORT,subUrl];
            break;
        case XMHModuleTypeReportNew:
            hostUrl = [NSString stringWithFormat:@"%@%@",SERVER_COUNT,subUrl]; // http://b.api.shendengmeiye.com/statistics.php/performance/getList.html
            break;
        case XMHModuleTypeDefault:
            hostUrl = [NSString stringWithFormat:@"%@%@",SERVER_APP,subUrl];
            break;
        default:
            break;
    }
    return hostUrl;
}
+ (NSString *)url:(NSString *)subUrl
{
   return [self urlWithModuleType:XMHModuleTypeDefault subUrl:subUrl];
}
@end
