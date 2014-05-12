#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()
@property (strong, nonatomic) UILabel *myLabel;
@end

@implementation HelloWorldViewController
- (void)loadView {
    [super loadView];
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.text = @"Hello World!!!";
}
@end
