//
//  GreatCirclesAppDelegate.h
//  great-circles
//
//  Created by Zac McCormick on 6/18/11.
//

#import <UIKit/UIKit.h>

@class GreatCirclesViewController;

@interface GreatCirclesAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GreatCirclesViewController *viewController;

@end
