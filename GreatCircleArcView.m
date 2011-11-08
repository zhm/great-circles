//
//  GreatCircleView.m
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import "GreatCircleArcView.h"


@implementation GreatCircleArcView
@synthesize lineWidth = _lineWidth;
@synthesize numPoints = _numPoints;
@synthesize color = _color;

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    CGMutablePathRef arc = NULL;
    
    double delta = 1.0 / MAX(self.numPoints - 1, 1);
    
    GreatCircleArc* circle = (GreatCircleArc *)self.overlay;

    MKMapPoint firstPoint, lastPoint, prevPoint;
    MKMapRect world = MKMapRectWorld;
    
    for (int i = 0; i < self.numPoints; ++i) {
        double step = delta * i;
        
        MKMapPoint arcPoint = [circle calculate:step];
        
        // save the first and last points so we can draw the extra circles
        if (i == 0) {
            arc = CGPathCreateMutable();
            prevPoint = firstPoint = arcPoint;
            CGPathMoveToPoint(arc, NULL, arcPoint.x, arcPoint.y);
        } else if (i == self.numPoints - 1) {
            lastPoint = arcPoint;
        }
        
        // detect the special case of crossing the 0 longitude (in map points) and move the pen to other end of the map
        if ((prevPoint.x + (world.size.width - arcPoint.x)) < fabs(arcPoint.x - prevPoint.x)) {
            CGPathMoveToPoint(arc, NULL, arcPoint.x, arcPoint.y);
        }
        
        CGPathAddLineToPoint(arc, NULL, arcPoint.x, arcPoint.y);
        
        prevPoint = arcPoint;
    }
    
    CGFloat lineWidthInWorldSpace = MAX(self.lineWidth, 1.0) * (1.0 / zoomScale);
    CGFloat circleRadius = 15.0 * (1.0 / zoomScale);
    
    if (!self.color) 
        self.color = [UIColor blueColor];
    
    CGContextSaveGState(context);
    
    // draw the circle fills at the start/end points
    CGContextSetAlpha(context, 0.3);
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(lastPoint.x - circleRadius, lastPoint.y - circleRadius, circleRadius * 2.0, circleRadius * 2.0));
    CGContextFillEllipseInRect(context, CGRectMake(firstPoint.x - circleRadius, firstPoint.y - circleRadius, circleRadius * 2.0, circleRadius * 2.0));
    
    // draw the borders on the start/end circles
    CGContextSetAlpha(context, 0.8);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetLineWidth(context, 1.0 / zoomScale);
    CGContextStrokeEllipseInRect(context, CGRectMake(lastPoint.x - circleRadius, lastPoint.y - circleRadius, circleRadius * 2.0, circleRadius * 2.0));
    CGContextStrokeEllipseInRect(context, CGRectMake(firstPoint.x - circleRadius, firstPoint.y - circleRadius, circleRadius * 2.0, circleRadius * 2.0));
    
    // draw the actual great circle arc
    CGContextAddPath(context, arc);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidthInWorldSpace);
    CGContextSetAlpha(context, 0.7);
    CGContextStrokePath(context);
    CGPathRelease(arc);
    
    CGContextRestoreGState(context);
}

@end
