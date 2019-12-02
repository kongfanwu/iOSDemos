//
//  XMHBillRecViewModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMHBillReProModel;
@class XMHBillReGoodsModel;
@class XMHBillReCardModel;
@class XMHBillReTimeModel;
@class XMHBillReNumCardModel;
@class XMHBillReTicketModel;

NS_ASSUME_NONNULL_BEGIN
typedef void(^ListsBlock)(NSMutableArray *listArr, BOOL isSuccess);

@interface XMHBillRecSever : NSObject

@property (nonatomic, copy)ListsBlock listsBlock;

- (instancetype)initUserId:(NSString *)userId type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
