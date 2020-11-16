//
//  XMHHomeViewModel.h
//  MVVMDemo
//
//  Created by kfw on 2020/11/14.
//

#import "XMHViewModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHHomeViewModel : XMHViewModelBase
- (void)deleteCellModel:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
