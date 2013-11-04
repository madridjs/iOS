//
//  MADLoginViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADLoginViewController.h"

@implementation MADLoginViewController


#define MEETUP_PARAMETER_TOKEN @"access_token"

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    self.navegadorWeb.delegate = self;
    
    [self.navegadorWeb loadData:self.datos
                       MIMEType: @"text/html"
               textEncodingName: @"UTF-8" baseURL:nil];

    
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSLog(@"request-> %@",[request.URL host]);
    
    
    if([[request.URL host] isEqualToString:@"www.madridjs.org"]){
        
        NSString *URLString = [[request URL] absoluteString];
        
        if ([URLString rangeOfString:@"access_token="].location != NSNotFound) {
            
            NSString *URLString = [[request URL] absoluteString];
            
            if ([URLString rangeOfString:@"access_token="].location != NSNotFound) {
                
                NSString *accessToken = [[URLString componentsSeparatedByString:@"="] lastObject];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:accessToken forKey:MEETUP_PARAMETER_TOKEN];
                
                [defaults synchronize];
                
                MADBackend *backend = [[MADBackend alloc] initWithToken:accessToken];
                [backend getUltimosEventos:10];
                
                if ([self.delegado respondsToSelector:@selector(setBackend:)]) {
                      [self.delegado setValue:backend forKey:@"backend"];
                }else{
                
                    NSLog(@"Error inyectando dependencia. [revisar]");
                }
                
                
                [self performSegueWithIdentifier:@"eventos" sender:self];
                
                
                
            }
            
        }
        
    }
    return  YES;
}


@end
