//
//  XMHHomeTableViewCell.h
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import <UIKit/UIKit.h>
#import "XMHHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHHomeTableViewCell : UITableViewCell

///
@property (nonatomic, strong) UIButton *button;

- (void)configModel:(XMHHomeModel *)model;
@end

NS_ASSUME_NONNULL_END
