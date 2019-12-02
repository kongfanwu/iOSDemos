//
//  XMHSalesOrderContentVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHOrderContentSearchView;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSalesOrderContentVC : UIViewController
@property (nonatomic, copy) NSString *storeCode;// 门店编码
/** 搜索 */
@property (nonatomic, strong) XMHOrderContentSearchView *searchView;

/** 搜索数据源 searchResultArray 搜索后集合*/
@property (nonatomic, strong) NSArray *searchDataArray, *searchResultArray;
/** 是否搜索状态 */
@property (nonatomic) BOOL isSearch;

/** 开始搜索 */
@property (nonatomic, copy) void (^startSearchBlock)();
/** 结束搜索 */
@property (nonatomic, copy) void (^endSearchBlock)();


/**
 初始化

 @param userId 用户id
 @param type 类型
 @param name 项目名
 @return init
 */
- (instancetype)initUserId:(NSString *)userId type:(NSString *)type name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
