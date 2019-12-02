//
//  XMHFormSelectAlertTestVC.m
//  xmh
//
//  Created by kfw on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormSelectAlertTestVC.h"
#import "NSDate-Helper.h"

@interface XMHFormSelectAlertTestVC ()

@end

@implementation XMHFormSelectAlertTestVC

@synthesize rowDescriptor = _rowDescriptor;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSDate *date = NSDate.new;
    NSDate *newDate = [NSDate dateFromYear:(int)[date getYear] Month:(int)[date getMonth] Day:(int)[date getDay] hour:(int)[date getHour] + 1 minute:(int)[date getMinute] second:0];
    NSString *dateStr = [NSDate stringFromDate:newDate withFormat:@"HH:mm"];
    
    self.rowDescriptor.value = dateStr;
    [self dismissViewControllerAnimated:YES completion:nil];
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
