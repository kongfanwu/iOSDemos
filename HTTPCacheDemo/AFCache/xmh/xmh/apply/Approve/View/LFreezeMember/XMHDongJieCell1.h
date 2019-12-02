//
//  XMHDongJieCell1.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSponsorApproceModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHDongJieCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (strong, nonatomic)LSponsorApproceModel * model;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

NS_ASSUME_NONNULL_END
