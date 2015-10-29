//
//  ListViewController.m
//  Country List Map
//
//  Created by Hongjin Su on 10/24/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "MyObject.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview_countryList;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark The tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array_countryList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CountryListCell"];
    MyObject *object = [_array_countryList objectAtIndex:indexPath.row];
    myCell.textLabel.text = [NSString stringWithFormat:@"City Name: %@", object.name];
    myCell.detailTextLabel.text = [NSString stringWithFormat:@"Country Code: %@", object.countrycode];

    return myCell;
    
}

#pragma To process to the next screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"DetailCellPush"]) {
        DetailViewController *objDVC = [segue destinationViewController];
        NSIndexPath *myIndexPath = [_tableview_countryList indexPathForSelectedRow];
        objDVC.myObject = [_array_countryList objectAtIndex:myIndexPath.row];
    }
}

@end
