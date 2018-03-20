#import "WebStartMainViewController.h"

@implementation WebStartMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // get rid of white flash
    self.webView.backgroundColor = [UIColor colorWithRed:36.0/255 green:36.0/255 blue:36.0/255 alpha:1.0];
    self.webView.opaque = NO;
     [UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
    if ([self respondsToSelector:NSSelectorFromString(@"additionalSafeAreaInsets")]) {
        if (@available(iOS 11.0, *)) {
            self.additionalSafeAreaInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
        }
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.webView.opaque = YES;
}


@end
