//
//  WorkTbDgHeader.m
//  xmh
//
//  Created by ald_ios on 2018/9/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbDgHeader.h"
#import "WorkModel.h"
@interface WorkTbDgHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;

@end
@implementation WorkTbDgHeader

+ (instancetype)loadWorkTbDgHeader
{
    return loadNibName(@"WorkTbDgHeader");
}
- (void)updateWorkTbDgHeaderModel:(WorkModel *)model
{
    _icon.image = UIImageName(@"huigongzuo_tuoke");
    _lb1.text = model.type;
    _lb2.text = model.target;
    _lb3.text = model.active;
    _lb5.text = model.complete;
}
@end
