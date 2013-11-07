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



/*
 recuperarEventoUsandoTiempo
 
 
  tiempo_evento: 
    valores aceptados]
        @"past"
        @"incoming"
        @"draft"
 */

-(NSMutableURLRequest *)recuperarEventoUsandoTiempo:(NSString * )tiempo_evento cantidad:(int)cantidad{


    
    NSString *tmpUrl = [self getRESTAPI:MEETUP_EVENTS_GET];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    //production:  madridjs
    //devel:    ny-tech
    [param setObject:@"true" forKey:@"sign"];
    [param setObject:@"ny-tech" forKey:@"group_urlname"];
    [param setObject:[NSString stringWithFormat:@"%d",cantidad] forKey:@"page"];
    [param setObject:tiempo_evento forKey:@"status"];
    [param setObject:@"desc" forKey:@"desc"];
    
    
    NSString *direccionURL = [self crearPeticionRestWithUrl:tmpUrl parametros:param];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:direccionURL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", self.token];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];

    
    return request;
}


-(void)getEventosPasados:(int)numero_of_eventos{


    NSURLResponse* response;
    NSError* error = nil;
    
    NSURLRequest *request = [self recuperarEventoUsandoTiempo:@"past" cantidad:numero_of_eventos];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    [self parsearData:data];

}





-(void)getUltimosEventos:(int)numero_of_eventos{

    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSURLRequest *request = [self recuperarEventoUsandoTiempo:@"upcoming" cantidad:numero_of_eventos];
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
