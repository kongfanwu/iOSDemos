//
//  XMHOrderContentSearchView.h
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHOrderContentSearchView : UIView
/** <##> */
@property (nonatomic, strong) UITextField *textField;
/** <#type#> */
@property (nonatomic, copy) void (^searchBlock)(XMHOrderContentSearchView *searchView, NSString *text);
/**  */
@property (nonatomic, copy) void (^clearSearchTextBlock)(XMHOrderContentSearchView *searchView);
/**  */
@property (nonatomic, copy) void (^changeSearchTextBlock)(XMHOrderContentSearchView *searchView);

@end

NS_ASSUME_NONNULL_END
