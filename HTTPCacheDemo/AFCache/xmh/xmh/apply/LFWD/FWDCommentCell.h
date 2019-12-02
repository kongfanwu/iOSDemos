//
//  FWDCommentCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWDCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lbLimit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb1HeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, copy) void (^FWDCommentCellBlock)(NSString *beizhu);

/** 新版本 */
@property (nonatomic) BOOL isNewVersion;
@end
