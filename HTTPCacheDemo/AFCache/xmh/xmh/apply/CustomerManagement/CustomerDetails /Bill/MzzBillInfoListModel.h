//
//  MzzBillInfoListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzBillInfoModel;

@interface MzzBillInfoListModel : NSObject

@property (nonatomic, strong) NSArray<MzzBillInfoModel *> *list;

@end

@interface MzzBillInfoModel : NSObject

@property (nonatomic, assign) NSInteger rec_id;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger operation;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *current;

@property (nonatomic, copy) NSString *ly_id;

@property (nonatomic, copy) NSString *ly_name;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *ly_type;

@property (nonatomic, assign) NSInteger alter_num;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *ordernum;
@property (nonatomic, copy) NSString *frozen;
@end


