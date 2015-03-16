/* Copyright (C) 1991-2015 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#include <libioP.h>
#include <stdarg.h>
#include <stdio.h>
#include <wchar.h>

/* Write formatted output to stdout from the format string FORMAT.  */
/* VARARGS1 */
int
__wprintf (const wchar_t *format, ...)
{
  va_list arg;
  int done;

  va_start (arg, format);
  done = __vfwprintf (stdout, format, arg);
  va_end (arg);

  return done;
}
ldbl_strong_alias (__wprintf, wprintf)
