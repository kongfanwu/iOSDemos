//
//  XMHUserTagCollectionView.h
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseCollectionView.h"
@class XMHUserTagSectionModel;

NS_ASSUME_NONNULL_BEGIN

@protocol XMHUserTagCollectionViewDelegate <NSObject>

@optional

/**
 选中事件
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 删除事件
 */
- (void)deleteCellIndexPath:(NSIndexPath *)indexPath;

/**
 添加标签事件
 */
- (void)addCellIndexPath:(NSIndexPath *)indexPath;

/**
 添加标签类型事件
 */
- (void)addTagType;
@end

@interface XMHUserTagCollectionView : XMHBaseCollectionView
@property (nonatomic, strong) NSMutableArray <XMHUserTagSectionModel *> *dataArray;
/** <##> */
@property (nonatomic, weak) id <XMHUserTagCollectionViewDelegate> aDelegate;
@end

NS_ASSUME_NONNULL_END
