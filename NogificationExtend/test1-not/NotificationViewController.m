//
//  NotificationViewController.m
//  test1-not
//
//  Created by KFW on 2018/9/29.
//  Copyright © 2018 KFW. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    
    
    
//    self.view.frame = CGRectMake(0, 0, 200, 200);
}

- (void)didReceiveNotification:(UNNotification *)notification {
    NSLog(@"didReceiveNotification");
    self.label.text = [NSString stringWithFormat:@"自定义：%@", notification.request.content.body];
    
    //附件的提取
    UNNotificationAttachment * attachment = notification.request.content.attachments.firstObject;
    if ([attachment.URL startAccessingSecurityScopedResource]) {
        NSData *imageData = [NSData dataWithContentsOfURL:attachment.URL];
        [self.imageView setImage:[UIImage imageWithData:imageData]];
        [attachment.URL stopAccessingSecurityScopedResource];
    }
    

}

@end
