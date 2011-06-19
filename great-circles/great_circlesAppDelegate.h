//
//  great_circlesAppDelegate.h
//  great-circles
//
//  Created by Zac McCormick on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class great_circlesViewController;

@interface great_circlesAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet great_circlesViewController *viewController;

@end
