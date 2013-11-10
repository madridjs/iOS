//
//  MADBackend.h
//  MadridJS
//
//  Created by Cesar Luis Valdez on 29/10/13.
//  Copyright (c) 2013 Cesar Luis Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MADMeetup.h"
#import "Constantes.h"
#import "MADEventoCalendario.h"

@class MADBackend;


@interface MADBackend : NSObject <NSCoding>

//miembros.
@property NSMutableArray *listado_eventos;
@property NSString *token;
@property NSString *refresh_token;
@property NSDate *fechaExpiracion;
@property BOOL proximoActivado;
@property int eventosPasados;
@property (nonatomic) int token_expira_segundos;


//compuestos
@property MADEventoCalendario *calendario;





-(void) getUltimosEventos:(int)numero_of_eventos;
-(void) getEventosPasados:(int)numero_of_eventos;
-(id)   initWithToken:(NSString *)tokenId;
-(void) parsearData:(NSData *)data pushHeap:(BOOL)pusheap;
-(void) revisarTokenAndRefrescar;
-(id)   initWithCodigo:(NSString *)codigo;
+(MADBackend *) iniciarDesdeFichero;

@end
