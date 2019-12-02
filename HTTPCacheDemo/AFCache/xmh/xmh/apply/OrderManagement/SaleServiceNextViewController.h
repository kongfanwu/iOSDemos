//
//  SaleServiceNextViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"

@interface SaleServiceNextViewController : UIViewController
@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, strong) NSMutableDictionary *commitDic;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *top;
@property (weak, nonatomic) IBOutlet UITableView *jsTb;
@property (nonatomic,assign)NSInteger billType;
@end
