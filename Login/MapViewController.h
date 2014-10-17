//
//  MapViewController.h
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/19.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *lon;
@property (retain, nonatomic) IBOutlet UILabel *lat;
@property (retain, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic,retain) CLLocationManager* locationManager;
@property (nonatomic,retain) CLLocation* homeLocation;


- (IBAction)getMyAno:(id)sender;

@end
