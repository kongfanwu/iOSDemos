//
//  XMHRankContentDetailVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHRankContentDetailVC : UIViewController
/** XMHRankContentTypeSale:销售 XMHRankContentTypExpend:消耗 */
@property (nonatomic, assign) XMHRankContentType contentType;
/** 网络请求 */

- (void)requestRankDataWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
