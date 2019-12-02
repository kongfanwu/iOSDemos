//
//  MzzTagCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/12.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTagCell.h"
#import "MzzTags.h"
#define angle2Radius(angle) (angle)/180.f * M_PI
@interface MzzTagCell ()
@end

@implementation MzzTagCell
- (IBAction)removeBtnonclick:(id)sender {
    if ([_deleagte_ respondsToSelector:@selector(tagcell:removeBtnOnclick:currentIndexPath:)]) {
        [_deleagte_ tagcell:self removeBtnOnclick:sender currentIndexPath:_currentIndexPath];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
 

    // Configure the view for the selected state
}
-(void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath{
    _currentIndexPath = currentIndexPath;
    self.tagListView.currentIndexPath = currentIndexPath;
}

-(void)setSectionTags:(MzzSectionTags *)sectionTags{
    _sectionTags = sectionTags;
    [self.titleLbl setText:sectionTags.name];
    NSMutableArray *notRemove = [NSMutableArray array];
    for (int i = 0;  i<sectionTags.content_list.count; i++) {
        MzzTag *tag = [sectionTags.content_list objectAtIndex:i];
        if (!tag.is_remove) {
            [notRemove addObject:tag];
        }
    }
    [self.tagListView setupSubViewsWithTitles:notRemove];
}
-(void)setEditStyle:(BOOL)editStyle{
    _editStyle = editStyle;
    if (_sectionTags.is_sys) {
        _removeBtn.hidden =YES;
        return;
    }
    CAKeyframeAnimation *animatioin = [CAKeyframeAnimation animation];
    animatioin.keyPath = @"transform.rotation";
    animatioin.values = @[@(angle2Radius(-2)),@(angle2Radius(2)),@(angle2Radius(-2))];
    animatioin.duration = 0.25;
    animatioin.repeatCount = CGFLOAT_MAX;
    _removeBtn.hidden =!_editStyle;
    if (_editStyle) {
         [_lblView.layer addAnimation:animatioin forKey:@"wocao"];
    }else{
        [ _lblView.layer removeAnimationForKey:@"wocao"];
    }
}
@end
