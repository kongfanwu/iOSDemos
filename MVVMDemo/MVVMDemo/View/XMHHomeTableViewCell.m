//
//  XMHHomeTableViewCell.m
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import "XMHHomeTableViewCell.h"

@interface XMHHomeTableViewCell()
///
@property (nonatomic, strong) XMHHomeModel *model;
@end


@implementation XMHHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(200, 7, 60, 30);
        [self.contentView addSubview:_button];
        _button.backgroundColor = UIColor.cyanColor;
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)setModel:(XMHHomeModel *)model {
    if (_model) return;
    _model = model;
    
    // 只能监听一次
    //错误信号
    //    [self.model.likeBlogCommand.errors subscribeNext:^(NSError * _Nullable x) {
    //        NSLog(@"点赞失败");
    //    }];
    [self.model.likeBlogCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"点赞成功");
        } else {
            NSLog(@"点赞失败");
        }
    }];
}

- (void)buttonClick:(UIButton *)sender {

    [self.model.likeBlogCommand execute:nil];
}
- (void)configModel:(XMHHomeModel *)model {
    self.model = model;
    self.textLabel.text = model.name;
//    RAC(self.textLabel, text) = RACObserve(self, model.name);
    
    __weak typeof(self) _self = self;
    [RACObserve(self, model.count) subscribeNext:^(NSNumber * _Nullable count) {
        __strong typeof(_self) self = _self;
        [self.button setTitle:count.stringValue forState:UIControlStateNormal];
    }];
    
    [RACObserve(self, model.like) subscribeNext:^(NSNumber * _Nullable like) {
        __strong typeof(_self) self = _self;
        [self.button setTitleColor:like.boolValue ? UIColor.redColor : UIColor.blackColor forState:UIControlStateNormal];
    }];
    
//    RAC(self.titleLabel, text) = RACObserve(self, viewModel.blogTitleText);
//    RAC(self.summaryLabel, text) = RACObserve(self, viewModel.blogSummaryText);
//    RAC(self.likeButton, selected) = [RACObserve(self, viewModel.isLiked) ignore:nil];
    //数据绑定操作
//    @weakify(self);
//    [RACObserve(self, likeBlogCommand) subscribeNext:^(NSString *title) {
//        @strongify(self);
//        [self.likeButton setTitle:title forState:UIControlStateNormal];
//        [_button setTitle:@(model.count).stringValue forState:UIControlStateNormal];
//    }];

}

@end
