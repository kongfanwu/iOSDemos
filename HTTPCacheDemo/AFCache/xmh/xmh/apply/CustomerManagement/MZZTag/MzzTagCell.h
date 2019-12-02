//
//  MzzTagCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMTagListView.h"
#import "MzzTags.h"
@class MzzTagCell ;

@protocol MzzTagCellDelegate <NSObject>
- (void)tagcell:(MzzTagCell * )cell removeBtnOnclick:(UIButton *)btn currentIndexPath:(NSIndexPath *)currentIndexPath;
@end

@interface MzzTagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *lblView;
@property (weak, nonatomic) IBOutlet KMTagListView *tagListView;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (strong, nonatomic)NSMutableArray *list;
@property(strong ,nonatomic)NSIndexPath *currentIndexPath;
@property (assign ,nonatomic)BOOL editStyle;
@property (strong ,nonatomic)MzzSectionTags *sectionTags;
@property (weak ,nonatomic) id <MzzTagCellDelegate> deleagte_;
@end
