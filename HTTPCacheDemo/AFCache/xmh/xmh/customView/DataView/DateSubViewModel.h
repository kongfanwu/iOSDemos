//
//  DateSubViewModel.h
//  xmh
//
//  Created by ald_ios on 2018/10/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateSubViewModel : NSObject
@property (nonatomic, copy)NSString * iconName;
@property (nonatomic, copy)NSString * textName;
@property (nonatomic, copy)NSString * textValue;
@property (nonatomic, assign)BOOL isShow;
+ (instancetype)createModelIconName:(NSString *)iconName textName:(NSString *)textName textValue:(NSString *)textValue isShow:(BOOL)isShow;
@end
