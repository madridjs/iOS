//
//  MADBackend.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADBackend.h"






@implementation MADBackend


@synthesize token_expira_segundos = _token_expira_segundos;

- (id)initWithToken:(NSString *)tokenId
{
    self = [super init];
    if (self) {
        _token = tokenId;
        _listado_eventos = [[NSMutableArray alloc] init];
    }
    return self;
}


- (id)initWithCodigo:(NSString *)codigo
{
    self = [super init];
    if (self) {
        
        
        NSString *autenticarURLString= [NSString stringWithFormat:@"%@?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@", MEETUP_ACCESS_URL, MEETUP_CLIENT_ID, MEETUP_CLIENT_SECRET, MEETUP_REDIRECT_URI,codigo];
        
        
   
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[[NSURL alloc] initWithString:autenticarURLString]
                                        cachePolicy:NSURLRequestUseProtocolCachePolicy
                                        timeoutInterval:60.0];
        
        [request setHTTPMethod:@"POST"];
        
        NSURLResponse* response;
        NSError* error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        
        NSDictionary *parsed_data = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&error];
        
        _token = [parsed_data objectForKey:@"access_token"];
        self.token_expira_segundos = [[parsed_data objectForKey:@"expires_in"] integerValue];
        _refresh_token = [parsed_data objectForKey:@"refresh_token"];
        _listado_eventos = [[NSMutableArray alloc] init];
       
        [self guardarToken];
    }
    return self;
}




#pragma mark NSCoding

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_token                 forKey:kToken];
    [aCoder encodeObject:_refresh_token         forKey:kRefreshToken];
    [aCoder encodeObject:self.fechaExpiracion   forKey:kexpiracion];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    _token                  = [aDecoder decodeObjectForKey:kToken];
    _refresh_token          = [aDecoder decodeObjectForKey:kRefreshToken];
    self.fechaExpiracion    = [aDecoder decodeObjectForKey:kexpiracion];
    
    _listado_eventos = [[NSMutableArray alloc] init];
    
    return [self initWithToken:_token];
}

-(void)guardarToken{
    
    if (self) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"config.txt"];
        [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    }else{
        
        NSLog(@"No hay backend inicializado error grave");
        NSAssert1(!self, @"error grave [intentar guardar undefined toke] : %@",self);
    }
    
}


+(MADBackend *)iniciarDesdeFichero{
    
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"config.txt"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


-(NSString *)restAPI:(NSString *)method{
    
    return [NSString stringWithFormat:@"%@%@",MEETUP_ROOT_API,method];
    
}


-(void)setToken_expira_segundos:(int)token_expira_segundos{
    
    
    _fechaExpiracion = [[NSDate alloc]init];

    
   _fechaExpiracion = [_fechaExpiracion dateByAddingTimeInterval:token_expira_segundos];

    _token_expira_segundos = token_expira_segundos;
    
}

-(void)revisarTokenAndRefrescar{
    
    NSDate *tiempoActual = [[NSDate alloc]init];
    
    
   if ([tiempoActual compare:self.fechaExpiracion] == NSOrderedDescending) {
       
          NSString *autenticarURLString= [NSString stringWithFormat:@"%@?client_id=%@&client_secret=%@&grant_type=refresh_token&refresh_token=%@", MEETUP_REFRESH_TOKEN_URL, MEETUP_CLIENT_ID, MEETUP_CLIENT_SECRET, self.refresh_token];
          
          
          
          NSLog(@"auth: %@", autenticarURLString);
          
          NSMutableURLRequest *request = [NSMutableURLRequest
                                          requestWithURL:[[NSURL alloc] initWithString:autenticarURLString]
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
          
          [request setHTTPMethod:@"POST"];
          
          NSURLResponse* response;
          NSError* error;
          
          NSData *data = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&error];
          
       
          
          NSDictionary *parsed_data = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
  
          _token = [parsed_data objectForKey:@"access_token"];
          self.token_expira_segundos = [[parsed_data objectForKey:@"expires_in"] integerValue];
          _refresh_token = [parsed_data objectForKey:@"refresh_token"];
          
          [self guardarToken];

     }
     
    
    
   // return YES;
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


    
    NSString *tmpUrl = [self restAPI:MEETUP_EVENTS_GET];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    //production:  madridjs
    //devel:    ny-tech
    //MEETUP_GRUPO_NOMBRE
    [param setObject:@"true" forKey:@"sign"];
    [param setObject:MEETUP_GRUPO_NOMBRE forKey:@"group_urlname"];
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



/*
 
 getEventosPasados:(int)numero_of_eventos
 
 recupera una cantidad de eventos pasados determinado.
 
 numero_of_eventos: numero de eventos.
 
 
 */

-(void)getEventosPasados:(int)numero_of_eventos{


    NSURLResponse* response;
    NSError* error = nil;
    
    [self revisarTokenAndRefrescar];
    
    
    self.eventosPasados += numero_of_eventos;
    NSURLRequest *request = [self recuperarEventoUsandoTiempo:@"past" cantidad:self.eventosPasados];
    
    

    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    
    
    
    
    [self parsearData:data pushHeap:NO];

}



/*
 
 -(void)getUltimosEventos:(int)numero_of_eventos
 
 recupera una cantidad de eventos futuros determinado.
 
 numero_of_eventos: numero de eventos.
 
 
 */

-(void)getUltimosEventos:(int)numero_of_eventos{

    
    
    NSURLResponse* response;
    NSError* error = nil;
    
    [self revisarTokenAndRefrescar];
    
    NSURLRequest *request = [self recuperarEventoUsandoTiempo:@"upcoming" cantidad:numero_of_eventos];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&response
                                                              error:&error];

    
    [self parsearData:data pushHeap:YES];
    
    
    
}



/*
 
-(void)parsearData:(NSData *)data
 
 lee la informacion JSON y la convierte en objetos MADMeetup.
 
 */

-(void)parsearData:(NSData *)data pushHeap:(BOOL)pusheap{


    NSError *error = nil;

    NSDictionary *parsed_data = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
    
    
    
    NSMutableArray *listadoEventosTemp = [[NSMutableArray alloc]init];
    
    NSArray *eventos =  [parsed_data objectForKey:@"results"];
    
    
    
    
    for (NSDictionary *diccs in eventos) {
        
        MADMeetup *meetup = [[MADMeetup alloc]initWithDiccionario:diccs];

         if (![self.listado_eventos containsObject:meetup]) {
            [listadoEventosTemp addObject:meetup];

         }
    }
    

    if (pusheap) {
        [listadoEventosTemp addObjectsFromArray:self.listado_eventos];
        self.listado_eventos = listadoEventosTemp;
    }else if (listadoEventosTemp.count >0){
        [self.listado_eventos addObjectsFromArray:listadoEventosTemp];
    }
    
    
    

}


@end
