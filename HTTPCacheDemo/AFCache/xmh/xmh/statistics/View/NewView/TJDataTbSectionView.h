//
//  TJDataTbSectionView.h
//  xmh
//
//  Created by ald_ios on 2018/12/3.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJDataTbSectionView : UIView
/** 最高最低 */
@property (nonatomic, copy) void (^TJDataTbSectionViewBlock)(NSInteger tag);
@property (nonatomic, copy) void (^TJDataTbSectionViewTapBlock)();
- (void)updateTJDataTbSectionViewTItle:(NSString *)title;
- (void)updateTJDataTbSectionViewLeftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle;
@end
