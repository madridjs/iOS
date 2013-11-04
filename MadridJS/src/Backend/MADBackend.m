//
//  MADBackend.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADBackend.h"

@implementation MADBackend




- (id)initWithToken:(NSString *)tokenId
{
    self = [super init];
    if (self) {
        _token = tokenId;
        _listado_eventos = [[NSMutableArray alloc]init];
    }
    return self;
}


#define MEETUP_ROOT_API     @"https://api.meetup.com"
#define MEETUP_EVENTS_GET   @"/2/events"


-(NSString *)getRESTAPI:(NSString *)method{
    
    return [NSString stringWithFormat:@"%@%@",MEETUP_ROOT_API,method];
    
}


-(NSString *) crearPeticionRestWithUrl:(NSString *) url  parametros:(NSDictionary*)parametros{
    
    NSMutableString *path = [[NSMutableString alloc]initWithString:url];
    
    [path appendString:@"?"];
    for (NSString *param in [parametros allKeys]) {
        
        [path appendString:@"&"];
        [path appendString:param];
        [path appendString:@"="];
        [path appendString:parametros[param]];
        
    }
    
    return path;
}


-(void)getUltimosEventos:(int)numero_of_Eventos{

    NSString *tmpUrl = [self getRESTAPI:MEETUP_EVENTS_GET];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
 
    [param setObject:@"true" forKey:@"sign"];
    [param setObject:@"madridjs" forKey:@"group_urlname"];
    [param setObject:@"10" forKey:@"page"];
    [param setObject:@"past" forKey:@"status"];
    
    NSString *direccionURL = [self crearPeticionRestWithUrl:tmpUrl parametros:param];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:direccionURL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", self.token];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    
    /*
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
        
        [self parsearData:data];
        
    }
    ];*/
    
    NSURLResponse* response;
    NSError* error = nil;
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&response
                                                              error:&error];

    [self parsearData:data];
}


-(void)parsearData:(NSData *)data{


    NSError *error = nil;

    NSDictionary *parsed_data = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
    
    
    NSArray *eventos =  [parsed_data objectForKey:@"results"];
    
    for (NSDictionary *diccs in eventos) {
        
        MADMeetup *meetup = [[MADMeetup alloc]initWithDiccionario:diccs];
        [self.listado_eventos addObject:meetup];
        
    }

}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [self parsearData:data];

}

@end
