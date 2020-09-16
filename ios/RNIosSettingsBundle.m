
#import "RNIosSettingsBundle.h"
#import <React/RCTLog.h>

@implementation RNIosSettingsBundle
{
  bool hasListeners;
}


- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setBoolForKey:(BOOL)value key:(NSString *)key callback:(RCTResponseSenderBlock)callback) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults setBool:value forKey:key];
    callback(@[[NSNull null], @"success"]);
}

RCT_EXPORT_METHOD(boolForKey:(NSString *)key callback:(RCTResponseSenderBlock)callback) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool response = [defaults boolForKey:key];
    callback(@[[NSNull null], [NSNumber numberWithBool:response]]);
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"settingsChanged"];
}
// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
       [center addObserver:self
                  selector:@selector(defaultsChanged:)
                      name:NSUserDefaultsDidChangeNotification
                    object:nil];
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}

- (void)defaultsChanged:(NSNotification *)notification
{
   // Get the user defaults
     NSUserDefaults *defaults = (NSUserDefaults *)[notification object];

  if (hasListeners) { // Only send events if anyone is listening
      [self sendEventWithName:@"settingsChanged" body:[defaults dictionaryRepresentation]];
  }
}

@end
