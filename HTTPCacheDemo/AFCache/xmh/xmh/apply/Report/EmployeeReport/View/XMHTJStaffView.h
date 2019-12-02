//
//  XMHTJStaffView.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJCustomerListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHTJStaffView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

- (void)updateTJStaffCellModel:(TJCustomerModel *)model index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
