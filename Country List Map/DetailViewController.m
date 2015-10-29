//
//  DetailViewController.m
//  Country List Map
//
//  Created by Hongjin Su on 10/24/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewController.h"
#import "MyObject.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextView *textview_detail;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showDetails];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDetails {

    _label_title.text = _myObject.name;
    _textview_detail.text = [NSString stringWithFormat:@"fcodeName: %@ \n toponymName: %@ \n countrycode: %@ \n fcl: %@ \n fclName: %@ \n wikipedia: %@ \n lng: %.6f \n fcode: %@ \n geonameId: %ld \n lat: %.6f \n population: %ld \n", _myObject.fcodeName, _myObject.toponymName, _myObject.countrycode, _myObject.fcl, _myObject.fclName, _myObject.wikipedia, _myObject.lng, _myObject.fcode, _myObject.geonameId, _myObject.lat, _myObject.population];
}

#pragma To process to the next screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"DisplayMapPush"]) {
        MapViewController *objMVC = [segue destinationViewController];
        objMVC.myObject = _myObject;
    }
}

@end
