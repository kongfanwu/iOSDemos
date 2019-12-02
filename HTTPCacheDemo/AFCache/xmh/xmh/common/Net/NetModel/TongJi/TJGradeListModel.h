//
//  TJGradeListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJGradeModel;
@interface TJGradeListModel : NSObject
@property (nonatomic, strong)NSArray <TJGradeModel *>*list;
@end
@interface TJGradeModel : NSObject
@property (nonatomic, copy)NSString *key;
@property (nonatomic, copy)NSString *name;
@end
