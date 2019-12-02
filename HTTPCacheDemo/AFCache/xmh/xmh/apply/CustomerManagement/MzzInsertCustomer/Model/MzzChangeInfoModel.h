//
//  MzzChangeInfoModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzApprovalpersonNew;

@interface MzzChangeInfoModel : NSObject

@property (nonatomic, strong) NSArray<MzzApprovalpersonNew *> *approvalPerson;

@property (nonatomic, copy) NSString *code;

@end

@interface MzzApprovalpersonNew : NSObject

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *frame_name;

@property (nonatomic, copy) NSString *name;

@end


