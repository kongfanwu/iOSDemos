//
//  UITableView+XMHConvenient.h
//  XMHUIKit
//
//  Created by kfw on 2019/12/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (XMHConvenient)

+ (UITableView *(^)(UIView *, CGRect, UITableViewStyle, id <UITableViewDelegate, UITableViewDataSource>))xmhNewAndSuperViewAndFrameAndStyleAndDelegate;

@end

NS_ASSUME_NONNULL_END
