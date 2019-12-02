//
//  MzzTags.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzTagDatas,MzzSectionTags,MzzTag;

@interface MzzTagDatas : NSObject

@property (nonatomic, strong) NSMutableArray<MzzSectionTags *> *list;

@end

@interface MzzSectionTags : NSObject

@property (nonatomic, assign) NSInteger is_sys;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSMutableArray<MzzTag *> *content_list;//顾客画像标签数组
@property (nonatomic, strong) NSMutableArray<MzzTag *> *not_remove_content_list;
@property (nonatomic, strong) NSMutableArray<MzzTag *> *pro;//生成销售计划数组
@property (nonatomic, copy) NSString *join_code;
@property (nonatomic, assign) NSInteger  user_id;
@property (nonatomic, copy) NSString *rate;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *select;

@property (nonatomic, assign) BOOL isNewCreat;
@property (nonatomic, assign) BOOL isRemove;
@end

@interface MzzTag : NSObject

@property (nonatomic, assign) NSInteger content_is_sys;

@property (nonatomic, assign) NSInteger content_id;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger is_select;
@property (nonatomic, assign) NSInteger is_edit;
@property (nonatomic, assign) NSInteger is_remove;
@property (nonatomic, assign) BOOL isNewCreat;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *type;


@end


