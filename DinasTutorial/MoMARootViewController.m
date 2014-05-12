#import "MoMARootViewController.h"

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
    
}

@end
