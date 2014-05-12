#import "MoMARootViewController.h"
#import "HelloWorldViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface MoMARootViewController (Spec)
@property (strong, nonatomic) UIButton *myButton;
@end

SPEC_BEGIN(MoMARootViewControllerSpec)

describe(@"MoMARootViewController", ^{
    __block MoMARootViewController *controller;

    beforeEach(^{
        controller = [[MoMARootViewController alloc] init];
        controller.view should_not be_nil;
    });
    
    describe(@"myButton", ^{
        it(@"should have the correct label", ^{
            controller.myButton.titleLabel.text should equal(@"Dina's Button");
        });
    });
    
    describe(@"Tapping myButton", ^{
        beforeEach(^{
            [controller.myButton tap];
        });
        
        it(@"should open up a HelloWorldViewController", ^{
            controller.presentedViewController should be_instance_of([HelloWorldViewController class]);
        });
    });
});

SPEC_END
