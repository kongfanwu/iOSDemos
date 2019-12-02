//
//  BookDetailHeader.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"
@class CustomerMessageModel;
@interface BookDetailHeader : UIView
- (void)updateBookDetailHeaderModel:(CustomerMessageModel *)model;
@end
