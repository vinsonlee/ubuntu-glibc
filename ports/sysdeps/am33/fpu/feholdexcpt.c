/* Store current floating-point environment and clear exceptions.
   Copyright (C) 2000-2014 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Alexandre Oliva <aoliva@redhat.com>
   based on corresponding file in the MIPS port.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library.  If not, see
   <http://www.gnu.org/licenses/>.  */

#include <fenv.h>
#include <fpu_control.h>

int
feholdexcept (fenv_t *envp)
{
  fpu_control_t cw;

  /* Save the current state.  */
  _FPU_GETCW (cw);
  *envp = cw;

  /* Clear all exception enable bits and flags.  */
  cw &= ~(_FPU_MASK_V|_FPU_MASK_Z|_FPU_MASK_O|_FPU_MASK_U|_FPU_MASK_I);
  _FPU_SETFCW (cw);

  return 0;
}
