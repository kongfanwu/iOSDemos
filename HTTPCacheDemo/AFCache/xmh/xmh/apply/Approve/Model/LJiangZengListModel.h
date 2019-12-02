//
//  LJiangZengListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJiangZengPersonModel;
@interface LJiangZengListModel : NSObject
@property (nonatomic, copy)NSString * code;
@property (nonatomic, strong)NSArray <LJiangZengPersonModel *>* approvalPerson;
@end

@interface LJiangZengPersonModel : NSObject
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * head_img;
@property (nonatomic, copy)NSString * frame_name;
@property (nonatomic ,assign)BOOL isSelect;
@end
