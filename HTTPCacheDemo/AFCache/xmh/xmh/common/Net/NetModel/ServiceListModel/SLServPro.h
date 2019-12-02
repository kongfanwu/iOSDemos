//
//  SLServPro.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLProModel;

@interface SLServPro : NSObject

@property (nonatomic, strong) NSArray<SLProModel *> *list;

@end

@interface SLProModel : NSObject

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, copy) NSString *diff_code;

@property (nonatomic, copy) NSString *diffid;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger numDisplay;

@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger price;

@end


