//
//  FTFormBaseCell.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/10.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormBaseCell.h"

@implementation FTFormBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.textLabel.frame = CGRectMake(10, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
}

- (void)configRow:(FTFormRow *)row {}

@end
