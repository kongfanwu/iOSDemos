//
//  DataSubView.m
//  xmh
//
//  Created by ald_ios on 2018/10/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "DataSubView.h"
#import "DateSubViewModel.h"
@interface DataSubView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImv;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIImageView *more;

@end

@implementation DataSubView
- (void)updateDataSubViewModel:(DateSubViewModel *)model
{
    _lb1.text = model.textName;
    _lb2.text = model.textValue;
    _iconImv.image = UIImageName(model.iconName);
    _more.hidden = !model.isShow;
}

@end
