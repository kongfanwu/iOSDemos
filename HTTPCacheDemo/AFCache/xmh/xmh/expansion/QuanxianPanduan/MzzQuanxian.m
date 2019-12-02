//
//  MzzQuanxian.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzQuanxian.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"

@implementation MzzQuanxian
+(BOOL)quanxianContains:(NSArray *)quanxian{
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    Join_Code *join_code = infomodel.data.join_code[0];
    for (int i = 0; i<quanxian.count; i++) {
        NSString *str = [quanxian objectAtIndex:i];
        if ([join_code.framework_function_role containsObject:str]) {
            return YES;
        }
    }
    return NO;
}
@end
