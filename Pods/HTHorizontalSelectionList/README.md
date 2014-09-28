HTHorizontalSelectionList
=========================

A simple, horizontally-scrolling list of items that can be used as a more flexible replacement for UISegmentedControl

##Example

A simple side-scrolling list of items (perhaps filters for a UITableView below).
![alt tag](docs/car_list.gif)

##Setup via CocoaPods

Add HTHorizontalSelectionList pod into your Podfile
```
pod 'HTHorizontalSelectionList', '~> 0.2.1'
```

##Usage
###Setup and Initialization

To begin using HTHorizontalSelectionList, import the main header:
```objc
#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h>
```

The horizontal selection list uses a data-source/delegate model (similar to UITableView or UIPickerView).  To setup a simple horizontal selection list, init the view and set it's delegate and data source:
```objc
@interface CarListViewController () <HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate>

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *carMakes;

@end

@implementation CarListViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
	selectionList.delegate = self;
	selectionList.dataSource = self;

	self.carMakes = @[@"All cars",
                      @"Audi",
                      @"Bitter",
                      @"BMW",
                      @"Büssing",
                      @"Gumpert",
                      @"MAN"];
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.carMakes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.carMakes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
}

```

###Customizing the colors

The HTHorizontalSelectionList can be configured with the following properties and methods:
```objc
@property (nonatomic, strong) UIColor *selectionIndicatorColor;
@property (nonatomic, strong) UIColor *bottomTrimColor;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
```

The `selectionIndicatorColor` is the color of the thicker, bottom bar below the selected button.  The `bottomTrimColor` changes the appearance of the thin line below the entire control.
