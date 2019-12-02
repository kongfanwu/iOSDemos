//
//  CustomerRetainListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomerRetainModel;
@interface CustomerRetainListModel : NSObject
@property (nonatomic, strong)NSArray <CustomerRetainModel *>*next;
@end

@interface CustomerRetainModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *fram_id;
@property (nonatomic, copy)NSString *main_role;
@property (nonatomic, copy)NSString *biaozhun;
@property (nonatomic, copy)NSString *shangyue;
@property (nonatomic, copy)NSString *benyue;
@property (nonatomic, copy)NSString *xinzeng;
@property (nonatomic, copy)NSString *chengjie;
@property (nonatomic, copy)NSString *zhuanhua;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *liushi;
@property (nonatomic, copy)NSString *huodong;
@property (nonatomic, copy)NSString *youxiao;
@end
