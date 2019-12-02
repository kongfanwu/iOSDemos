//
//  LanternRecommedListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LanternRecommedModel;
@interface LanternRecommedListModel : NSObject
@property (nonatomic, strong)NSArray <LanternRecommedModel *>*list;
@property (nonatomic, copy)NSString *thisConsume;
@property (nonatomic, copy)NSString *thisExpend;
@property (nonatomic, copy)NSString *nextConsume;
@property (nonatomic, copy)NSString *nextExpend;
@end
@interface LanternRecommedModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *grade;
@property (nonatomic, copy)NSString *consumeAttr;
@property (nonatomic, copy)NSString *consumeReco;
@property (nonatomic, copy)NSString *consumeRate;
@property (nonatomic, copy)NSString *expendAttr;
@property (nonatomic, copy)NSString *expendReco;
@property (nonatomic, copy)NSString *expendRate;
@property (nonatomic, copy)NSString *join_code;
@property (nonatomic, copy)NSString *user_id;
@end
