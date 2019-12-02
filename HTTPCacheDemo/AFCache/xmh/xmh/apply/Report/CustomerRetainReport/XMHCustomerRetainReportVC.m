//
//  XMHCustomerRetainReportVC.m
//  xmh
//
//  Created by ald_ios on 2019/7/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCustomerRetainReportVC.h"

@interface XMHCustomerRetainReportVC ()

@end

@implementation XMHCustomerRetainReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reportType = XMHBaseReportVCTypeGuKeBaoYou;
    [self loadWebViewUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@tables/tablesbaoyou.html",SERVER_H5]]];
//    [self loadWebViewReportUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@tables/tablesbaoyou.html",SERVER_H5]]];
    
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
                               @{@"title":@"总顾客人数",@"id":@"total_user_cun"},
                               @{@"title":@"保有顾客",@"id":@"total_user_baoyou"},
                               @{@"title":@"承接顾客",@"id":@"total_user_chengjie"},
                               @{@"title":@"转化顾客",@"id":@"total_user_zhuanhua"},
                               @{@"title":@"流失顾客",@"id":@"total_user_liushi"},
                               @{@"title":@"挽回顾客",@"id":@"total_user_wanhui"},
                               ];
    for (NSDictionary * dict in filterData) {
        XMHItemModel *model = XMHItemModel.new;
        model.title = dict[@"title"];
        model.idStr = dict[@"id"];
        [dataArray addObject:model];
    }
    
    self.pickerView.dataArray = (NSMutableArray *)@[dataArray];
}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self removeScriptMessage];
//}
@end
