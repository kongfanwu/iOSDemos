//
//  MineInfoLocalModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineInfoLocalModel : NSObject
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * content;
@property (nonatomic, assign)BOOL isShow;
+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content isShow:(BOOL)isShow;
@end
