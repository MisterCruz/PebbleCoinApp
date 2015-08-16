//
//  NSString+senddata.m
//  QRReaderDemo
//
//  Created by Alex Fine on 8/16/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "senddata.h"
#import <PebbleKit/PebbleKit.h>

@implementation senddata

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* ... */
    
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    //[[PBPebbleCentral defaultPebbleCentral] connectedWatches][connectedWatches]
    /* ... */
    
    NSDictionary *update = @{ @(0):[NSNumber numberWithUint8:42],
                              @(1):@"a string" };
    [self.connectedWatch appMessagesPushUpdate:update onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
        if (!error) {
            NSLog(@"Successfully sent message.");
        }
        else {
            NSLog(@"Error sending message: %@", error);
        }
    }];
    return 0;
}

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidConnect:(PBWatch*)watch isNew:(BOOL)isNew {
    NSLog(@"Pebble connected: %@", [watch name]);
    self.connectedWatch = watch;
}

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidDisconnect:(PBWatch*)watch {
    NSLog(@"Pebble disconnected: %@", [watch name]);
    
    if (self.connectedWatch == watch || [watch isEqual:self.connectedWatch]) {
        self.connectedWatch = nil;
    }
}
@end
