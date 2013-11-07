//
//  MADLoginViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADLoginViewController.h"

@implementation MADLoginViewController

#define MEETUP_AUTHENTICATE_URL @"https://secure.meetup.com/oauth2/authorize"

#define MEETUP_CLIENT_ID @"u4ts648g220dch7tppat121i2r"

#define MEETUP_CLIENT_SECRET @"4a01f783b381733772e444a6b1873b"

#define MEETUP_REDIRECT_URI @"http://www.madridjs.org"

#define MEETUP_PARAMETER_TOKEN @"access_token"


-(void)viewDidAppear:(BOOL)animated{

    
    
    
    [super viewDidAppear:animated];

    
    
    NSString *autenticarURLString= [NSString stringWithFormat:@"%@?client_id=%@&response_type=token&redirect_uri=%@", MEETUP_AUTHENTICATE_URL, MEETUP_CLIENT_ID, MEETUP_REDIRECT_URI];
    
    NSLog(@"url-> %@",autenticarURLString);
    
    
    
    NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:autenticarURLString]];

    
    
    
    self.navegadorWeb.delegate = self;
    
    [self.navegadorWeb loadRequest:webRequest];

    
    
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
                
                
                if ([self.delegado respondsToSelector:@selector(setBackend:)]) {
                      [self.delegado setValue:backend forKey:@"backend"];
                }else{
                
                    NSLog(@"Error inyectando dependencia. [revisar]");
                }
                
                
                //[self performSegueWithIdentifier:@"eventos" sender:self];
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
            }
            
        }
        
    }
    return  YES;
}


@end
