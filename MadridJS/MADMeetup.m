//
//  MADMeetup.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 02/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADMeetup.h"

@implementation MADMeetup


- (id)initWithDiccionario:(NSDictionary *)meetu_dicc
{
    self = [super init];
    if (self) {
        _nombre             = [meetu_dicc objectForKey:@"name"];
        _identificador      = [meetu_dicc objectForKey:@"id"];
        _descripcion        = [meetu_dicc objectForKey:@"description"];
        _url                = [meetu_dicc objectForKey:@"event_url"];
        _estado             = [meetu_dicc objectForKey:@"status"];
        _personas           = [[meetu_dicc objectForKey:@"headcount"] integerValue];
        NSDictionary *venue_dicc  =  [meetu_dicc objectForKey:@"venue"];
        
        _direccion = [[MADMeetupDireccion alloc]initWithDiccionario:venue_dicc];
        
        
        double creado_sec             = [[meetu_dicc objectForKey:@"created"]doubleValue];
        double actualizado_sec        = [[meetu_dicc objectForKey:@"updated"]doubleValue];
        double tiempo_sec             = [[meetu_dicc objectForKey:@"time"]doubleValue];
        
        _actualizado = [NSDate dateWithTimeIntervalSince1970:actualizado_sec];
        _creado      = [NSDate dateWithTimeIntervalSince1970:creado_sec];
        _tiempo      = [NSDate dateWithTimeIntervalSince1970:tiempo_sec];
        
      //  [NSDate dateWithTimeIntervalSince1970:]
    }
    return self;
}

@end
