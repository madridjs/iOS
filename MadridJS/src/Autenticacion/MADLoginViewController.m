//
//  MADLoginViewController.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 04/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADLoginViewController.h"

@implementation MADLoginViewController

-(void)viewDidAppear:(BOOL)animated{

    
    
    
    [super viewDidAppear:animated];

    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *autenticarURLString= [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&redirect_uri=%@", MEETUP_AUTHENTICATE_URL, MEETUP_CLIENT_ID, MEETUP_REDIRECT_URI];
    
    NSLog(@"url-> %@",autenticarURLString);
    
    
    
    NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:autenticarURLString]];

    
    
    
    self.navegadorWeb.delegate = self;
    
    [self.navegadorWeb loadRequest:webRequest];

    
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType{
    

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"%@", request.URL);
    if([[request.URL host] isEqualToString:@"www.madridjs.org"]){
        
        
        NSDictionary *params = [[MADUtil leerUrlParametros:request.URL.absoluteString] copy];
        NSString *codigo = [params objectForKey:@"code"];
        MADBackend *backend = [[MADBackend alloc] initWithCodigo:codigo];
        
        
        if ([self.delegado respondsToSelector:@selector(setBackend:)]) {
            [self.delegado setValue:backend forKey:@"backend"];
        }else{
            
            NSLog(@"Error inyectando dependencia. [revisar]");
        }
        
        NSLog(@"hemos recuperado el toke [continuar]");
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    return  YES;
}


@end
