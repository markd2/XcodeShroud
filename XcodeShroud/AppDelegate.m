//
//  AppDelegate.m
//  XcodeShroud
//
//  Created by markd on 10/28/17.
//  Copyright © 2017 Borkware. All rights reserved.
//

#import "AppDelegate.h"
#import "ShroudWindow.h"

@interface AppDelegate ()
@property (strong) IBOutlet ShroudWindow *window;
@end // extension


@implementation AppDelegate

- (void) addWorkspaceHooks {
    NSWorkspace *workspace = NSWorkspace.sharedWorkspace;

    NSNotificationCenter *center = workspace.notificationCenter;

    [center addObserver: self
            selector: @selector(handleDidActivateApplication:)
            name: NSWorkspaceDidActivateApplicationNotification
            object: nil];

#if SPY_ON_WORKSPACE_NOTIFICATIONS
    [center addObserver: self
            selector: @selector(handleWorkspaceNotification:)
            name: nil  object: nil];
#endif

}// addWorkspaceHooks


- (void) show {
    if (self.window.visible) return;
    [self.window makeKeyAndOrderFront: self];
} // show


- (void) hide {
    if (!self.window.visible) return;
    [self.window orderOut: self];
} // hide


- (void) handleDidActivateApplication: (NSNotification *) notification {
    NSDictionary *info = notification.userInfo;
    NSRunningApplication *app = info[NSWorkspaceApplicationKey];

    NSArray *bundlesToShroud = @[
         @"com.apple.dt.Xcode",  // the source of all this pain
         @"com.apple.finder",   // to make it easy to get a clickable shroud back
         @"com.borkware.XcodeShroud"
    ];

    if ([bundlesToShroud containsObject: app.bundleIdentifier]) {
        [self show];
    } else {
        [self hide];
    }

} // handleDidActivateApplication


- (void) handleWorkspaceNotification: (NSNotification *) notification {
    NSLog(@"%@ %@", notification.name, notification.userInfo);
} // handleWorkspaceNotification


- (void) applicationDidFinishLaunching: (NSNotification *) aNotification {
    [self addWorkspaceHooks];
} // applicationDidFinishLaunching


- (void) applicationWillTerminate: (NSNotification *) aNotification {
} // applicationWillTerminate


@end


