//
//  FWDHaoKaCell.h
//  
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//

#import <UIKit/UIKit.h>

@interface FWDHaoKaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (nonatomic, copy)void (^FWDHaoKaCellBlock)(NSString * select);
@end
