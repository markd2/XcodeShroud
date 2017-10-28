#import "ShroudWindow.h"

@implementation ShroudWindow

- (instancetype) initWithContentRect: (NSRect) contentRect
                           styleMask: (NSWindowStyleMask) style 
                             backing: (NSBackingStoreType) bufferingType 
                               defer: (BOOL) flag {
    self = [super initWithContentRect: contentRect
                  styleMask: NSWindowStyleMaskBorderless | NSWindowStyleMaskResizable
                  backing: NSBackingStoreBuffered
                  defer: NO];

    [self setMovableByWindowBackground: YES];
    [self setExcludedFromWindowsMenu: YES];
    [self setAlphaValue: 1.0];
    [self setOpaque: YES];
    [self setHasShadow: NO];
    [self setBackgroundColor: NSColor.blackColor];

    self.level = CGShieldingWindowLevel();
    
    return self;

} // initWithContentRect;

@end // ShroudWindow
