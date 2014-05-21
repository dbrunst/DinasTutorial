#import "TableViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface TableViewController (Spec)
@property (strong, nonatomic) UIButton *closeButton;
@end

SPEC_BEGIN(TableViewControllerSpec)

describe(@"TableViewController", ^{
    __block TableViewController *controller;
    __block id<TableViewControllerDelegate> delegate;

    beforeEach(^{

    });
});

SPEC_END
