//
//  LanternMProSectionHeaderView.m
//  xmh
//
//  Created by ald_ios on 2019/3/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMProSectionHeaderView.h"

@interface LanternMProSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end
@implementation LanternMProSectionHeaderView
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _lb.text = param[@"name"]?param[@"name"]:@"";
}
@end
