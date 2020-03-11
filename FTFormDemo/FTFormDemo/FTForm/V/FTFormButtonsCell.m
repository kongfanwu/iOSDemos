//
//  FTFormButtonsCell.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/17.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormButtonsCell.h"
#import "FTButtonModel.h"
#import "ViewControllerProtocol.h"

@interface FTFormButtonsCell() <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) FTFormRow *row;
@end

@implementation FTFormButtonsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = UILabel.new;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(30);
        }];
        
        self.bgView = UIView.new;
//        _bgView.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.left.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configRow:(FTFormRow *)row {
    self.row = row;
    
    self.titleLabel.text = row.title;
    
    [_bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray *list = row.value;
    
    UIView *lastView = nil;
    UIView *lastRowView = nil;
    int lastChu = -1;
    
    CGFloat gap = ([UIScreen mainScreen].bounds.size.width - 4 * 80) / 5;
    
    for (int i = 0; i < list.count; i++) {
        FTButtonModel *buttonModel =  list[i];
        
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [_bgView addSubview:imageView];
        imageView.image = [self imageWithColor:[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0] size:CGSizeMake(80, 40)];
        imageView.highlightedImage = [self imageWithColor:[UIColor colorWithRed:254/255.0 green:233/255.0 blue:224/255.0 alpha:1.0] size:CGSizeMake(80, 40)];
        imageView.highlighted = buttonModel.select;
        imageView.layer.cornerRadius = 3;
        imageView.layer.masksToBounds = YES;
        imageView.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick:)];
        [imageView addGestureRecognizer:tap];
        
        UITextField *tf = [[UITextField alloc] init];
        tf.tag = i;
        tf.delegate = self;
        [imageView addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imageView);
        }];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.font = [UIFont systemFontOfSize:13];
        
        if (buttonModel.select) {
            tf.textColor = [UIColor colorWithRed:255/255.0 green:146/255.0 blue:97/255.0 alpha:1.0];
        } else {
            tf.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        }
        
        if (buttonModel.type == FTButtonModelTypeCustom) {
            tf.enabled = YES;
            tf.placeholder = buttonModel.title;
        } else {
            tf.enabled = NO;
            tf.text = buttonModel.title;
        }
        
        int yu = i % 4; // 0 1 2  0 1 2  0 1 2  x 轴对应的是列
        int chu = floor(i / 4);  // y 轴对应的是行
        
        
        if (lastChu != chu) {
            lastChu = chu;
            lastRowView = lastView;
        }
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            
            if (yu == 0) {
                make.left.equalTo(self.bgView.mas_left).offset(gap);
            } else {
                make.left.equalTo(lastView.mas_right).offset(gap);
            }
            
            if (chu == 0) {
                make.top.equalTo(self.bgView).offset(10);
            } else {
                make.top.equalTo(lastRowView.mas_bottom).offset(10);
            }
            
            if (i == list.count - 1) {
                make.bottom.equalTo(self.bgView).offset(-10);
            }
            
        }];
        
        lastView = imageView;
    }
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - click

- (void)buttonClick:(UITapGestureRecognizer *)tap {
    UITableViewController <ViewControllerProtocol> *tableVC = (UITableViewController <ViewControllerProtocol> *)self.viewController;
    if ([tableVC respondsToSelector:@selector(buttonClickRow:buttonModel:)]) {
        NSInteger tag = tap.view.tag;
        FTButtonModel *buttonModel = ((NSArray *)self.row.value)[tag];
        [tableVC buttonClickRow:self.row buttonModel:buttonModel];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *inputText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    FTButtonModel *buttonModel = ((NSArray *)self.row.value)[textField.tag];
    buttonModel.title = inputText;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITableViewController <ViewControllerProtocol> *tableVC = (UITableViewController <ViewControllerProtocol> *)self.viewController;
    if ([tableVC respondsToSelector:@selector(addCustomRow:customButtonModel:)]) {
        FTButtonModel *buttonModel = ((NSArray *)self.row.value)[textField.tag];
        [tableVC addCustomRow:self.row customButtonModel:buttonModel];
    }
    
    return YES;
}

@end
