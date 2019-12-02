//
//  WorkTbDgHeader.h
//  xmh
//
//  Created by ald_ios on 2018/9/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkModel;
@interface WorkTbDgHeader : UIView
+ (instancetype)loadWorkTbDgHeader;
- (void)updateWorkTbDgHeaderModel:(WorkModel *)model;
@end
