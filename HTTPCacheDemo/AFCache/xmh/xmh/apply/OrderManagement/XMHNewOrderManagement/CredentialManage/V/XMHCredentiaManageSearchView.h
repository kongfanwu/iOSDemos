//
//  XMHCredentiaManageSearchView.h
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaManageSearchView : UIView

/** <##> */
@property (nonatomic, copy) NSString *placeholder;
/** <##> */
@property (nonatomic, strong, readonly) UIButton *searchBtn;
/** <#type#> */
@property (nonatomic, copy) void (^searchBlock)(XMHCredentiaManageSearchView *searchView, NSString *text);
/**  */
@property (nonatomic, copy) void (^clearSearchTextBlock)(XMHCredentiaManageSearchView *searchView);


@end

NS_ASSUME_NONNULL_END
