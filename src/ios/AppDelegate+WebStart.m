#import <objc/runtime.h>
#import "AppDelegate.h"
#import "WebStartMainViewController.h"

static void swizzleMethod(Class class, SEL destinationSelector, SEL sourceSelector);

@implementation AppDelegate (WebStart)

+ (void)load {
    swizzleMethod([AppDelegate class],
                  @selector(application:didFinishLaunchingWithOptions:),
                  @selector(my_application:didFinishLaunchingWithOptions:));
}

- (BOOL)my_application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.autoresizesSubviews = YES;
    WebStartMainViewController *mvc = [[WebStartMainViewController alloc] init];
    self.viewController = mvc;
    self.window.rootViewController = mvc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

#pragma mark Swizzling

static void swizzleMethod(Class class, SEL destinationSelector, SEL sourceSelector) {
    Method destinationMethod = class_getInstanceMethod(class, destinationSelector);
    Method sourceMethod = class_getInstanceMethod(class, sourceSelector);

    // If the method doesn't exist, add it.  If it does exist, replace it with the given implementation.
    if (class_addMethod(class, destinationSelector, method_getImplementation(sourceMethod), method_getTypeEncoding(sourceMethod))) {
        class_replaceMethod(class, destinationSelector, method_getImplementation(destinationMethod), method_getTypeEncoding(destinationMethod));
    } else {
        method_exchangeImplementations(destinationMethod, sourceMethod);
    }
}
