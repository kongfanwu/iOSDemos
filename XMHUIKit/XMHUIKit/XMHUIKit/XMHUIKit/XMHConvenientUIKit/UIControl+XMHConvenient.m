//
//  UIControl+XMHConvenient.m
//  XMHUIKit
//
//  Created by kfw on 2019/12/14.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "UIControl+XMHConvenient.h"
#import <objc/runtime.h>

static const void *BKControlHandlersKey = &BKControlHandlersKey;

#pragma mark Private

@interface XMHBKControlWrapper : NSObject <NSCopying>

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation XMHBKControlWrapper

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
    self = [super init];
    if (!self) return nil;

    self.handler = handler;
    self.controlEvents = controlEvents;

    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[XMHBKControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
    self.handler(sender);
}

@end

@implementation UIControl (XMHConvenient)

- (UIControl *(^)(UIControlEvents controlEvents, void(^)(UIControl *)))xmhAddEvent {
    return ^UIControl *(UIControlEvents controlEvents, void(^handler)(UIControl *control)){
        NSParameterAssert(handler);
        NSMutableDictionary *events = objc_getAssociatedObject(self, BKControlHandlersKey);
        if (!events) {
            events = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, BKControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }

        NSNumber *key = @(controlEvents);
        NSMutableSet *handlers = events[key];
        if (!handlers) {
            handlers = [NSMutableSet set];
            events[key] = handlers;
        }
        
        XMHBKControlWrapper *target = [[XMHBKControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
        [handlers addObject:target];
        [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
        
        return self;
    };
}

- (UIControl *(^)(UIControlEvents controlEvents))xmhRemoveEvent {
    return ^UIControl *(UIControlEvents controlEvents){
        NSMutableDictionary *events = objc_getAssociatedObject(self, BKControlHandlersKey);
        if (!events) {
            events = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, BKControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }

        NSNumber *key = @(controlEvents);
        NSSet *handlers = events[key];

        if (!handlers)
            return self;

        [handlers enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
            [self removeTarget:sender action:NULL forControlEvents:controlEvents];
        }];

        [events removeObjectForKey:key];
        
        return self;
    };
}

@end
