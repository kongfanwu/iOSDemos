//
//  MStoreListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/30.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MStoreModel;
@interface MStoreListModel : NSObject
@property (nonatomic, strong)NSArray<MStoreModel *> * list;
@end

@interface MStoreModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * store_code;
@end
