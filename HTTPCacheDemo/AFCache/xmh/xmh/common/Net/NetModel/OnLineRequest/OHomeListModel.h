//
//  OHomeListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OHomeModel;
@interface OHomeListModel : NSObject
@property (nonatomic, strong)NSArray <OHomeModel *>* list;
@property (nonatomic, assign)NSInteger type;
@end

@interface OHomeModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * deal;
@property (nonatomic, copy)NSString * add;
@property (nonatomic, copy)NSString * count;
@property (nonatomic, copy)NSString * num;
@property (nonatomic, copy)NSString * ratio;
@property (nonatomic, copy)NSString * amount;
@end
