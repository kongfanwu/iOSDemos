//
//  SearchCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnValueBlock) (UIButton *btn);
@interface SearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@property (nonatomic ,copy)void  (^filter)(UIButton*);
@property (nonatomic ,copy)void  (^search)(NSString*);
@end
