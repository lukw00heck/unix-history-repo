/*
 * Copyright (c) 1980 Regents of the University of California.
 * All rights reserved.  The Berkeley software License Agreement
 * specifies the terms and conditions for redistribution.
 *
 *	@(#)r_sinh.c	5.1	%G%
 */

double r_sinh(x)
float *x;
{
double sinh();
return( sinh(*x) );
}
