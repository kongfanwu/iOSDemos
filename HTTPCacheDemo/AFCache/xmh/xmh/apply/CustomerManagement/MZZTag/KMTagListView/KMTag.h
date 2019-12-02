//
//  KMTag.h
//  KMTag
//
//  Created by chavez on 2017/7/13.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzTags.h"
@class KMTag;
typedef void (^RemoveClick)(KMTag *tag);
@interface KMTag : UIView

@property (nonatomic ,copy)RemoveClick removeclick;
- (void)setupWithText:(NSString*)text;
-(void)setRemoveStyle:(BOOL)isremove;
@property (nonatomic ,strong)UILabel *lbl;
@property(nonatomic ,assign)BOOL is_select;
@property (nonatomic ,strong)MzzTag *tagModel;
@property (nonatomic ,strong)UIImageView *backImgView;
@end
