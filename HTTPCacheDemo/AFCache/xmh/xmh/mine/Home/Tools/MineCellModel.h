//
//  MineCellModel.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/4/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCellModel : NSObject

@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * iconStr;
@property (nonatomic, strong) Class vcClass;
@property (nonatomic, copy) NSString * className;
/** 角标 */
@property (nonatomic, assign)NSInteger  num;
+ (instancetype)createModelWithTitle:(NSString *)title icon:(NSString *)iconStr;
+ (instancetype)createModelWithTitle:(NSString *)title icon:(NSString *)iconStr class:(Class)class;
+ (instancetype)createModelWithTitle:(NSString *)title icon:(NSString *)iconStr className:(NSString *)className;
@end
