//
//  MADMeetupDireccion.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 02/11/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADMeetupDireccion : NSObject


@property NSString *direccion;
@property NSString *ciudad;
@property NSString *local;
@property float longitud;
@property float latitud;
- (id)initWithDiccionario:(NSDictionary *)venue_dicc;

@end
