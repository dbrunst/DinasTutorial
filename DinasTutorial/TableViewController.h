#import <UIKit/UIKit.h>

@protocol TableViewControllerDelegate <NSObject>

- (void)tableViewControllerDidFinish;

@end


@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) id<TableViewControllerDelegate> delegate;
@end
