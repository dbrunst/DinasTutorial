#import "TableViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface TableViewController (Spec)
@property (strong, nonatomic) UITableView *tableView;
@end

SPEC_BEGIN(TableViewControllerSpec)

describe(@"TableViewController", ^{
    __block TableViewController *controller;
    __block id<TableViewControllerDelegate> delegate;

    beforeEach(^{
        delegate = nice_fake_for(@protocol(TableViewControllerDelegate));
        controller = [[TableViewController alloc] init];
        controller.delegate = delegate;
        controller.view should_not be_nil;
    });

    describe(@"UITableViewDataSource protocol", ^{
        describe(@"tableView:numberOfRowsInSection:", ^{
            it(@"should return 5", ^{
                [controller.tableView.dataSource tableView:controller.tableView numberOfRowsInSection:0] should equal(5);
            });
        });

        describe(@"tableView:cellForRowAtIndexPath:", ^{
            it(@"should have the correct label", ^{
                [controller.tableView.dataSource tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]].textLabel.text should equal(@"five");
            });
        });
    });
});

SPEC_END
