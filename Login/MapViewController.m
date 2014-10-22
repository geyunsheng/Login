//
//  MapViewController.m
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/19.
//
//

#import "MapViewController.h"
#import "MyAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _map.delegate =self;
    _map.mapType =MKMapTypeStandard;
    _map.showsUserLocation =YES;
   
    self.lon.text = @"";
    self.lat.text = @"";
    
   // if ([CLLocationManager locationServicesEnabled])
    
    MyAnnotation* selfLoc = [[MyAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(38.909045, 121.597965)];
    [self.map addAnnotation:selfLoc];
    selfLoc.title = @"Center";
    selfLoc.subtitle = @"Dalian Government";
    [selfLoc release];
 
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate =self;
    _locationManager.desiredAccuracy =kCLLocationAccuracyBest;
    _locationManager.distanceFilter =100;
    [_locationManager startUpdatingLocation];
   // [_locationManager release];
    
    
    MKCoordinateRegion region = MKCoordinateRegionMake(selfLoc.coordinate, MKCoordinateSpanMake(0.15, 0.15));
    [self.map setRegion:region animated:YES];
    
 /*  捕获手势信息
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [_map addGestureRecognizer:mTap];
    [mTap release];
  */
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.homeLocation = newLocation;
    
    _lon.text = [NSString stringWithFormat:@"%.6lf",newLocation.coordinate.longitude];
    _lat.text = [NSString stringWithFormat:@"%.6lf",newLocation.coordinate.latitude];
    
    [_locationManager stopUpdatingLocation];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
  //  if ([annotation isKindOfClass:[Annotation class]])
    {
        static NSString* homeAnnotationIdentifier = @"HomeAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:homeAnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:homeAnnotationIdentifier] autorelease];
            customPinView.pinColor= MKPinAnnotationColorGreen;
            customPinView.canShowCallout = YES;
            customPinView.animatesDrop = YES;
            customPinView.draggable = YES;
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
/* 手势的响应函数实现
- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:_map];
    CLLocationCoordinate2D touchMapCoordinate = [_map convertPoint:touchPoint toCoordinateFromView:_map];
  
    MyAnnotation* myAno = [[MyAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake(touchMapCoordinate.latitude, touchMapCoordinate.longitude)];
    [self.map addAnnotation:myAno];
    [myAno release];
   
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_lon release];
    [_lat release];
    [_map release];
    [super dealloc];
}

- (IBAction)getMyAno:(id)sender
{
    MyAnnotation* myAno = [[MyAnnotation alloc]initWithLocation:CLLocationCoordinate2DMake(self.homeLocation.coordinate.latitude,self.homeLocation.coordinate.longitude)];
    myAno.title = @"黑";
    myAno.subtitle = @"老子的地盘!";
    [self.map addAnnotation:myAno];
    [myAno release];
}
@end
