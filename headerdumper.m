#include <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "RTBRuntimeHeader.h"
#import "RTBClass.h"
#import "RTBProtocol.h"
#import "RTBRuntime.h"
@interface RTBDumper : NSObject
+ (void)dumpAlltoPath:(NSString*)path;
@end
@implementation RTBDumper
+ (void)dumpAlltoPath:(NSString*)path{
    RTBRuntime* _allClasses = [RTBRuntime sharedInstance];
    [_allClasses emptyCachesAndReadAllRuntimeClasses];
    NSArray *classes = [_allClasses sortedClassStubs];
    for(RTBClass *cs in classes) {
        //if([cs.stubClassname compare:@"S"] == NSOrderedAscending) continue;
        // [ms appendFormat:@"<a href=\"/classes/%@.h\">%@.h</a>\n", cs.classObjectName, cs.classObjectName];
        NSString* header = [RTBRuntimeHeader headerForClass:NSClassFromString(cs.classObjectName) displayPropertiesDefaultValues:YES];
        // printf("dumping %s.h\n",[cs.classObjectName UTF8String]);
        NSError* err;
        [header writeToFile:[NSString stringWithFormat:@"/private/var/mobile/Media/Downloads/headers/%@.h",cs.classObjectName] atomically:YES encoding:NSUTF8StringEncoding error:&err];
    }
    NSArray *protocols = [_allClasses sortedProtocolStubs];
    for(RTBProtocol *p in protocols) {
        NSString* header = [RTBRuntimeHeader headerForProtocol:p];
        // printf("dumping (protocol)%s.h\n",[p.protocolName UTF8String]);
        NSError* err;
        [header writeToFile:[NSString stringWithFormat:@"/private/var/mobile/Media/Downloads/protocols/%@.h",p.protocolName] atomically:YES encoding:NSUTF8StringEncoding error:&err];
    }
}
@end
