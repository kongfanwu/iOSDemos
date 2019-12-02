//
//  XMHFormBaseCell.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHFormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormBaseCell : UITableViewCell
/**  */
@property (nonatomic) BOOL isLastCell;
/** <##> */
@property (nonatomic, strong) UIView *lineView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
