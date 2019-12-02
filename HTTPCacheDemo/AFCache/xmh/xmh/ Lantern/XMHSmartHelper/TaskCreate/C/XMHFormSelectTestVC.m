//
//  XMHFormSelectTestVC.m
//  xmh
//
//  Created by kfw on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormSelectTestVC.h"

@interface XMHFormSelectTestVC ()

@end

@implementation XMHFormSelectTestVC


@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView setNavViewTitle:@"创建日常任务" backBtnShow:YES rightBtnTitle:@"确认"];
    WeakSelf
    self.navView.NavViewRightBlock = ^{
        [weakSelf submitClick];
    };
}

- (void)submitClick {
    NSMutableArray *array = NSMutableArray.new;
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"优惠券1"]];
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"2" displayText:@"优惠券2"]];
    [array addObject:[XLFormOptionsObject formOptionsObjectWithValue:@"3" displayText:@"优惠券3"]];
    
    self.rowDescriptor.value = array;
//    self.rowDescriptor.value = @(self.rowDescriptor.selectorOptions.count).stringValue;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - XMHFormTaskNextVCProtocol

/**
 配置参数
 */
- (void)configParams:(NSDictionary *)params {
    NSLog(@"%@", params);
}

@end
