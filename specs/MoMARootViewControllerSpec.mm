#import "MoMARootViewController.h"
#import "HelloWorldViewController.h"
#import "TableViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface MoMARootViewController (Spec)
@property (strong, nonatomic) UIButton *myButton;
@property (strong, nonatomic) UIButton *tableViewButton;
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
        
        it(@"should open a HelloWorldViewController", ^{
            controller.presentedViewController should be_instance_of([HelloWorldViewController class]);
        });
        
        it(@"should have the correct delegate", ^{
            ((HelloWorldViewController *)controller.presentedViewController).delegate should be_same_instance_as(controller);
        });
    });

    describe(@"Tapping tableViewButton", ^{
        beforeEach(^{
            [controller.tableViewButton tap];
        });

        it(@"should open a TableViewController", ^{
            controller.presentedViewController should be_instance_of([TableViewController class]);
        });
    });
    
    describe(@"HelloWorldViewControllerDelegate protocol", ^{
        describe(@"helloWorldViewControllerDidFinish", ^{
            beforeEach(^{
                UIViewController *controllerB = [[UIViewController alloc] init];
                [controller presentViewController:controllerB animated:NO completion:nil];
                [controller helloWorldViewControllerDidFinish];
            });
            
            it(@"should dismiss the presentedViewController", ^{
                controller.presentedViewController should be_nil;
            });
        });
    });
    
    describe(@"TableViewControllerDelegate protocol", ^{
        describe(@"tableViewControllerDidFinish", ^{
            beforeEach(^{
                UIViewController *tableViewController = [[UIViewController alloc] init];
                [controller presentViewController:tableViewController animated:NO completion:nil];
                [controller tableViewControllerDidFinish];
            });
            
            it(@"should dismiss tableViewController", ^{
                controller.presentedViewController should be_nil;
            });
        });
    });
});

SPEC_END
