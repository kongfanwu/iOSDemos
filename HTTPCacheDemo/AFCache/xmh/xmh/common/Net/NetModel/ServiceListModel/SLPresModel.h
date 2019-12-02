//
//  SLPresModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLPresListModel,Pro_List;

@interface SLPresModel : NSObject

@property (nonatomic, strong) NSArray<SLPresListModel *> *list;

@end

@interface SLPresListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) NSArray<Pro_List *> *pro_list;

@end

@interface Pro_List : NSObject

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger numDisplay;

@property (nonatomic, copy) NSString *pro_name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger num1;

@property (nonatomic, assign) NSInteger shichang;


@end


