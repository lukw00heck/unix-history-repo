#ifndef lint
static char sccsid[] = "@(#)dctype.c	3.1 (Berkeley) %G%";
#endif	/* not lint */

#include "dctype.h"

unsigned char dctype[192] = {
/*00*/
	D_SPACE,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
/*10*/
	D_SPACE,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	0,
	0,
	0,
	0,
/*20*/
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	D_DIGIT|D_PRINT,
	0,
	0,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
/*30*/
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
	0,
	0,
	0,
	0,
	D_PUNCT|D_PRINT,
	0,
	D_PUNCT|D_PRINT,
	0,
	0,
/*40*/
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
/*50*/
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
/*60*/
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
/*70*/
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
/*80*/
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
/*90*/
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	D_LOWER|D_PRINT,
	0,
	0,
	0,
	0,
	0,
	0,
/*A0*/
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
/*B0*/
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	D_UPPER|D_PRINT,
	0,
	0,
	0,
	0,
	D_PUNCT|D_PRINT,
	D_PUNCT|D_PRINT,
};
