//
//  GreatCircle.m
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import "GreatCircleArc.h"

@interface GreatCircleArc ()
@property (readwrite, assign) CLLocationCoordinate2D start;
@property (readwrite, assign) CLLocationCoordinate2D end;
@property (readwrite, assign) CGPoint startPoint;
@property (readwrite, assign) CGPoint endPoint;
@property (readwrite, assign) double distance;
@end

@implementation GreatCircleArc

@synthesize start = _start;
@synthesize end = _end;
@synthesize startPoint = _startPoint;
@synthesize endPoint = _endPoint;
@synthesize distance = _distance;

- (id)initWithPoints:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end {
    self = [super init];
    
    if (self) {
        _start = start;
        _end = end;
        _startPoint = CGPointMake(start.longitude * (M_PI / 180.0), start.latitude * (M_PI / 180.0));
        _endPoint = CGPointMake(end.longitude * (M_PI / 180.0), end.latitude * (M_PI / 180.0));
        
        double diffX = _startPoint.x - _endPoint.x;
        double diffY = _startPoint.y - _endPoint.y;
        
        // http://en.wikipedia.org/wiki/Great-circle_distance
        double z = 
            pow(sinf(diffY / 2.0), 2) + 
            cos(self.startPoint.y) *
            cos(self.endPoint.y) *
            pow(sin(diffX / 2.0), 2);
        
        _distance = 2.0 * sin(sqrt(z));
    }
    
    return self;
}

- (MKMapPoint)calculate:(double)step {
    // http://williams.best.vwh.net/avform.htm#Intermediate
    // https://github.com/springmeyer/arc.js
    
    double A = sin((1 - step) * self.distance) / sin(self.distance);
    double B = sin(step * self.distance) / sin(self.distance);
    double x = A * cos(self.startPoint.y) * cos(self.startPoint.x) + B * cos(self.endPoint.y) * cos(self.endPoint.x);
    double y = A * cos(self.startPoint.y) * sin(self.startPoint.x) + B * cos(self.endPoint.y) * sin(self.endPoint.x);
    double z = A * sin(self.startPoint.y) + B * sin(self.endPoint.y);
    double latitude  = (180 / M_PI) * atan2(z, sqrt(pow(x, 2) + pow(y, 2)));
    double longitude = (180 / M_PI) * atan2(y, x);
    
    return MKMapPointForCoordinate(CLLocationCoordinate2DMake(latitude, longitude));    
}


- (MKMapRect)boundingMapRect {
    return MKMapRectWorld;
}

- (CLLocationCoordinate2D)coordinate {
    return _start;
}

@end
