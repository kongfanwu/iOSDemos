//
//  XMHCredentialtenCell.h
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 凭证cell

#import <UIKit/UIKit.h>
#import "XMHCredentiaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentialtenCell : UICollectionViewCell

- (void)configModel:(XMHCredentiaItemModel *)model;

@end

NS_ASSUME_NONNULL_END
