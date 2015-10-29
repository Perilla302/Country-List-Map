//
//  MapViewController.m
//  Country List Map
//
//  Created by Hongjin Su on 10/24/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapview_capital;
@property (strong, nonatomic) CLLocation *Location;
@property(nonatomic, readonly) NSArray <id<MKOverlay>> *overlays;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapview_capital.delegate = self;
    [self loadAnnotations];
    [self loadMap];
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

-(void)loadAnnotations {
    
    if (_mapview_capital.annotations.count) {
        
        [_mapview_capital removeAnnotations:_mapview_capital.annotations];
    }
   
        //placing the pin for the given city
        MKPointAnnotation *annoPin = [[MKPointAnnotation alloc]init];
        _Location = [[CLLocation alloc] initWithLatitude:_myObject.lat longitude:_myObject.lng];
        annoPin.coordinate = _Location.coordinate;
        [annoPin setTitle:_myObject.name];
        NSString *title = [NSString stringWithFormat:@"Latitude:%.6f, Longitude:%.6f", _Location.coordinate.latitude, _Location.coordinate.longitude];
        [annoPin setSubtitle:title];
        [_mapview_capital addAnnotation:annoPin];
}

-(void)loadMap {
    
//    MKCoordinateSpan _span;
//    CLLocationCoordinate2D _center;
//    MKCoordinateRegion reg;
//    
//    _span.latitudeDelta = 10;
//    _span.longitudeDelta = 10;
//    // the center point is the average of the max and mins
//    _center.latitude = _myObject.lat;
//    _center.longitude = _myObject.lng;
//    reg.center = _center;
//    reg.span = _span;
//    
//    [_mapview_capital setRegion:reg animated:YES];
    
//    //zooming the map to the given lat and lon
//    NSLog(@"myObject: Lat: %.6f, Lng: %.6f", _myObject.lat, _myObject.lng);
//    NSLog(@"Location: Lat: %.6f, Lng: %.6f", _Location.coordinate.latitude, _Location.coordinate.longitude);
    MKCoordinateRegion zoom_region = MKCoordinateRegionMakeWithDistance(_Location.coordinate, 2000, 2000);
    [_mapview_capital setRegion:zoom_region];
    
    
    //for adding the circle(overlay)
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:_Location.coordinate radius:500];
    [_mapview_capital addOverlay:circle];
}

///* PLEASE USE overlay path renderer METHOD */
//-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{ // outdated version
//    MKCircleView *circleView =[[MKCircleView alloc]initWithOverlay:overlay];
//    circleView.strokeColor = [UIColor greenColor];
//    circleView.fillColor = [[UIColor redColor]colorWithAlphaComponent:0.4]; //outdated version
//    return circleView;
//    
//}

// Guorui code for overlay
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay

{
    // MKCircleRenderer, MKPolygonRenderer, or MKPolylineRenderer: different shapes
    MKCircleRenderer *circleR = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
    
    circleR.fillColor = [UIColor greenColor];
    circleR.strokeColor = [UIColor redColor];
    
    
    
    return circleR;
    
}

- (void)addAnOverlay {

//    MKCircle *circleOverlay;
//    MKCircleRenderer *circleRenderer;
//    
//    _mapview_capital.OverlayRenderer = (m, o)^{
//        if(circleRenderer == null) {
//            circleRenderer = new MKCircleRenderer(o as MKCircle);
//            circleRenderer.FillColor = UIColor.Purple;
//            circleRenderer.Alpha = 0.5f;
//        }
//        return circleRenderer;
//    };
//    var coords = new CLLocationCoordinate2D(29.976111, 31.132778); //giza
//    circleOverlay = MKCircle.Circle (coords, 200);
//    _mapview_capital.AddOverlay (circleOverlay);
}


- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationview = nil;
    
    static NSString *str = @"Identifier";
    MKPinAnnotationView *areaPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:str];
    if (!areaPin) {
        
        MKPinAnnotationView *areaPin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:str];
        areaPin.pinTintColor = [self getRandomColor];
        //areaPin.pinTintColor = [UIColor blueColor];
        areaPin.animatesDrop = YES;
        areaPin.canShowCallout = YES;
        annotationview = areaPin;
    }
    return annotationview;
}

// To get random color for pin: https://gist.github.com/kylefox/1689973
- (UIColor*) getRandomColor {
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
