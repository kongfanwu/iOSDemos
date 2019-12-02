//
//  SALeftModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SALeftModel;
@interface SALeftModelList : NSObject
@property (nonatomic, strong)NSArray <SALeftModel*>*list;
@end
@interface SALeftModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * type;
@end
