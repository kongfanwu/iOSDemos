//
//  BookQuickRealizeView.m
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookQuickRealizeView.h"
@interface BookQuickRealizeView ()

@end
@implementation BookQuickRealizeView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _tf.contentInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    _tf1.contentInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}
- (IBAction)cancel:(id)sender
{
    [self removeFromSuperview];
}
@end
