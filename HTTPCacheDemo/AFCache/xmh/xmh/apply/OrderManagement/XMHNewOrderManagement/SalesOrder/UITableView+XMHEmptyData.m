//
//  UITableView+XMHEmptyData.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/23.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "UITableView+XMHEmptyData.h"
#import <objc/runtime.h>
#define labTag 20000
#define noDataImage 10000

@implementation UITableView (XMHEmptyData)


- (void) tableViewDisplayWithMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        if (message.length > 0) {
            
            UIView *bgView = UIView.new;
            bgView.frame = CGRectMake(100, 0, SCREEN_WIDTH - 100, SCREEN_HEIGHT);
            bgView.backgroundColor = UIColor.whiteColor;
            
            UILabel *messageLabel = [UILabel new];
            messageLabel.text = message;
            messageLabel.font = [UIFont systemFontOfSize:12];
            messageLabel.textColor = kLabelText_Commen_Color_9;
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.frame = CGRectMake(0, 24, SCREEN_WIDTH - 100, 20);
            messageLabel.centerX = self.centerX;
            [bgView addSubview:messageLabel];
            messageLabel.tag = labTag;
            self.backgroundView = bgView;
            
        }else{
            
            
            UIView *bgView = UIView.new;
            bgView.frame = CGRectMake(100, 0, SCREEN_WIDTH - 100, SCREEN_HEIGHT);
            bgView.backgroundColor = UIColor.whiteColor;;
            UIImageView *noDataView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ddglst_zanwutishi"]];
            noDataView.frame = CGRectMake((bgView.width - 142) * 0.5, 110, 142, 157);
            [bgView addSubview:noDataView];
            noDataView.tag = noDataImage;
            self.backgroundView = bgView;
        }
    }else {
        self.backgroundView = nil;
        
    }
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void) tableViewDisplayWithFrame:(CGRect)frame msg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    CGRect rect = frame;
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        if (message.length > 0) {
            
            UILabel *messageLabel = [UILabel new];
            messageLabel.text = message;
            messageLabel.font = [UIFont systemFontOfSize:12];
            messageLabel.textColor = kLabelText_Commen_Color_9;
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.frame = CGRectMake(0, 24, rect.size.width, 20);
            messageLabel.centerX = self.centerX;
            messageLabel.tag = labTag;
            [messageLabel sizeToFit];
            UIView *bgView = UIView.new;
            bgView.frame = frame;
            bgView.backgroundColor = kColorF5F5F5;
            [bgView addSubview:messageLabel];
            self.backgroundView = bgView;
        
        }else{
            
            UIImageView *noDataView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ddglst_zanwutishi"]];
            noDataView.frame = CGRectMake((rect.size.width  - 142) * 0.5, (rect.size.height - 157) * 0.5, 142, 157);
            //                [self addSubview:noDataView];
            noDataView.tag = noDataImage;
            
            UIView *bgView = UIView.new;
            bgView.frame = frame;
            bgView.backgroundColor = UIColor.whiteColor;
            [bgView addSubview:noDataView];
            self.backgroundView = bgView;
          
        }
    }else {
        self.backgroundView = nil;
        
    }
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
@end
