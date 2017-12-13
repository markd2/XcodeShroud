#import "ShroudWindow.h"

static const CGFloat kSemiTransparentAlpha = 0.4;

@interface ShroudWindow ()
@property (assign) BOOL isSemitransparent;
@end // extension


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


- (void)mouseDown:(NSEvent *)event {
    [super mouseDown: event];

    if (event.clickCount == 2) {
        [self toggleAlpha];
    }

} // mouseDown


- (void) toggleAlpha {
    if (self.isSemitransparent) {
        [self setAlphaValue: kSemiTransparentAlpha];
    } else {
        [self setAlphaValue: 1.0];
    }

    self.isSemitransparent = !self.isSemitransparent;
} // toggleAlpha

@end // ShroudWindow
