//
//  XMHUserTagCell.h
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHUserTagModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHUserTagCell : UICollectionViewCell

- (void)configModel:(XMHUserTagModel *)userTagModel;
/**  */
@property (nonatomic, copy) void (^deleteClickBlock)(XMHUserTagModel *userTagModel);

@end

NS_ASSUME_NONNULL_END
