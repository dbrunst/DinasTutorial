#import <UIKit/UIKit.h>

@protocol TableViewControllerDelegate <NSObject>
@end


@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) id<TableViewControllerDelegate> delegate;
@end
