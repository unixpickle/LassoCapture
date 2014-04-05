//
//  LC1mage.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LC1mage.h"

@interface LC1mage (Private)

+ (NSMutableURLRequest *)buildRequest:(NSData *)paramData fileName:(NSString *)name;

@end

@implementation LC1mage

+ (void)startUpload:(NSImage *)image completed:(LC1mageCallback)cb {
  CGImageRef ref = [image CGImageForProposedRect:NULL context:nil hints:nil];
  NSBitmapImageRep * newRep = [[NSBitmapImageRep alloc] initWithCGImage:ref];
  [newRep setSize:[image size]];
  NSData * pngData = [newRep representationUsingType:NSPNGFileType properties:nil];

  NSMutableURLRequest * req = [self buildRequest:pngData fileName:@"flubird.png"];
  [req setURL:[NSURL URLWithString:@"http://1mage.us/upload"]];
  [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse * response,
                                             NSData * data,
                                             NSError * connectionError) {
    if (connectionError) cb(connectionError, nil);
    NSError * err = nil;
    NSDictionary * parsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (parsed) {
      NSString * urlStr = [NSString stringWithFormat:@"http://1mage.us/nav/%@", parsed[@"identifier"]];
      cb(nil, [NSURL URLWithString:urlStr]);
    } else {
      cb(err, nil);
    }
  }];
}

+ (NSMutableURLRequest *)buildRequest:(NSData *)paramData fileName:(NSString *)name {
  // from http://stackoverflow.com/questions/936855/file-upload-to-http-server-in-iphone-programming
  NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
  [request setHTTPMethod:@"POST"];
  NSString * boundary = @"---------------------------14737809831466499882746641449";
  NSString * contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
  [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
  NSMutableData * postbody = [NSMutableData data];
  [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
  [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [postbody appendData:paramData];
  [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [request setHTTPBody:postbody];
  return request;
}

@end
