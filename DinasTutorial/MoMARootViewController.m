#import "MoMARootViewController.h"
#import "HelloWorldViewController.h"

@interface MoMARootViewController ()
@property (strong, nonatomic) UIButton *myButton;
@end

@implementation MoMARootViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myButton.frame = CGRectMake(20, 20, 280, 40);
    self.myButton.backgroundColor = [UIColor blueColor];
    [self.myButton setTitle:@"Dina's Button" forState:UIControlStateNormal];
    [self.view addSubview:self.myButton];
    [self.myButton addTarget:self action:@selector(myButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)myButtonWasTapped {
    HelloWorldViewController *viewController = [[HelloWorldViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
