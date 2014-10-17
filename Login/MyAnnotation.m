//
//  Annotation.m
//  Login
//
//  Created by Ge-Yunsheng on 2014/09/19.
//
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate = _coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        _coordinate = coord;
    }
    return self;
}

@end
