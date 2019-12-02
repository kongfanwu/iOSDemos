//
//  XMHAwardCollectionVIew.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHAwardCollectionVIew : UIView
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, copy)void(^selectAwardItemModel)(SaleModel *model);
@property (nonatomic, strong) SaleModel *model;
@end

NS_ASSUME_NONNULL_END
