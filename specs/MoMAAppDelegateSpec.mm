#import "MoMAAppDelegate.h"
#import "MoMARootViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MoMAAppDelegateSpec)

describe(@"MoMAAppDelegate", ^{
    __block MoMAAppDelegate *delegate;

    beforeEach(^{
        delegate = [[MoMAAppDelegate alloc] init];
    });
    
    describe(@"application:didFinishLaunchingWithOptions:", ^{
        beforeEach(^{
            [delegate application:nil didFinishLaunchingWithOptions:nil];
        });
        
        it(@"should have set the root view controller correctly", ^{
            delegate.window.rootViewController should be_instance_of([MoMARootViewController class]);
        });
    });
    
});

SPEC_END
