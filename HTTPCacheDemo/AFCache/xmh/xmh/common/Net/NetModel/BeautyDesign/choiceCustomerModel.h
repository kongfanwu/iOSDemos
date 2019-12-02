//
//  choiceCustomerModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface choiceCustomerModel : NSObject
@property(nonatomic, assign)long max_page;
@property(nonatomic, copy)NSString *rows;
@property(nonatomic, assign)long total;
@property(nonatomic, strong)NSMutableArray *list;

@end
