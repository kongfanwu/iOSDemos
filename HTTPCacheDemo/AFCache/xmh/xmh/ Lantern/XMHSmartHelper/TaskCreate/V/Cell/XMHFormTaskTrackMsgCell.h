//
//  XMHFormTaskTrackMsgCell.h
//  xmh
//
//  Created by kfw on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTaskTrackMsgCell : XMHFormTaskBaseCell <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

NS_ASSUME_NONNULL_END
