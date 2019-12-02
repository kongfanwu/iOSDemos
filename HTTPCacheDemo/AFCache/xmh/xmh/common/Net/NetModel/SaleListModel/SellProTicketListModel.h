//
//  SellProTicketListModel.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/29.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SellProTicketModel;

@interface SellProTicketListModel : NSObject
@property (nonatomic, strong)NSArray <SellProTicketModel *>* list;

@end

@interface SellProTicketModel : NSObject

@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * money;
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString * start_time;
@property (nonatomic, copy)NSString * end_time;
@property (nonatomic,assign)int type;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, copy)NSString * fulfill;


@property (nonatomic, assign) BOOL selected;
@end
