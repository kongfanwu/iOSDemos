//
//  MzzPortraitModel.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MzzPortraitModell,MzzPortraitListModel;

@interface MzzPortraitModel : NSObject
@property (nonatomic, strong) NSArray<MzzPortraitModell *> *list;

@end

@interface MzzPortraitModell : NSObject

@property (nonatomic, strong) NSString *parts_name;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSArray<MzzPortraitListModel *> *content_list;


@end
@interface MzzPortraitListModel : NSObject
@property (nonatomic, assign) int is_select;
@property (nonatomic, strong)NSString * index_name;
@property (nonatomic, strong)NSString * reference_value_min;
@property (nonatomic, strong)NSString * reference_value_max;
@property (nonatomic, strong)NSString * suggest;
@property (nonatomic, assign)NSInteger index_id;
@property (nonatomic, strong)NSString * number;

@end
