#import "MoMAAppDelegate.h"
#import "MoMARootViewController.h"

@implementation MoMAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[MoMARootViewController alloc] init];

    [self.window makeKeyAndVisible];
    return YES;
}

@end
