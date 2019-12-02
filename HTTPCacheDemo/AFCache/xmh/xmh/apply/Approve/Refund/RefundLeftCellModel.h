//
//  RefundLeftCellModel.h
//  xmh
//
//  Created by ald_ios on 2018/11/9.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundLeftCellModel : NSObject
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, assign)BOOL selected;
+ (instancetype)createModelTitle:(NSString *)title type:(NSString *)type;
+ (instancetype)createModelTitle:(NSString *)title type:(NSString *)type selected:(BOOL)selected;
@end
