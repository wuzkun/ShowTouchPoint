//
//  UIWindow+Event.m
//  TestTouch
//
//  Created by wuzhikun on 2020/11/3.
//

#import "UIWindow+Event.h"
#import "FTTouchPointView.h"

#import <objc/runtime.h>

#define SwizzleInstanceMethod(class, originalSelector, swizzledSelector) {              \
Method originalMethod = class_getInstanceMethod(class, (originalSelector)); \
Method swizzledMethod = class_getInstanceMethod(class, (swizzledSelector)); \
if (!class_addMethod((class),                                               \
(originalSelector),                                    \
method_getImplementation(swizzledMethod),              \
method_getTypeEncoding(swizzledMethod))) {             \
method_exchangeImplementations(originalMethod, swizzledMethod);         \
} else {                                                                    \
class_replaceMethod((class),                                            \
(swizzledSelector),                                 \
method_getImplementation(originalMethod),           \
method_getTypeEncoding(originalMethod));            \
}                                                                           \
}


@implementation UIWindow (Event)

+ (void)load {
    SwizzleInstanceMethod([UIWindow class], @selector(sendEvent:), @selector(my_sendEvent:))
}

- (void)my_sendEvent:(UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];
    if (touch.phase != UITouchPhaseEnded) {
        CGPoint point = [touch locationInView:self];
        FTTouchPointView *view = [[FTTouchPointView alloc] initWithFrame:CGRectMake(point.x-2, point.y-2, 4, 4)];
        view.layer.cornerRadius = 2;
        [self addSubview:view];
    }
    [self my_sendEvent:event];
}

@end
