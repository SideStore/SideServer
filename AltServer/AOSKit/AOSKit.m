#import <Foundation/Foundation.h>
#import "AOSKit.h"

@implementation AOSKit

+ (ALTAnisetteData *)getAnisetteData {

  AKDevice *device = [AKDevice currentDevice];
  id headers = [AOSUtilities retrieveOTPHeadersForDSID:@"-2"];

  NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
  NSString *dateString = [formatter stringFromDate:[NSDate date]];

  NSDictionary *dict = @{
    @"date" : dateString,
    @"oneTimePassword" : [headers valueForKey:@"X-Apple-MD"],
    @"localUserID" : [device localUserUUID],
    @"machineID" : [headers valueForKey:@"X-Apple-MD-M"],
    @"routingInfo" : @"0",
    @"deviceSerialNumber" : [AOSUtilities machineSerialNumber],
    @"timeZone" : [[NSTimeZone systemTimeZone] abbreviation],
    @"locale" : [[device locale] localeIdentifier],
    @"deviceDescription" : [device serverFriendlyDescription],
    @"deviceUniqueIdentifier" : [device uniqueDeviceIdentifier]
  };
    
    ALTAnisetteData *data = [[ALTAnisetteData alloc] initWithJSON:dict];
    return data;
}

@end
