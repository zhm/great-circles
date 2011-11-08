//
//  GreatCircle.h
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import <Foundation/Foundation.h>
#import <MapKit/Mapkit.h>

@interface GreatCircleArc : NSObject <MKOverlay> {
    
}

- (id)initWithPoints:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end;

- (MKMapPoint)calculate:(double)step;

@property (readonly) double distance;

// MKOverlay methods
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;

@end
