//
//  Annotation.h
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/19.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
