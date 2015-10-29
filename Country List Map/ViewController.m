//
//  ViewController.m
//  Country List Map
//
//  Created by Hongjin Su on 10/23/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "MyObject.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *array_countryList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self DetailCall];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark The JSON data
- (void)DetailCall {
    
    NSString *urlString = @"http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession]; // + class method
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            
            NSLog(@"Error: %@",error);
        }
        else {
            //NSLog(@"Arrived here");
            [self JSONData:object];
        }
    }];// return a dataTask
    [dataTask resume]; //resume is necessary
}

- (void)JSONData:(id)object {
    
    if ([object isKindOfClass:[NSDictionary class]]) { // In JSON data, if nothing before brackets, then check [object isKindOfClass:[NSArray Array]]
        NSDictionary *myDict = object;
        NSArray *resultArray = [myDict objectForKey:@"geonames"];
        
        _array_countryList = [NSMutableArray new];
        for (int i = 0; i < [resultArray count]; i++) {
            
            MyObject *obj = [MyObject new];
            NSDictionary *dict = resultArray[i];
            
            obj.fcodeName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"fcodeName"]];
            obj.toponymName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"toponymName"]];
            obj.countrycode = [NSString stringWithFormat:@"%@", [dict objectForKey:@"countrycode"]];
            obj.fcl = [NSString stringWithFormat:@"%@", [dict objectForKey:@"fcl"]];
            obj.fclName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"fclName"]];
            obj.name = [NSString stringWithFormat:@"%@", [dict objectForKey:@"name"]];
            obj.wikipedia = [NSString stringWithFormat:@"%@", [dict objectForKey:@"wikipedia"]];
            obj.lng = [[dict objectForKey:@"lng"] doubleValue];
            obj.fcode = [NSString stringWithFormat:@"%@", [dict objectForKey:@"fcode"]];
            obj.geonameId = [[dict objectForKey:@"geonameId"] longValue];
            obj.lat = [[dict objectForKey:@"lat"] doubleValue];
            obj.population = [[dict objectForKey:@"population"] longValue];
            
            [_array_countryList addObject:obj];
        }
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"CountryListPush"]) {
        ListViewController *obj_LVC = [segue destinationViewController];
        obj_LVC.array_countryList = _array_countryList;
    }
}

@end
