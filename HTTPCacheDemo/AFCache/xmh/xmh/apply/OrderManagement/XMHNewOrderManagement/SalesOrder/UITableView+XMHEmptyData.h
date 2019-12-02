//
//  UITableView+XMHEmptyData.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/23.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (XMHEmptyData)


- (void) tableViewDisplayWithMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

- (void) tableViewDisplayWithFrame:(CGRect)frame msg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;
@end

NS_ASSUME_NONNULL_END
