#import "HackMainViewController.h"
#import <objc/runtime.h>

void emptyFunction(id self, SEL _cmd) {}

@implementation HackMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");
//    class_addMethod(class, @selector(setBeingRemoved:), (IMP)emptySetBeingRemoved, NULL);
    class_addMethod(class, @selector(willBeRemoved), (IMP)emptyFunction, NULL);
    class_addMethod(class, @selector(removeFromSuperview), (IMP)emptyFunction, NULL);
}


@end
