//
//  XMHVipDisDetailCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZheKouStored_Card;
NS_ASSUME_NONNULL_BEGIN

@interface XMHVipDisDetailCell : UITableViewCell
@property (nonatomic, copy)void(^selectedDetail)(ZheKouStored_Card *model);

- (void)refreshCellModel:(ZheKouStored_Card *)model;
@end

NS_ASSUME_NONNULL_END
