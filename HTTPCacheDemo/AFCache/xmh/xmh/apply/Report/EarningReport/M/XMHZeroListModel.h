//
//  XMHZeroListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHZeroModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHZeroListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHZeroModel *> *list;
@end

@interface XMHZeroModel : NSObject
/** 技师的account */
@property (nonatomic, copy) NSString *account;
/** 技师名称/门店名称 */
@property (nonatomic, copy) NSString *name;
/** 商家code */
@property (nonatomic, copy) NSString *join_code;
/** 技师归属的门店code */
@property (nonatomic, copy) NSString *store_code;
/** 技师归属的门店名称 */
@property (nonatomic, copy) NSString *store_name;

@end

NS_ASSUME_NONNULL_END
