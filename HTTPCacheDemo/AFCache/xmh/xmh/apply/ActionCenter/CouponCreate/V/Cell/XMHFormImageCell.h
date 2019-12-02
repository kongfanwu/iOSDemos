//
//  XMHFormLogoCell.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormImageCell : XMHFormBaseCell
/** <#type#> */
@property (nonatomic, copy) void (^addPhotoClick)(XMHFormImageCell *acell);
@end

NS_ASSUME_NONNULL_END
