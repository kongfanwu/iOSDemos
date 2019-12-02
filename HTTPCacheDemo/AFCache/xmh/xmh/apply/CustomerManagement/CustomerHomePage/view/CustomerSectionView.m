//
//  CustomerSectionView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerSectionView.h"
#import "BookIconView.h"
@interface CustomerSectionView ()<BookIconViewDelegate>
@property (weak, nonatomic) IBOutlet BookIconView *ChoiceView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *ChoiceSC;

@end

@implementation CustomerSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
- (IBAction)SCchoice:(UISegmentedControl *)sender {
    
    if ([self.delegate respondsToSelector:@selector(choiceIndex:andCollectionIndexpath:)]) {
        [self.delegate choiceIndex:sender.selectedSegmentIndex andCollectionIndexpath:nil];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //test
    _ChoiceView.delegate = self;
   
}

- (void)bookIconViewSelectIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(choiceIndex:andCollectionIndexpath:)]) {
        [self.delegate choiceIndex:-1  andCollectionIndexpath:indexPath];
    }
}
@end
