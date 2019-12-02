//
//  SAStoredCardListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SAStoredCardModel;
@interface SAStoredCardListModel : NSObject
@property (nonatomic, strong)NSArray <SAStoredCardModel *> * stored_card;
@end
@interface SAStoredCardModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * stored_code;
@end
