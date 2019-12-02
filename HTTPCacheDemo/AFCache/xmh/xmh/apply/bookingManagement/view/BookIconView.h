//
//  BookIconView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookIconView;
@protocol BookIconViewDelegate <NSObject>

@optional
- (void)bookIconViewSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface BookIconView : UIView
@property (nonatomic, weak) id <BookIconViewDelegate> delegate;
@property (nonatomic,     )NSInteger selectIndex;

@end
