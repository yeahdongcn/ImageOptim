//
//  RSImageOptimPlugin.m
//  RSImageOptimPlugin
//
//  Created by R0CKSTAR on 4/9/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSImageOptimPlugin.h"

static RSImageOptimPlugin *sharedPlugin;

@interface RSImageOptimPlugin()

@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation RSImageOptimPlugin

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static id sharedPlugin = nil;
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource acccess
        self.bundle = plugin;
        
        // Create menu items, initialize UI, etc.

        // Sample Menu Item:
        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"File"];
        if (menuItem) {
            [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
            NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Do Action" action:@selector(doMenuAction) keyEquivalent:@""];
            [actionMenuItem setTarget:self];
            [[menuItem submenu] addItem:actionMenuItem];
        }
    }
    return self;
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    NSString * path = @"/Users/R0CKSTAR/Desktop/README.txt";
    NSURL * fileURL = [NSURL fileURLWithPath: path];
    NSWorkspace * ws = [NSWorkspace sharedWorkspace];
    [ws openFile:[fileURL path] withApplication:@"ImageOptim"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
