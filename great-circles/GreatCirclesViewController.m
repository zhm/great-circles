//
//  GreatCirclesViewController.m
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import "GreatCirclesViewController.h"

@implementation GreatCirclesViewController
@synthesize mapView;

- (void)dealloc {
    [mapView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    //circle 1 - Tampa -> Kabul
    CLLocationCoordinate2D start = CLLocationCoordinate2DMake(27.9472222, -82.4586111);
    CLLocationCoordinate2D end   = CLLocationCoordinate2DMake(34.5166667, 69.1833333);
    circle = [[[GreatCircleArc alloc] initWithPoints:start end:end] autorelease];
    [self.mapView addOverlay:circle];
    
    //circle 2 - Rio -> Tokyo
    CLLocationCoordinate2D start2 = CLLocationCoordinate2DMake(-22.9, -43.2333333);
    CLLocationCoordinate2D end2   = CLLocationCoordinate2DMake(35.685, 139.7513889);
    circle2 = [[[GreatCircleArc alloc] initWithPoints:start2 end:end2] autorelease];
    [self.mapView addOverlay:circle2];
    
    //circle 3 - Toronto -> NULL ISLAND
    CLLocationCoordinate2D start3 = CLLocationCoordinate2DMake(43.666667, -79.416667);
    CLLocationCoordinate2D end3   = CLLocationCoordinate2DMake(0.0, 0.0);
    circle3 = [[[GreatCircleArc alloc] initWithPoints:start3 end:end3] autorelease];
    [self.mapView addOverlay:circle3];
}


- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    GreatCircleArcView *overlayView = nil;
    
    if (overlay == circle) {
        if (!circleView) {
            circleView = [[[GreatCircleArcView alloc] initWithOverlay:overlay] autorelease];
            circleView.numPoints = 100;
        }
        
        overlayView = circleView;
    } else if (overlay == circle2) {
        if (!circleView2) {
            circleView2 = [[[GreatCircleArcView alloc] initWithOverlay:overlay] autorelease];
            circleView2.numPoints = 500; //this is a LONG route
            circleView2.color = [UIColor redColor];
        }
        
        overlayView = circleView2;
    } else if (overlay == circle3) {
        if (!circleView3) {
            circleView3 = [[[GreatCircleArcView alloc] initWithOverlay:overlay] autorelease];
            circleView3.numPoints = 100;
            circleView3.color = [UIColor greenColor];
        }
        
        overlayView = circleView3;
    }
    
    // make the arc line width always 6 pixels
    overlayView.lineWidth = 6.0;
        
    return overlayView;
}

@end
