//
//  TJGuKeTopModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJGuKeTopSubModel;
@interface TJGuKeTopModel : NSObject
@property (nonatomic, strong)NSArray <TJGuKeTopSubModel *>* list;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString * card_type;
@end
@interface TJGuKeTopSubModel : NSObject
@property (nonatomic, copy)NSString * val;
@property (nonatomic, copy)NSString * key;
@end
