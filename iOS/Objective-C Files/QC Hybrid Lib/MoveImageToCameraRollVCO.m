//
//  MoveImageToCameraRollVCO.m
//  QC Hybrid Lib
//
//  Created by Lee Barney on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveImageToCameraRollVCO.h"
#import "SBJSON.h"
#import "QuickConnectViewController.h"
#import "DeviceWebView.h"


@implementation MoveImageToCameraRollVCO

+ (BOOL) handleIt:(NSMutableDictionary*) dictionary{
    //add the execution the list and the key in to send them back to the JavaScript
    NSArray *list = dictionary[@"BCOresults"][0];
    NSString *executionKey = dictionary[@"parameters"][2][0];
    
    NSArray *retVal = @[list, 
                       executionKey];
    
    NSError *genError;
    SBJSON *generator = [SBJSON alloc];
    NSString *dataString = [generator stringWithObject:retVal error:&genError];
   
    dataString = [dataString stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"&" withString:@"\\&"];
    NSString *jsString = [[NSString alloc] initWithFormat:@"handleRequestCompletionFromNative('%@')", dataString];
    QuickConnectViewController *controller = dictionary[@"parameters"][0];
    [controller.webView stringByEvaluatingJavaScriptFromString:jsString];
   
    return QC_STACK_EXIT;
}
@end
