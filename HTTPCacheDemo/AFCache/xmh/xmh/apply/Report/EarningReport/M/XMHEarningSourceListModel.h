//
//  XMHEarningSourceListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHEarningSourceModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHEarningSourceListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHEarningSourceModel *> *list;
@end

@interface XMHEarningSourceModel : NSObject

/**  */
@property (nonatomic, copy) NSString *name;
/** 购买人数*/
@property (nonatomic, copy) NSString *num;
/** 销售业绩 */
@property (nonatomic, copy) NSString *amount;
/** 占比 */
@property (nonatomic, copy) NSString *bfb;

@end
NS_ASSUME_NONNULL_END
