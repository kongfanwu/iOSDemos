//
//  LGuKeStateHeaderView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/18.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LGuKeStateHeaderView.h"

@implementation LGuKeStateHeaderView

- (void)setModel:(LolGuKeStateModelList *)model
{
    _lbName.text = model.user_name;
    NSString * stateStr = nil;
    if ([model.icon isEqualToString:@"2"]) {
        stateStr = @"达标";
    }else if ([model.icon isEqualToString:@"3"]){
        stateStr = @"不达标";
    }else{
        stateStr = @"未知";
    }
    _lbState.text = stateStr;
}
@end
