//
//  MzzGuideModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzFugou,MzzStored_card,MzzGuiji,MzzGuanlian,MzzXiaohao;



@interface MzzGuideModel : NSObject

@property (nonatomic, strong) MzzFugou *fugou;

@property (nonatomic, strong) MzzGuiji *guiji;

@property (nonatomic, strong) MzzGuanlian *guanlian;

@property (nonatomic, strong) NSArray<MzzStored_card *> *stored_card;

@property (nonatomic, strong) NSArray<MzzXiaohao *> *xiaohao;

@end

@interface MzzFugou : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger bfb;

@end

@interface MzzGuiji : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger bfb;

@end

@interface MzzGuanlian : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger bfb;

@end

@interface MzzXiaohao : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) CGFloat ave;

@property (nonatomic, assign) CGFloat shiji;

@end

@interface MzzStored_card : NSObject

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString * denomination;

@property (nonatomic, copy) NSString * name;

@end

