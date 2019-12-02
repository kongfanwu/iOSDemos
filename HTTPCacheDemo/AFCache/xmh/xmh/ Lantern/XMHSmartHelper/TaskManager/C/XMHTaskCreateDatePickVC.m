//
//  XMHTaskCreateDatePickVC.m
//  xmh
//
//  Created by ald_ios on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTaskCreateDatePickVC.h"
#import "XMHPickerView.h"
#import "NSDate+Extension.h"
#import "NSDate+Extension.h"

@interface XMHTaskCreateDatePickVC ()
@property (nonatomic, assign) BOOL isToday;
@end

@implementation XMHTaskCreateDatePickVC

@synthesize rowDescriptor = _rowDescriptor;

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;// [UIColor colorWithWhite:0.f alpha:0.5];
    
    // 自定义使用方式
     NSMutableArray *hourArray = NSMutableArray.new;
     XMHItemModel *model;
    for (int i = 0; i < 24; i++) {
        model = XMHItemModel.new;
        model.title = [NSString stringWithFormat:@"%02d",i];
        [hourArray addObject:model];
    }
    
    NSMutableArray *minArray = NSMutableArray.new;
    XMHItemModel *model1;
    for (int i = 0; i < 60; i++) {
        model1 = XMHItemModel.new;
        model1.title = [NSString stringWithFormat:@"%02d",i];
        [minArray addObject:model1];
    }
     
    XMHPickerView *pickerView = [[XMHPickerView alloc] init];
    pickerView.dataArray = (NSMutableArray *)@[hourArray,minArray];
    pickerView.type = PickerViewTypeCustom;
    NSDate * date = [[NSDate alloc] init];
    NSInteger hour = date.hour;
    NSInteger minute = date.minute;
    pickerView.selectComponent = hour;
    pickerView.selectSecRow = minute;
    pickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:pickerView];
    __weak typeof(self) _self = self;
    [pickerView setTimesSureBlock:^(NSString * _Nonnull time) {
        __strong typeof(_self) self = _self;
        [time stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        [time stringByReplacingOccurrencesOfString:@"-" withString:@":"];
        if (![self filterTime:time]){
            [XMHProgressHUD showOnlyText:@"此时间已不能选择,请重新选择"];
            return ;
        }
//        id row = self.rowDescriptor;
        self.rowDescriptor.value = time; // 01:02
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [pickerView setDismissBlock:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];

}

- (BOOL)filterTime:(NSString *)time
{
    NSArray * timeArr = [time componentsSeparatedByString:@","];
    if (timeArr.count ==2) {
        NSInteger hour = [timeArr[0] integerValue];
        NSInteger min = [timeArr[1] integerValue];
        NSDate * date = [[NSDate alloc] init];
        NSInteger currenthour = date.hour;
        NSInteger currentminute = date.minute;
        if (hour < currenthour) {
            return NO;
        }else if(hour == currenthour){
            if (min < currentminute) {
                return NO;
            }
        }
    }
    return YES;
}
#pragma mark - XMHFormTaskNextVCProtocol

/**
 配置参数
 */
- (void)configParams:(NSDictionary *)params
{
    NSDate *date = params[@"date"];
    _isToday = [date isToday];
}

@end
