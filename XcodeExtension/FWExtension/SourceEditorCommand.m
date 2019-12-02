//
//  SourceEditorCommand.m
//  FWExtension
//
//  Created by kfw on 2019/9/12.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    if ([invocation.commandIdentifier isEqualToString:@"com.shendeng.zhineng.XcodeDemo.FWExtension.SourceEditorCommand"]) {
        XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
        NSInteger curIndex = selection.start.line;
        NSMutableArray *totalLines = invocation.buffer.lines;
        NSInteger totalLinesCount = totalLines.count;
//        NSString *curLineContent = totalLines[curIndex];
        
        NSString *selectLineContent = totalLines[curIndex];
        NSInteger subStringLength = selection.end.column - selection.start.column;
        if (subStringLength) {
            NSString *userSelectContent = [selectLineContent substringWithRange:NSMakeRange(selection.start.column, subStringLength)];
            NSString *insertContent = [NSString stringWithFormat:@"#import \"%@.h\"", userSelectContent];
            NSInteger line_i = -1;
            for (int i = 0; i < totalLinesCount; i++) {
                NSString *lineContent = totalLines[i];
                // 找到最后一个#import 的下边
                if ([lineContent containsString:@"#import"]) {
                    line_i = i;
                }
            }
            if (line_i >= 0) {
                [totalLines insertObject:insertContent atIndex:line_i + 1];
            }
        }
    }
    if ([invocation.commandIdentifier isEqualToString:@"com.shendeng.zhineng.XcodeDemo.FWExtension.test"]) {
        NSLog(@"test");
        NSWindow *window = [NSApplication sharedApplication].mainWindow;
        NSAlert * alert = [[NSAlert alloc]init];
        alert.messageText = @"This is messageText";
        alert.alertStyle = NSAlertStyleInformational;
        [alert addButtonWithTitle:@"continue"];
        [alert addButtonWithTitle:@"cancle"];
        [alert setInformativeText:@"NSWarningAlertStyle \r Do you want to continue with delete of selected records"];
        [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
            NSLog(@"xxx");
            if (returnCode == NSModalResponseOK){
                NSLog(@"(returnCode == NSOKButton)");
            }else if (returnCode == NSModalResponseCancel){
                NSLog(@"(returnCode == NSCancelButton)");
            }else if(returnCode == NSAlertFirstButtonReturn){
                NSLog(@"if (returnCode == NSAlertFirstButtonReturn)");
            }else if (returnCode == NSAlertSecondButtonReturn){
                NSLog(@"else if (returnCode == NSAlertSecondButtonReturn)");
            }else if (returnCode == NSAlertThirdButtonReturn){
                NSLog(@"else if (returnCode == NSAlertThirdButtonReturn)");
            }else{
                NSLog(@"All Other return code %ld",(long)returnCode);
            }
        }];
    }
    
    completionHandler(nil);
}

@end
