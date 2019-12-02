//
//  MzzSelectModel.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/11/23.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MzzSelectModel,MzzselsectListModel;
@interface MzzSelectModel : NSObject

@property (nonatomic, strong) NSArray<MzzselsectListModel *> *list;

@end

@interface MzzselsectListModel : NSObject
@property (nonatomic, strong) NSString *content;//顾客画像标签


@end
