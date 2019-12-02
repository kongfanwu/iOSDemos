//
//  KMTagListView.h
//  KMTag
//
//  Created by chavez on 2017/7/13.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMTagListView;
@class KMTag;
@protocol KMTagListViewDelegate<NSObject>

- (void)ptl_TagListView:(KMTagListView*)tagListView didSelectTagView:(KMTag *)tagView selectContent:(NSString *)content currentIndexPath:(NSIndexPath *)currentIndexPath;
- (void)ptl_TagListView:(KMTagListView*)tagListView didRemoveTagView:(KMTag *)tagView selectContent:(NSString *)content currentIndexPath:(NSIndexPath *)currentIndexPath;
- (void)ptl_TagListView:(KMTagListView*)tagListView heightChange:(CGFloat)height lastList:(NSMutableArray *)lastdataList currentIndexPath:(NSIndexPath *)currentIndexPath;
- (void)ptl_TagListView:(KMTagListView*)tagListView selectContent:(NSString *)content currentIndexPath:(NSIndexPath *)currentIndexPath;
- (void)ptl_TagListView:(KMTagListView*)tagListView enterEditStyle:(BOOL)editStyle;
@end

@interface KMTagListView : UIScrollView

@property (nonatomic, weak)id<KMTagListViewDelegate> delegate_;
@property(strong ,nonatomic)NSIndexPath *currentIndexPath;
- (void)setupSubViewsWithTitles:(NSArray *)titles;
@property (nonatomic ,assign)CGFloat viewHeight;
@property (assign ,nonatomic)BOOL editStyle;
@end
