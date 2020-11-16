//
//  UIImageView+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UIImageView+XMHConvenient.h"

@implementation UIImageView (XMHConvenient)

- (UIImageView *(^)(UIImage *))xmhImage {
    return ^UIImageView *(UIImage *image){
        self.image = image;
        return self;
    };
}

- (UIImageView *(^)(UIImage *))xmhHighlightedImage {
    return ^UIImageView *(UIImage *image){
        self.highlightedImage = image;
        return self;
    };
}

- (UIImageView *(^)(BOOL))xmhUserInteractionEnabled {
    return ^UIImageView *(BOOL userInteractionEnabled){
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (UIImageView *(^)(BOOL))xmhHighlighted {
    return ^UIImageView *(BOOL highlighted){
        self.highlighted = highlighted;
        return self;
    };
}
@end
