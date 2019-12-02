//
//  ZhangDanMingXiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "ZhangDanMingXiSubModel.h"
@interface ZhangDanMingXiModel : NSObject
@property(nonatomic, copy)NSString *zfz;
@property(nonatomic, assign)CGFloat yjzxms;
@property(nonatomic, assign)CGFloat yjhkdj;
@property(nonatomic, assign)CGFloat yddpc;
@property(nonatomic, copy)NSString *min;
@property(nonatomic, assign)CGFloat sum;
@property(nonatomic, strong)NSMutableArray *list;
@end
