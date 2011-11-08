//
//  GreatCirclesViewController.h
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "GreatCircleArc.h"
#import "GreatCircleArcView.h"

@interface GreatCirclesViewController : UIViewController <MKMapViewDelegate> {
    MKMapView *mapView;
    
    GreatCircleArc *circle;
    GreatCircleArcView *circleView;
    
    GreatCircleArc *circle2;
    GreatCircleArcView *circleView2;
    
    GreatCircleArc *circle3;
    GreatCircleArcView *circleView3;
}


@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
