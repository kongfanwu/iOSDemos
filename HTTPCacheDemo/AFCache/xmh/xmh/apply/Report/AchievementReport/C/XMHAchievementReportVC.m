//
//  XMHPerformanceReportVC.m
//  xmh
//
//  Created by kfw on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAchievementReportVC.h"
#import "XMHZeroVC.h"
#import "XMHEarningSourceVC.h"
/** 筛选 */
NSString *const XMHReportH5MethodName_ZeroSrore = @"ZeroSrore";
/** 排行 */
NSString *const XMHReportH5MethodName_ZeroStaff = @"ZeroStaff";

@interface XMHAchievementReportVC ()

@end

@implementation XMHAchievementReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reportType = XMHBaseReportVCTypeYeJi;
    [self loadWebViewUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kREPORT_YEJI_H5]]];
//    [self loadWebViewReportUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kREPORT_YEJI_H5]]];
}

#pragma mark - 重写父类
/**
 注册js调用OC方法。
 */
- (void)addScriptMessage {
    [super addScriptMessage];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_ZeroSrore];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:XMHReportH5MethodName_ZeroStaff];
}

/**
 移除注册的方法
 */
- (void)removeScriptMessage {
    [super removeScriptMessage];
    // 需要注意的是addScriptMessageHandler很容易引起循环引用.因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_ZeroSrore];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:XMHReportH5MethodName_ZeroStaff];
}

#pragma mark - WKScriptMessageHandler

/**
 js调用OC代理方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    MzzLog(@"%@() %@", message.name, message.body);
    [super userContentController:userContentController didReceiveScriptMessage:message];
    NSMutableArray *dataArray = NSMutableArray.new;
    NSArray * filterData =   @[
                               @{@"title":@"销售业绩",@"id":@"sale"},
                               @{@"title":@"客单产",@"id":@"user_danchan"},
                               @{@"title":@"有效顾客",@"id":@"valid_user_id"}
                               ];
    for (NSDictionary * dict in filterData) {
        XMHItemModel *model = XMHItemModel.new;
        model.title = dict[@"title"];
        model.idStr = dict[@"id"];
        [dataArray addObject:model];
    }
    
    self.pickerView.dataArray = (NSMutableArray *)@[dataArray];
    XMHZeroVC * nextVC = nil;
    
    /** 挂零门店 */
    if ([message.name isEqualToString:XMHReportH5MethodName_ZeroSrore]) {
        nextVC = [[XMHZeroVC alloc] initWithDateArr:self.selectedTimestampTs timeType:[self typeenumToStringtype] zeroType:XMHZeroTypeStore];
    }
    /** 挂零员工 */
    else if ([message.name isEqualToString:XMHReportH5MethodName_ZeroStaff]){
        nextVC = [[XMHZeroVC alloc] initWithDateArr:self.selectedTimestampTs timeType:[self typeenumToStringtype] zeroType:XMHZeroTypeEmployee];
    }
    [self.navigationController pushViewController:nextVC animated:NO];
    
    /** 业绩来源 */
    if ([message.name isEqualToString:XMHReportH5MethodName_ResultsSource]){
        XMHEarningSourceVC * sourceVC = [[XMHEarningSourceVC alloc]initWithDateArr:self.selectedTimestampTs  timeType:[self typeenumToStringtype] reportType:XMHBaseReportVCTypeYeJi];
        
        NSString * framID = [NSString stringWithFormat:@"%@",message.body];
        sourceVC.framID = framID;
        [self.navigationController pushViewController:sourceVC animated:NO];
    }
}

@end
