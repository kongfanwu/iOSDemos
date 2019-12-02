//
//  CustomerGradeListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomerGradeModel,CustomerSubGradeModel;
@interface CustomerGradeListModel : NSObject
@property (nonatomic, strong)NSArray <CustomerGradeModel *>*next;
@end
@interface CustomerGradeModel : NSObject
@property (nonatomic, copy)NSString *total;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *fram_id;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *main_role;
@property (nonatomic, strong)NSArray <CustomerSubGradeModel *>*list;
@end
@interface CustomerSubGradeModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *key;
@end
