//
//  ApproveBaseController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApproveBaseController : UIViewController
{
    UITableView * _tb;
    NSMutableArray * _dataSource;
    NSString * _joincode;
    NSString * _accountId;
    NSString * _token;
    NSString * _from;
}
//@property (nonatomic, strong)UITableView * tb;
//@property (nonatomic, strong)NSArray * dataSource;

@end
