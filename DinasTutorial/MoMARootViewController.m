#import "MoMARootViewController.h"
#import "HelloWorldViewController.h"
#import "TableViewController.h"

@interface MoMARootViewController ()
@property (strong, nonatomic) UIButton *myButton;
@property (strong, nonatomic) UIButton *tableViewButton;
@end

@implementation MoMARootViewController

#pragma mark - view lifecycle

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpMyButton];
    [self setUpTableViewButton];
}

#pragma mark - actions

- (void)myButtonWasTapped {
    HelloWorldViewController *viewController = [[HelloWorldViewController alloc] init];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)tableViewButtonWasTapped {
    TableViewController *viewController = [[TableViewController alloc] init];
    //viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - HelloWorldViewControllerDelegate protocol

- (void)helloWorldViewControllerDidFinish {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private

- (void)setUpMyButton {
    self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myButton.frame = CGRectMake(20, 20, 280, 40);
    self.myButton.backgroundColor = [UIColor blueColor];
    [self.myButton setTitle:@"Dina's Button" forState:UIControlStateNormal];
    [self.view addSubview:self.myButton];
    [self.myButton addTarget:self action:@selector(myButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setUpTableViewButton {
    self.tableViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tableViewButton.frame = CGRectMake(20, 80, 280, 40);
    self.tableViewButton.backgroundColor = [UIColor grayColor];
    [self.tableViewButton setTitle:@"Open Table Form" forState:UIControlStateNormal];
    [self.view addSubview:self.tableViewButton];
    [self.tableViewButton addTarget:self action:@selector(tableViewButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];
}

@end
