//
//  IPAddress.h
//  1haiiPhone
//
//  Created by ehi on 14-9-11.
//  Copyright (c) 2014年 1hai. All rights reserved.
//

#ifndef _haiiPhone_IPAddress_h
#define _haiiPhone_IPAddress_h

#define MAXADDRS    32

extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

// Function prototypes

void InitAddresses();
void FreeAddresses();
//void GetIPAddresses();
void GetHWAddresses();

#endif
