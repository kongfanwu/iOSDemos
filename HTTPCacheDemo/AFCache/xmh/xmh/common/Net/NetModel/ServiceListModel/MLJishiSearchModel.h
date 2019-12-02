//
//  MLJishiSearchModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSelectBaseModel.h"
@class MLJiShiModel;

@interface MLJishiSearchModel : NSObject

@property (nonatomic, strong) NSArray<MLJiShiModel *> *list;

@end

@interface MLJiShiModel : LSelectBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *store_name;

@property (nonatomic, assign) float bfb;

/**业绩划分 输入的价格 */
@property (nonatomic, copy) NSString *inputPrice;
@end


