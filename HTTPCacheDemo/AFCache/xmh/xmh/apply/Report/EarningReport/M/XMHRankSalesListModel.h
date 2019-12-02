//
//  XMHRankSalesListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHRankSalesModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHRankSalesListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHRankSalesModel *> *list;
@end

@interface XMHRankSalesModel : NSObject
/** 普及人数 */
@property (nonatomic, copy) NSString *puji;
/** 项目名称 */
@property (nonatomic, copy) NSString *name;
/** 售卖人数 */
@property (nonatomic, copy) NSString *shoumai;
/** 销售业绩 */
@property (nonatomic, copy) NSString *xiaoshou;
/** 销售占比 */
@property (nonatomic, copy) NSString *bfb;
/** 排名 */
@property (nonatomic, copy) NSString *pai;

@end
NS_ASSUME_NONNULL_END
