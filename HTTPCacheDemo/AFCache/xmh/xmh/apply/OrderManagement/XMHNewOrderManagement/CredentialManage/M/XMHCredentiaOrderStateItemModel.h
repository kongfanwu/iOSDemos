//
//  XMHCredentiaOrderStateItemModel.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 订单状态model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaOrderStateItemModel : NSObject
/** <##> */
@property (nonatomic, copy) NSString *title;
/** 用途1 与服务端状态对应
    用途2 XMHOrderFunctionType 也是此类型
 */
@property (nonatomic) NSInteger tag;
/** 是否选中 */
@property (nonatomic) BOOL selcet;
/** 数量 */
@property (nonatomic, copy) NSString *badge;

+ (XMHCredentiaOrderStateItemModel *)createTitle:(NSString *)title tag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
