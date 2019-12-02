//
//  BookCustomerCollectionViewCell.m
//  xmh
//
//  Created by 李晓明 on 2017/11/23.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookCustomerCollectionViewCell.h"
#import "LolHomeGuKeModel.h"
@implementation BookCustomerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lb1 = [[UILabel alloc] init];
        _lb1.textColor = kLabelText_Commen_Color_3;
        _lb1.font = FONT_SIZE(13);
        [self addSubview:_lb1];
        
        _lb2 = [[UILabel alloc] init];
        _lb2.backgroundColor = [ColorTools colorWithHexString:@"#f86f5c"];
        [self addSubview:_lb2];
        
        _lb3 = [[UILabel alloc] init];
        _lb3.textColor =[ColorTools colorWithHexString:@"#f86f5c"];
        _lb3.font = FONT_SIZE(13);
        [self addSubview:_lb3];
        
        _lb2.layer.cornerRadius = 5;
        _lb2.layer.masksToBounds = YES;
    }
    return self;
}
- (void)setModel:(LolHomeGuKeModel *)model
{
    if (model) {
        _model = model;
        _lb1.text = model.name;
        [_lb1 sizeToFit];
        _lb1.frame = CGRectMake((self.width - _lb1.width)/2, 10, _lb1.width, _lb1.height);
        _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 5, 10, 10);
        _lb3.text = [NSString stringWithFormat:@"%ld/%ld",(long)model.num,model.pro_num];
        [_lb3 sizeToFit];
        _lb3.frame = CGRectMake(_lb2.right + 5, _lb1.bottom + 2, _lb3.width, _lb3.height);
        
        if (model.state.intValue ==2) { //达标
            _lb3.textColor = [ColorTools colorWithHexString:@"#48c3af"];
            _lb2.backgroundColor = [ColorTools colorWithHexString:@"#48c3af"];
        }else if(model.state.intValue ==3){//不达标
            _lb3.textColor = [ColorTools colorWithHexString:@"#f86f5c"];
            _lb2.backgroundColor = [ColorTools colorWithHexString:@"#f86f5c"];
        }
    }else{
        _lb1.text = @"";
        _lb3.text = @"";
        _lb2.hidden = YES;
    }
}
@end
