//
//  PlutoTags.m
//  PlutoProjectCreator
//
//  Created by localhome on 01/05/2015.
//  Copyright (c) 2015 Guardian News & Media. All rights reserved.
//

#import "PlutoTags.h"

@implementation PlutoTags

- (NSArray *)possibleCompletions:(NSString *)partial error:(NSError **)e;
{
    //NSLog(@"PlutoTags::possibleCompletions");
    
    if(_hostname==nil || [_hostname isEqualToString:@""]){
        if(e){
            NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Hostname not set", NSLocalizedRecoverySuggestionErrorKey, @"Cannot connect to Pluto",NSLocalizedDescriptionKey,
                                       nil];
            *e = [NSError errorWithDomain:@"PlutoTags" code:E_PARAMS userInfo:errorDict];
        }
        return nil;
    }
    NSString *urlstr = [NSString stringWithFormat:@"http://%@/gnm_tags/lookup/?stringval=%@",_hostname,[partial stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *targetURL = [NSURL URLWithString:urlstr];
    //NSLog(@"target URL is %@",targetURL);
    
    //NSURLDownload *d = [[NSURLDownload alloc] initWithRequest:[NSURLRequest requestWithURL:targetURL] delegate:nil];
    NSURLResponse *r = nil;
    NSError *downloadError = nil;
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:targetURL];
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", [d valueForKey:@"vsuser"], [d valueForKey:@"vsuser"]];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
    [theRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    //NSLog(@"sending request...");
    NSData *returnedData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&r error: &downloadError];
    
    //NSLog(@"response was %@",r);
    //NSLog(@"data was %@",returnedData);
    
    if(!d){
        NSLog(@"downloadError: %@",downloadError);
        *e = [downloadError copy];
        return nil;
    }
    if(!r){
        NSLog(@"download error - no response from server. downloadError: %@, returned data: %@",downloadError,[[NSString alloc] initWithData:returnedData encoding:NSUTF8StringEncoding]);
        *e = [downloadError copy];
        return nil;
    }
    
    NSError *parseError = nil;
    id rtn = [NSJSONSerialization JSONObjectWithData:returnedData options:0 error:&parseError];
    if(!rtn){
        NSLog(@"parseError: %@",parseError);
        *e = [parseError copy];
        return nil;
    }
    //NSLog(@"json deserialize returned %@ with value %@",[rtn class],rtn);
    //abort();
    return (NSArray *)rtn;
}
@end
