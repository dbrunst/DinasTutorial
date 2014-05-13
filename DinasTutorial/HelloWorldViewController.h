#import <UIKit/UIKit.h>

@protocol HelloWorldViewControllerDelegate <NSObject>

- (void)helloWorldViewControllerDidFinish;

@end

@interface HelloWorldViewController : UIViewController
@property (weak, nonatomic) id<HelloWorldViewControllerDelegate> delegate;
@end
