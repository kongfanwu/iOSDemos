//
//  XFYDtbSectionHeaderModel.h
//  xmh
//
//  Created by ald_ios on 2018/10/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFYDtbSectionHeaderModel : NSObject
@property (nonatomic, copy)NSString * leftName;
@property (nonatomic, copy)NSString * middleName;
@property (nonatomic, copy)NSString * rightName;
+ (instancetype)createModelLeftName:(NSString *)leftName middleName:(NSString *)middleName rightName:(NSString *)rightName;
@end
