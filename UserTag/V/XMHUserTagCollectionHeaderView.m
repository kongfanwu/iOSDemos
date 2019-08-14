//
//  XMHUserTagCollectionHeaderView.m
//  xmh
//
//  Created by kfw on 2019/8/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUserTagCollectionHeaderView.h"
#import "XMHUserTagSectionModel.h"

@interface XMHUserTagCollectionHeaderView()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *addImageView;
/** <##> */
@property (nonatomic, strong) UIView *lineView;
/** <##> */
@property (nonatomic, strong) XMHUserTagSectionModel *userTagSectionModel;
@end

@implementation XMHUserTagCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        __weak typeof(self) _self = self;
        [self bk_whenTapped:^{
            __strong typeof(_self) self = _self;
            if (self.tapClickBlock) self.tapClickBlock();
        }];
        
        self.lineView = UIView.new;
        _lineView.backgroundColor = kSeparatorColor;
        [self addSubview:_lineView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.height - 18) / 2, self.width, 18)];
        _titleLabel.font = FONT_SIZE(16);
        [self addSubview:_titleLabel];
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [self resizableImageName:@"GKGL_biaoqian_weixuan"];
        [self addSubview:_bgImageView];
        //        _bgImageView.userInteractionEnabled = YES;
        
        self.addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _addImageView.image = [UIImage imageNamed:@"gkgl_zidingyibiaoqian"];
        [_bgImageView addSubview:_addImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, _bgImageView.width - 15, _bgImageView.height)];
        _nameLabel.font = FONT_SIZE(14);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_bgImageView addSubview:_nameLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_userTagSectionModel.type == XMHUserTagSectionModelTypeAdd) {
        _lineView.frame = CGRectMake(0, 0, self.width, kSeparatorHeight);
        _bgImageView.frame = CGRectMake(15, (self.height - 40) / 2.f, 120, 40);
        
        CGFloat contentW = _nameLabel.width + 12 + 5;
        CGFloat gap = (_bgImageView.width - contentW) / 2.f;
        
        _addImageView.frame = CGRectMake(gap, (_bgImageView.height - 12) / 2.f, 12, 12);
        _nameLabel.frame = CGRectMake(_addImageView.right + 5, (_bgImageView.height - _nameLabel.height) / 2.f, _nameLabel.width, _nameLabel.height);
    }
}

- (void)configModel:(XMHUserTagSectionModel *)userTagSectionModel {
    self.userTagSectionModel = userTagSectionModel;
    if (userTagSectionModel.type == XMHUserTagSectionModelTypeNormal) {
        _titleLabel.hidden = NO;
        _bgImageView.hidden = YES;
        _lineView.hidden = YES;
        _titleLabel.text = userTagSectionModel.name;
    } else {
        _titleLabel.hidden = YES;
        _bgImageView.hidden = NO;
        _lineView.hidden = NO;
        _nameLabel.text = userTagSectionModel.footerName;
        [_nameLabel sizeToFit];
    }
}

- (UIImage *)resizableImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 20) resizingMode:UIImageResizingModeStretch];
    return image;
}

@end
