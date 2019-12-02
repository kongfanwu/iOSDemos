//
//  TJCashListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJCashModel;
@interface TJCashListModel : NSObject
@property (nonatomic, strong)NSArray <TJCashModel *>*next;
@end

@interface TJCashModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *fram_id;
@property (nonatomic, copy)NSString *main_role;
@property (nonatomic, copy)NSString *jihejine;
@property (nonatomic, copy)NSString *huikuanjine;
@property (nonatomic, copy)NSString *qiankuanjine;
@property (nonatomic, copy)NSString *xianshangjine;
@property (nonatomic, copy)NSString *xianxiajine;
@property (nonatomic, copy)NSString *tuikuanjine;
@property (nonatomic, copy)NSString *type;
@end
