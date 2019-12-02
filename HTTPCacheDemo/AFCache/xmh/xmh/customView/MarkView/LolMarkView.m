		//
//  LolMarkView.m
//  mark
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolMarkView.h"
@implementation LolMarkView{
    
    CGFloat w ;
    CGFloat h ;
}
- (void)lolMarkViewImageName:(NSString *)imageName Title:(NSString *)title{
    
    UILabel * lb = [[UILabel alloc] init];
    lb.font = [UIFont systemFontOfSize:10];
    lb.text = title;
    lb.textColor = [ColorTools colorWithHexString:@"#ffc555"];
    [lb sizeToFit];
    UIImage * img = [UIImage imageNamed:imageName];
    CGFloat top = img.size.height/2; // 顶端盖高度
    CGFloat bottom = img.size.height/2 ; // 底端盖高度
    CGFloat left = img.size.width/2; // 左端盖宽度
    CGFloat right = img.size.width/2; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    img = [img resizableImageWithCapInsets:insets];
    self.image = img;
    lb.frame = CGRectMake(5, 2, lb.width, lb.height);
    lb.backgroundColor = [UIColor clearColor];
    [self addSubview:lb];
    w = lb.width + 20;
    h = lb.height + 4;
}
- (void)setFrame:(CGRect)frame{
    CGRect  rect =  frame;
    rect.size.width = w;
    rect.size.height = h;
    frame = rect;
    [super setFrame:frame];
}
@end
