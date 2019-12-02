//
//  ZFUserListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZFUserModel;

@interface ZFUserListModel : NSObject

@property (nonatomic, assign) NSInteger type2;

@property (nonatomic, assign) NSInteger daifenpei;

@property (nonatomic, assign) NSInteger type1;

@property (nonatomic, strong) NSArray<ZFUserModel *> *list;

@property (nonatomic, assign) NSInteger quabnbu;

@property (nonatomic, assign) NSInteger type3;

@end

@interface ZFUserModel : NSObject

@property (nonatomic, assign) NSInteger del;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, copy) NSString *join_name;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, assign) NSInteger utype;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *mdname;

@end


