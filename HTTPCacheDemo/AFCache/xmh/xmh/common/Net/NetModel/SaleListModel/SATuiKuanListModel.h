//
//  SATuiKuanListModel.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/4/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SATuiKuanModel;
@interface SATuiKuanListModel : NSObject
@property (nonatomic ,strong)NSArray <SATuiKuanModel *>* list;
@property (nonatomic, assign)NSInteger sales_num;
@property (nonatomic, assign)NSInteger sales_amount;
@end

@interface SATuiKuanModel : NSObject
@property (nonatomic, assign)NSInteger account_id;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * store_code;
@property (nonatomic, copy)NSString * create_time;
@property (nonatomic, assign)NSInteger ids;
@property (nonatomic, assign)NSInteger actual;
@property (nonatomic, copy)NSString * inper_name;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * user_mobile;
@property (nonatomic, copy)NSString * store_name;
@end
