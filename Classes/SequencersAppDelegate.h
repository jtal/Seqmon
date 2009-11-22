//
//  SequencersAppDelegate.h
//  Sequencers
//
//  Created by Justin Lolofie on 11/20/09.
//  Copyright Washington University School of Medicine 2009. All rights reserved.
//

@interface SequencersAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

