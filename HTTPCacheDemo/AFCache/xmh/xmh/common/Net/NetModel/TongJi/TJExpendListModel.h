//
//  TJExpendListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJExpendModel;
@interface TJExpendListModel : NSObject
@property (nonatomic, strong)NSArray <TJExpendModel *>*next;
@end

@interface TJExpendModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *fram_id;
@property (nonatomic, copy)NSString *main_role;
@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *zongfuzhai;
@property (nonatomic, copy)NSString *guihuaxiaohao;
@property (nonatomic, copy)NSString *liaochengkafuzhaijine;
@property (nonatomic, copy)NSString *liaochengkafuzhaicishu;
@property (nonatomic, copy)NSString *chuzhikafuzhaijine;
@property (nonatomic, copy)NSString *chuzhikafuzhaizhangshu;
@property (nonatomic, copy)NSString *xiaohaojine;
@property (nonatomic, copy)NSString *bfb;
@property (nonatomic, copy)NSString *type;
@end
