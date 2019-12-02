//
//  LApproveModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LApproveModel : NSObject
@property (copy, nonatomic)NSString * title;
@property (copy, nonatomic)NSString * imgName;
@property (copy, nonatomic)NSString * num;
+ (instancetype)modelTitle:(NSString *)title imgName:(NSString *)imgName;
@end
