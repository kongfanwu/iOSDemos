//
//  XMHEmployReportVC.m
//  xmh
//
//  Created by ald_ios on 2019/7/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHEmployReportVC.h"
#import "XMHEmployeeReportDetailVC.h"
@interface XMHEmployReportVC ()

@end

@implementation XMHEmployReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reportType = XMHBaseReportVCTypeYuanGong;
    [self loadWebViewUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kREPORT_STAFF_H5]]];
//    [self loadWebViewReportUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_H5,kREPORT_STAFF_H5]]];
    
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
                               @{@"title":@"销售业绩",@"id":@"xiaoshouyeji"},
                               @{@"title":@"消耗业绩",@"id":@"xiaohaoyeji"},
                               @{@"title":@"接待客次",@"id":@"jiedaikeci"},
                               @{@"title":@"成交人数",@"id":@"chengjiaorenshu"},
                               @{@"title":@"消耗项目数",@"id":@"xiaohaoxiangmushu"}
                               ];
    for (NSDictionary * dict in filterData) {
        XMHItemModel *model = XMHItemModel.new;
        model.title = dict[@"title"];
        model.idStr = dict[@"id"];
        [dataArray addObject:model];
    }
    
    self.pickerView.dataArray = (NSMutableArray *)@[dataArray];
    
    /** 详情 */
    if ([message.name isEqualToString:XMHReportH5MethodName_EmployeeDetails]){
        XMHEmployeeReportDetailVC * sourceVC = [[XMHEmployeeReportDetailVC alloc]initWithDateArr:self.selectedTimestampTs  timeType:[self typeenumToStringtype]];
        
        NSString * msg = [NSString stringWithFormat:@"%@",message.body];
        NSData *jsonData = [msg dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        TJCustomerModel * customer = [TJCustomerModel yy_modelWithJSON:[dic safeObjectForKey:@"list"]];
        customer.totalDict = [dic safeObjectForKey:@"info"];
        //waring: 由H5提供员工数据,组合到下一个界面使用:销售业绩、消耗业绩、接待客次。。
        sourceVC.customerModel = customer;
        [self.navigationController pushViewController:sourceVC animated:NO];
    }
}

@end
