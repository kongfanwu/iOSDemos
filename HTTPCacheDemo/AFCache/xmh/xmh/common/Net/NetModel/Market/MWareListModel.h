//
//  MWareListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/30.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MWareModel;
@interface MWareListModel : NSObject
@property (nonatomic, strong)NSArray<MWareModel *> * list;
@end

@interface MWareModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * code;
@end
