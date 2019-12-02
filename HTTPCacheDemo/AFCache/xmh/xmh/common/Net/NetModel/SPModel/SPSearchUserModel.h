//
//  SPSearchUserModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPUserModel;

@interface SPSearchUserModel : NSObject

@property (nonatomic, strong) NSArray<SPUserModel *> *list;

@end

@interface SPUserModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fram_id;
@property (nonatomic, copy) NSString *user_store_id;

@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, assign) BOOL isSelected;



@end


