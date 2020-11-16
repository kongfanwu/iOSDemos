//
//  XMHViewModelProtocol.h
//  xmh
//
//  Created by kfw on 2020/11/13.
//  Copyright © 2020 享美会-技术研发中心-ios dev. All rights reserved.
// ViewModel 基类协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XMHViewModelProtocol <NSObject>
@optional
/// 页数
@property (nonatomic) NSInteger page;
/// 请求数据信号
@property (nonatomic, strong) RACCommand *getDataCommand;
/// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

/// 获取下拉数据
- (void)getData;

/// 获取更多数据
- (void)getMoreData;

/// 具体请求数据方法
/// @param complete 结果回调block
- (void)getDataComplete:(void(^)(BOOL success, id modelArray))complete;
@end

NS_ASSUME_NONNULL_END
