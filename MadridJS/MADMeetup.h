//
//  MADMeetup.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 02/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADMeetupDireccion.h"

@interface MADMeetup : NSObject

@property NSString              *identificador;
@property NSString              *nombre;
@property NSString              *descripcion;
@property NSDate                *creado;
@property NSDate                *actualizado;
@property NSDate                *tiempo;
@property NSURL                 *url;
@property NSString              *estado;
@property int                   personas;
@property MADMeetupDireccion    *direccion;


- (id)initWithDiccionario:(NSDictionary *)meetu_dicc;


@end
