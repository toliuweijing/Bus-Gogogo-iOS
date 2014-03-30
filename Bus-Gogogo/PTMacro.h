//
//  PTMacro.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#ifndef Bus_Gogogo_PTMacro_h
#define Bus_Gogogo_PTMacro_h

#ifdef DEBUG
#   define DLogFmt(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLogFmt(...)
#endif

#endif
