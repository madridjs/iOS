//
//  MADEventoCalendario.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 10/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "MADMeetup.h"


@interface MADEventoCalendario : NSObject <NSCoding>

@property EKEventStore *store;

@property NSString *identificador;
@property NSString *mensaje;
@property BOOL permisoConcedido;
@property NSString *error_log;


-(void)crearRecordatorio:(MADMeetup *)meet;
-(void)obtenerPermisos;
+(MADEventoCalendario *)iniciarDesdeFichero;


@end
