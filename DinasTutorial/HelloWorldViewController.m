#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()
@property (strong, nonatomic) UILabel *myLabel;
@property (strong, nonatomic) UIButton *closeButton;
@end

@implementation HelloWorldViewController
- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.text = @"Hello World!!!";
    self.myLabel.frame = CGRectMake(20, 20, 280, 40);
    [self.view addSubview:self.myLabel];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(20, 100, 280, 40);
    self.closeButton.backgroundColor = [UIColor blueColor];
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.view addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(closeButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeButtonWasTapped {
    [self.delegate helloWorldViewControllerDidFinish];
}

@end

