#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()
@property (strong, nonatomic) UILabel *myLabel;
@end

@implementation HelloWorldViewController
- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.text = @"Hello World!!!";
    self.myLabel.frame = CGRectMake(20, 20, 280, 40);
    [self.view addSubview:self.myLabel];
}
@end
