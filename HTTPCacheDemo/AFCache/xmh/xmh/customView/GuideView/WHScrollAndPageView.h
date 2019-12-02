//
//  WHScrollAndPageView.h
//  xmh
//
//  Created by ald_ios on 2018/10/25.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WHcrollViewViewDelegate;

@interface WHScrollAndPageView : UIView<UIScrollViewDelegate>
{
    __unsafe_unretained id <WHcrollViewViewDelegate> _delegate;
}
@property (nonatomic, assign) id <WHcrollViewViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end

@protocol WHcrollViewViewDelegate <NSObject>

@optional
- (void)didClickPage:(WHScrollAndPageView *)view atIndex:(NSInteger)index;
- (void)didClickCancel;
@end
