#import "TableViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) UIButton *closeButton;
@end

@implementation TableViewController

static NSString *reuseIdentifier = @"UITableViewCell";

- (id)init {
    if (self = [super init]) {
        self.data = @[ @"one", @"two", @"three", @"four", @"five" ];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.tableView];
    
    [self setUpCloseButton];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *viewCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    viewCell.textLabel.text = self.data[indexPath.row];

    return viewCell;
}

- (void)setUpCloseButton {
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(20, 400, 280, 40);
    self.closeButton.backgroundColor = [UIColor greenColor];
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.view addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(closeButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeButtonWasTapped {
    [self.delegate tableViewControllerDidFinish];
}
@end
