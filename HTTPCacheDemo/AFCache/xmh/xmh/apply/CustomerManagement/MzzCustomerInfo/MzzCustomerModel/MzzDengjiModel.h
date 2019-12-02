//
//  MzzDengjiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MzzDengji;
@interface MzzDengjiModel : NSObject
@property (nonatomic, strong) NSMutableArray<MzzDengji *> *list;
@end

@interface MzzDengji : NSObject
@property (nonatomic, assign) NSInteger key;
@property (nonatomic, strong) NSString *name;
@property (nonatomic ,assign) BOOL isSelect;
@end
