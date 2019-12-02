//
//  MzzPujiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PujiCard;

@interface PujiModel : NSObject

@property (nonatomic, strong) NSArray<PujiCard *> *card_time;

@property (nonatomic, strong) NSArray<PujiCard *> *card_exper;

@property (nonatomic, strong) NSArray<PujiCard *> *stored_card;

@property (nonatomic, strong) NSArray<PujiCard *> *card_num;

@property (nonatomic, strong) NSArray<PujiCard *> *card_course;

@property (nonatomic, strong) NSMutableArray<PujiCard *> *goods;

@property (nonatomic, strong) NSMutableArray<PujiCard *> *pro;
@end

@interface PujiCard : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger is_have;

@end




