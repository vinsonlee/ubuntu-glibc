/* Tests for AVX2 ISA versions of vector math functions.
   Copyright (C) 2014-2015 Free Software Foundation, Inc.
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

#include "test-double-vlen4.h"

#undef VEC_SUFF
#define VEC_SUFF _vlen4_avx2

#define TEST_VECTOR_cos 1
#define TEST_VECTOR_sin 1
#define TEST_VECTOR_sincos 1
#define TEST_VECTOR_log 1
#define TEST_VECTOR_exp 1
#define TEST_VECTOR_pow 1

#define REQUIRE_AVX2

#include "libm-test.c"
