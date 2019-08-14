//
//  XMHUserTagCollectionHeaderView.h
//  xmh
//
//  Created by kfw on 2019/8/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHUserTagSectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHUserTagCollectionHeaderView : UICollectionReusableView
/** tap */
@property (nonatomic, copy) void (^tapClickBlock)();

- (void)configModel:(XMHUserTagSectionModel *)userTagSectionModel;

@end

NS_ASSUME_NONNULL_END
