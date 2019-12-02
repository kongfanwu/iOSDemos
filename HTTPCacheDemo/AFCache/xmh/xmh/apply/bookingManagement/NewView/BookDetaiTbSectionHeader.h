//
//  BookDetaiTbSectionHeader.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetaiTbSectionHeader : UIView
@property (nonatomic, copy) void (^BookDetaiTbSectionHeaderBlock)(NSInteger index);
/**
 *更新头部

 @param index 名称
 */
- (void)updateBookDetaiTbSectionHeader:(NSInteger)index;
@end
