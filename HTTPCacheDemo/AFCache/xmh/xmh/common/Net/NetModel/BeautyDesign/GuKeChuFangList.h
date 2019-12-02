//
//  GuKeChuFangList.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuKeChuFang.h"
@class GuKeChuFang;
@interface GuKeChuFangList : NSObject
@property(nonatomic, strong)NSMutableArray<GuKeChuFang *> *list;
@end
