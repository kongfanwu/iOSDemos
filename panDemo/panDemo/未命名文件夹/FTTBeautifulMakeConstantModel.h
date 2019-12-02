//
//  FTTBeautifulMakeConstantModel.h
//  xmh
//
//  Created by KFW on 2019/8/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface FTTBeautifulMakeConstantModel : NSObject <NSCopying,NSMutableCopying>
/**
 美容名字
 */
@property (nonatomic, strong)  NSString *name;

/**
 时长
 */
@property (nonatomic, strong)  NSString *shichang;

@end

NS_ASSUME_NONNULL_END
