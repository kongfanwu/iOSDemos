//
//  SPGetTdPersonModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPPersonModel;

@interface SPGetTdPersonModel : NSObject

@property (nonatomic, strong) NSArray<SPPersonModel *> *approvalPerson;

@property (nonatomic, strong) NSArray<SPPersonModel *> *duplicatePerson;

@end

@interface SPPersonModel : NSObject

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *frame_name;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign)BOOL isSelect;

@end




