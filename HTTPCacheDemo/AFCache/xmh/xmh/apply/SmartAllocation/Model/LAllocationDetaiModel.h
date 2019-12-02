//
//  LAllocationDetaiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LAllocationHeaderModel,LAllocationListModel;
@interface LAllocationDetaiModel : NSObject
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)NSMutableArray <LAllocationListModel *>* jis_list;
@property (nonatomic, strong)LAllocationHeaderModel * first;
@end

@interface LAllocationHeaderModel : NSObject
@property (nonatomic, copy)NSString * user_img;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * mdname;
@property (nonatomic, copy)NSString * store_code;
@property (nonatomic, assign) NSInteger ddcs;
@property (nonatomic, assign) NSInteger ddpc;
@property (nonatomic, assign) NSInteger xfje;
@property (nonatomic, assign) NSInteger xfxm;
@property (nonatomic, assign) NSInteger hkdj;
@property (nonatomic, assign) NSInteger account_id;
@property (nonatomic, copy)NSString * jis;
@property (nonatomic, copy)NSString * jis_cql;
@property (nonatomic, copy)NSString * jis_hkdj;
@property (nonatomic, copy)NSString * jis_xsyj;
@property (nonatomic, copy)NSString * jis_xhxm;
@property (nonatomic, copy)NSString * jis_ddpc;
@property (nonatomic, copy)NSString * jis_img;
@property (nonatomic, copy)NSString * jis_name;
@property (nonatomic, copy)NSString * jis_max;
@property (nonatomic, assign) NSInteger jis_min;
@end

@interface LAllocationListModel : NSObject
@property (nonatomic, assign) NSInteger account_id;
@property (nonatomic, copy)NSString * jis;
@property (nonatomic, copy)NSString * jis_cql;
@property (nonatomic, copy)NSString * jis_hkdj;
@property (nonatomic, copy)NSString * jis_xsyj;
@property (nonatomic, copy)NSString * jis_xhxm;
@property (nonatomic, copy)NSString * jis_ddpc;
@property (nonatomic, copy)NSString * jis_img;
@property (nonatomic, copy)NSString * jis_name;
@property (nonatomic, copy)NSString * jis_max;
@property (nonatomic, assign) NSInteger jis_min;
+ (instancetype)AllocationListModelAccountid:(NSInteger)accountid jis:(NSString *)jis jis_cql:(NSString *)jis_cql jis_hkdj:(NSString *)jis_hkdj jis_xsyj:(NSString *)jis_xsyj jis_xhxm:(NSString *)jis_xhxm jis_ddpc:(NSString *)jis_ddpc jis_img:(NSString *)jis_img jis_name:(NSString *)jis_name jis_max:(NSString *)jis_max jis_min:(NSInteger)jis_min;
@end
