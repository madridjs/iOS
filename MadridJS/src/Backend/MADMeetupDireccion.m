//
//  MADMeetupDireccion.m
//  MadridJS
//
//  Created by Cesar Luis Valdez on 02/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import "MADMeetupDireccion.h"

@implementation MADMeetupDireccion




- (id)initWithDiccionario:(NSDictionary *)venue_dicc
{
    self = [super init];
    if (self) {
        _direccion  = [venue_dicc objectForKey:@"address_1"];
        _ciudad     = [venue_dicc objectForKey:@"city"];
        _local      = [venue_dicc objectForKey:@"name"];
        _longitud   = [[venue_dicc objectForKey:@"lon"]floatValue];
        _latitud    = [[venue_dicc objectForKey:@"lat"]floatValue];
        
    }
    return self;
}

@end
