//
//  PTLinePickerAllViewController.m
//  Bus-Gogogo
//
//  Created by Haomin Wu on 4/10/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTLinePickerAllViewController.h"

#import "PTLinePickerDataSource.h"
#import "PTLinePickerTableViewCell.h"
#import "PTStopDetailViewController.h"
#import "PTRouteDetailTableViewController.h"
#import "PTLine.h"

@interface PTLinePickerAllViewController ()

@property (nonatomic, strong) PTLinePickerDataSource *dataSource;

@property (nonatomic, strong) NSURLSession *session;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
/*
@property (strong, nonatomic) NSMutableArray* filteredTableData;

@property bool isFiltered;
*/
@end

@implementation PTLinePickerAllViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        _dataSource = [[PTLinePickerDataSource alloc] init];
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        /*
        self.isFiltered=false;
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
        self.searchBar.delegate = (id)self;
        self.tableView.tableHeaderView = self.searchBar;
         */
        [self _downloadRouteIDs];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //  [self _downloadRouteIDs];
}

- (void)_downloadRouteIDs
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bustime.mta.info/api/where/routes-for-agency/MTA%20NYCT.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1"]];
    [[self.session dataTaskWithRequest:request
                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             self.dataSource.routeIdentifiers = [self _routeIDsFromData:data];
                             [self.tableView reloadData];
                         });
                     }] resume];
}

- (NSArray *)_routeIDsFromData:(NSData *)data
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    assert(!error);
    
    NSArray *list = json[@"data"][@"list"];
    NSArray *routeIDs = [list valueForKey:@"id"];
    routeIDs = [routeIDs sortedArrayUsingSelector:@selector(localizedCompare:)];
    return routeIDs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.tableView registerClass:[PTLinePickerTableViewCell class] forCellReuseIdentifier:kLinePickerTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    assert(section == 0);
    /*
    if (self.isFiltered)
    {
        return self.filteredTableData.count;
    }
    else return self.dataSource.routeIdentifiers.count;
    */
    return self.dataSource.routeIdentifiers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTLinePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLinePickerTableViewCellIdentifier forIndexPath:indexPath];
    assert(cell);
    
    NSString *line = [self.dataSource routeIdentifierAtIndexPath:indexPath];
    cell.textLabel.text = line;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *routeID = [self.dataSource routeIdentifierAtIndexPath:indexPath];
    
    [self _pushToRouteDetailViewWithRouteIdentifier:routeID];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Private

- (void)_pushToRouteDetailViewWithRouteIdentifier:(NSString *)routeIdentifier
{
    UIViewController *vc = [[PTRouteDetailTableViewController alloc] initWithStyle:UITableViewStylePlain
                                                                   routeIdentifier:routeIdentifier];
    [self.navigationController pushViewController:vc animated:YES];
}


/*
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        self.isFiltered = FALSE;
        
    }
    else
    {
        self.isFiltered = true;
        self.filteredTableData = [[NSMutableArray alloc] init];
    }
}
*/

@end
