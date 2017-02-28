//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPAddress.h"
@interface UIDevice (IdentifierAddition)

/*


 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */
- (NSString *) macaddress;
- (NSString *) deviceIdentifier;

/*

 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */

- (NSString *)deviceIPAddress;
-(NSDictionary *)getIPAddresses;

@end
