/* ===-- powidf2.cpp - Implement __powidf2 ---------------------------------===
 *
 *                     The LLVM Compiler Infrastructure
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *
 * ===----------------------------------------------------------------------===
 *
 * This file implements __powidf2 for the compiler_rt library.
 *
 * ===----------------------------------------------------------------------===
 */

#include "int_lib.h"

/* Returns: a ^ b */

double
__powidf2(double a, si_int b)
{
    const int recip = b < 0;
    double r = 1;
    while (1)
    {
        if (b & 1)
            r *= a;
        b /= 2;
        if (b == 0)
            break;
        a *= a;
    }
    return recip ? 1/r : r;
}
