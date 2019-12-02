//
//  KMTag.m
//  KMTag
//
//  Created by chavez on 2017/7/13.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "KMTag.h"

@interface KMTag ()

@property (nonatomic ,strong)UIButton *remove;


@end

@implementation KMTag


//
//-(void)drawRect:(CGRect)rect{
//
//    [super drawRect: rect];
//    _remove = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width -10, -5, 15, 15)];
//    [_remove setImage:[UIImage imageNamed:@"stbiaoqiangcha"] forState:UIControlStateNormal];
////    _remove.frame = CGRectMake(self.frame.size.width -10, -5, 15, 15);
//    [_remove addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_remove];
//}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _backImgView = [[UIImageView alloc] init];
        [self addSubview:_backImgView];
        
        _remove = [[UIButton alloc] init];
        [_remove setImage:[UIImage imageNamed:@"stbiaoqiangcha"] forState:UIControlStateNormal];
        [_remove addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        [_remove setHidden: YES];
        [self addSubview:_remove];
       
        _lbl = [[UILabel alloc] init];
        _lbl.frame = self.bounds;
        [self addSubview:_lbl];
        
        
        self.lbl.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)removeSelf{
    if (_removeclick) {
        self.removeclick(self);
    }
}



- (void)setupWithText:(NSString*)text {
    
    self.lbl.text = text;
    self.lbl.font = [UIFont systemFontOfSize:10];
    UIFont* font = self.lbl.font;
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    
    CGRect frame = self.frame;
    frame.size = CGSizeMake(size.width + 20, size.height + 10);
    
    self.lbl.frame = frame;
    self.bounds = frame;
    _remove.frame = CGRectMake(self.frame.size.width -10, -5, 15, 15);
    _backImgView.frame = self.bounds;
}

//img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(35, 35, 35, 35) resizingMode:UIImageResizingModeStretch];
//stbiaoqianmiaobian   stbiaoqiandise
-(void)setIs_select:(BOOL)is_select{
    _is_select = is_select;
        if (_is_select) {
//                [self.lbl setBackgroundColor:[ColorTools colorWithHexString:@"f10180"] ];
            [self.backImgView setImage:[[UIImage imageNamed:@"stbiaoqiandise"]resizableImageWithCapInsets:UIEdgeInsetsMake(self.height/2, self.width/2, self.height/2, self.width/2) resizingMode:UIImageResizingModeStretch]];
            [self.lbl setTextColor:[ColorTools colorWithHexString:@"ffffff"]];
        }else{
//             [self.lbl setBackgroundColor:[ColorTools colorWithHexString:@"ffffff"] ];
             [self.backImgView setImage:[[UIImage imageNamed:@"stbiaoqianmiaobian"]resizableImageWithCapInsets:UIEdgeInsetsMake(self.height/2, self.width/2, self.height/2, self.width/2) resizingMode:UIImageResizingModeStretch]];
             [self.lbl setTextColor:[ColorTools colorWithHexString:@"999999"]];
        }
}

-(void)setTagModel:(MzzTag *)tagModel{
    _tagModel = tagModel;
    [self setupWithText:_tagModel.content];
    self.is_select = _tagModel.is_select;
    if (!_tagModel.content_is_sys) {
        
    }else{
    }
}

-(void)setRemoveStyle:(BOOL)isremove{
    
    [_remove setHidden:!isremove];
    
}
@end
