//
//  TJStoreListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJStoreModel;
@interface TJStoreListModel : NSObject
@property (nonatomic, strong)NSArray <TJStoreModel *>*list;
@end
@interface TJStoreModel : NSObject
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *name;
@end
