//
//  XMHRankModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHRankModel : NSObject
/** 商家销售排名 */
@property (nonatomic, copy) NSString *join_sales_pai;
/** 门店销售排名*/
@property (nonatomic, copy) NSString *men_sales_pai;
/** 商家消耗排名 */
@property (nonatomic, copy) NSString *join_serv_pai;
/** 门店消耗排名*/
@property (nonatomic, copy) NSString *men_serv_pai;
@end

NS_ASSUME_NONNULL_END
