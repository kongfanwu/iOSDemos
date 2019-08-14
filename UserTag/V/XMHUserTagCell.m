//
//  XMHUserTagCell.m
//  xmh
//
//  Created by kfw on 2019/8/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagCell.h"
#import "XMHUserTagModel.h"

@interface XMHUserTagCell()
/** <##> */
@property (nonatomic, strong) XMHUserTagModel *userTagModel;
/** <##> */
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *addImageView;
/** <##> */
@property (nonatomic, strong) UILabel *nameLabel;
/** <##> */
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation XMHUserTagCell

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *v in self.subviews) {
        if (!v.hidden && CGRectContainsPoint(v.frame, point)) {
            return YES;
        }
    }
    if (CGRectContainsPoint(self.bounds, point)) {
        return YES;
    }
    return NO;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick:)];
//        longTap.minimumPressDuration = 2;
        [self addGestureRecognizer:longTap];
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_bgImageView];
//        _bgImageView.userInteractionEnabled = YES;
        
        self.addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _addImageView.image = [UIImage imageNamed:@"gkgl_zidingyibiaoqian"];
        [_bgImageView addSubview:_addImageView];
        _addImageView.hidden = YES;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, _bgImageView.width - 15, _bgImageView.height)];
        _nameLabel.font = FONT_SIZE(14);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_bgImageView addSubview:_nameLabel];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"gkgl_biaoqianshanchu"] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        _deleteButton.hidden = YES;
        __weak typeof(self) _self = self;
        [_deleteButton bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            if (self.deleteClickBlock) self.deleteClickBlock(self.userTagModel);
        } forControlEvents:UIControlEventTouchUpInside];   
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bgImageView.frame = self.bounds;
    
    CGFloat w = _bgImageView.width - 40;
    CGFloat x = 5 + 12.5;
    
    if (_userTagModel.type == XMHUserTagModelTypeAdd) {
        _addImageView.hidden = NO;
        _addImageView.frame = CGRectMake(x, (_bgImageView.height - 12) / 2.f, 12, 12);
        _nameLabel.frame = CGRectMake(_addImageView.right + 5, 0, w - 12 - 5, _bgImageView.height);
    } else {
        _addImageView.hidden = YES;
        _nameLabel.frame = CGRectMake(x, 0, w, _bgImageView.height);
    }
    
    _deleteButton.frame = CGRectMake(_bgImageView.right - 9, _bgImageView.top - 9, 18, 18);
}

- (void)configModel:(XMHUserTagModel *)userTagModel {
    self.userTagModel = userTagModel;
    _deleteButton.hidden = !_userTagModel.deleteState;
    _nameLabel.text = userTagModel.name;
//    [_nameLabel sizeToFit];
    
    if (userTagModel.type == XMHUserTagModelTypeAdd) {
        _bgImageView.image = [self resizableImageName:@"GKGL_biaoqian_weixuan"];
        _nameLabel.textColor = kColor3;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        if (userTagModel.select) {
            _nameLabel.textColor = kColorFF9072;
            
            _bgImageView.image = [self resizableImageName:@"GKGL_biaoqian"];;
        } else {
            _nameLabel.textColor = kColorC;
            
            _bgImageView.image = [self resizableImageName:@"GKGL_biaoqian_weixuan"];
        }
    }
}

- (UIImage *)resizableImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 20) resizingMode:UIImageResizingModeStretch];
    return image;
}

- (void)longClick:(UILongPressGestureRecognizer *)sender {
    if (_userTagModel.type == XMHUserTagModelTypeAdd) return;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _userTagModel.deleteState = !_userTagModel.deleteState;
        _deleteButton.hidden = !_userTagModel.deleteState;
    }
}

@end
