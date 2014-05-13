#import "HelloWorldViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface HelloWorldViewController (Spec)
@property (strong, nonatomic) UIButton *closeButton;
@end

SPEC_BEGIN(HelloWorldViewControllerSpec)

describe(@"HelloWorldViewController", ^{
    __block HelloWorldViewController *controller;
    __block id<HelloWorldViewControllerDelegate> delegate;

    beforeEach(^{
        delegate = nice_fake_for(@protocol(HelloWorldViewControllerDelegate));
        controller = [[HelloWorldViewController alloc] init];
        controller.delegate = delegate;
        controller.view should_not be_nil;
    });
    
    describe(@"close button", ^{
        beforeEach(^{
            [controller.closeButton tap];
        });
        
        it(@"should inform the delegate", ^{
            controller.delegate should have_received(@selector(helloWorldViewControllerDidFinish));
        });
    });
});

SPEC_END
