//
//  FTTBeautifultMakeModel.h
//  xmh
//
//  Created by KFW on 2019/8/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTTBeautifulMakeConstantModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTTBeautifultMakeModel : NSObject


/**
 门店消费
 */
@property (nonatomic, strong)  NSString *ly_type;


/**
 剩余次数
 */
@property (nonatomic, strong)  NSString *num;

/**
 包含  时长 和 美容名字的Model
 */
@property (nonatomic, strong)  FTTBeautifulMakeConstantModel *info;

@end

NS_ASSUME_NONNULL_END
