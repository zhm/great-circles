//
//  GreatCircleView.h
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GreatCircleArc.h"

@interface GreatCircleArcView : MKOverlayView {
    
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context;

@property (readwrite, assign) CGFloat lineWidth;
@property (readwrite, assign) int numPoints;
@property (readwrite, retain) UIColor *color;

@end
