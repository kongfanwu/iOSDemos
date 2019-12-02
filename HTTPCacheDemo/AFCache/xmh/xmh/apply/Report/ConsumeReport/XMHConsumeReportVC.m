//
//  XMHConsumeReportVC.m
//  xmh
//
//  Created by ald_ios on 2019/7/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHConsumeReportVC.h"
#import "XMHEarningSourceVC.h"

@interface XMHConsumeReportVC ()

@end

@implementation XMHConsumeReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reportType = XMHBaseReportVCTypeXiaoHao;
    [self loadWebViewUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kREPORT_CONSUME_H5]]];
//    [self loadWebViewReportUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kREPORT_CONSUME_H5]]];
    
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
                               @{@"title":@"消耗业绩",@"id":@"yeji"},
                               @{@"title":@"服务客次",@"id":@"keci"},
                               @{@"title":@"消耗项目数",@"id":@"xiangmushu"},
                               @{@"title":@"客单价",@"id":@"kedanjia"}
                               ];
    for (NSDictionary * dict in filterData) {
        XMHItemModel *model = XMHItemModel.new;
        model.title = dict[@"title"];
        model.idStr = dict[@"id"];
        [dataArray addObject:model];
    }
    
    self.pickerView.dataArray = (NSMutableArray *)@[dataArray];
    
    /** 业绩来源 */
     if ([message.name isEqualToString:XMHReportH5MethodName_ResultsSource]){ 
        XMHEarningSourceVC * sourceVC = [[XMHEarningSourceVC alloc]initWithDateArr:self.selectedTimestampTs  timeType:[self typeenumToStringtype] reportType:XMHBaseReportVCTypeXiaoHao];
         NSString * framID = [NSString stringWithFormat:@"%@",message.body];
         sourceVC.framID = framID;
        [self.navigationController pushViewController:sourceVC animated:NO];
    }

}

@end
