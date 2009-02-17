/* x86_64 cache info.
   Copyright (C) 2003, 2004, 2006, 2007 Free Software Foundation, Inc.
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
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.
*/

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>

static const struct intel_02_cache_info
{
  unsigned int idx;
  int name;
  long int size;
  long int assoc;
  long int linesize;
} intel_02_known [] =
  {
    { 0x06, _SC_LEVEL1_ICACHE_SIZE,    8192,  4, 32 },
    { 0x08, _SC_LEVEL1_ICACHE_SIZE,   16384,  4, 32 },
    { 0x0a, _SC_LEVEL1_DCACHE_SIZE,    8192,  2, 32 },
    { 0x0c, _SC_LEVEL1_DCACHE_SIZE,   16384,  4, 32 },
    { 0x22, _SC_LEVEL3_CACHE_SIZE,   524288,  4, 64 },
    { 0x23, _SC_LEVEL3_CACHE_SIZE,  1048576,  8, 64 },
    { 0x25, _SC_LEVEL3_CACHE_SIZE,  2097152,  8, 64 },
    { 0x29, _SC_LEVEL3_CACHE_SIZE,  4194304,  8, 64 },
    { 0x2c, _SC_LEVEL1_DCACHE_SIZE,   32768,  8, 64 },
    { 0x30, _SC_LEVEL1_ICACHE_SIZE,   32768,  8, 64 },
    { 0x39, _SC_LEVEL2_CACHE_SIZE,   131072,  4, 64 },
    { 0x3a, _SC_LEVEL2_CACHE_SIZE,   196608,  6, 64 },
    { 0x3b, _SC_LEVEL2_CACHE_SIZE,   131072,  2, 64 },
    { 0x3c, _SC_LEVEL2_CACHE_SIZE,   262144,  4, 64 },
    { 0x3d, _SC_LEVEL2_CACHE_SIZE,   393216,  6, 64 },
    { 0x3e, _SC_LEVEL2_CACHE_SIZE,   524288,  4, 64 },
    { 0x3f, _SC_LEVEL2_CACHE_SIZE,   262144,  2, 64 },
    { 0x41, _SC_LEVEL2_CACHE_SIZE,   131072,  4, 32 },
    { 0x42, _SC_LEVEL2_CACHE_SIZE,   262144,  4, 32 },
    { 0x43, _SC_LEVEL2_CACHE_SIZE,   524288,  4, 32 },
    { 0x44, _SC_LEVEL2_CACHE_SIZE,  1048576,  4, 32 },
    { 0x45, _SC_LEVEL2_CACHE_SIZE,  2097152,  4, 32 },
    { 0x46, _SC_LEVEL3_CACHE_SIZE,  4194304,  4, 64 },
    { 0x47, _SC_LEVEL3_CACHE_SIZE,  8388608,  8, 64 },
    { 0x48, _SC_LEVEL2_CACHE_SIZE,  3145728, 12, 64 },
    { 0x49, _SC_LEVEL2_CACHE_SIZE,  4194304, 16, 64 },
    { 0x4a, _SC_LEVEL3_CACHE_SIZE,  6291456, 12, 64 },
    { 0x4b, _SC_LEVEL3_CACHE_SIZE,  8388608, 16, 64 },
    { 0x4c, _SC_LEVEL3_CACHE_SIZE, 12582912, 12, 64 },
    { 0x4d, _SC_LEVEL3_CACHE_SIZE, 16777216, 16, 64 },
    { 0x4e, _SC_LEVEL2_CACHE_SIZE,  6291456, 24, 64 },
    { 0x60, _SC_LEVEL1_DCACHE_SIZE,   16384,  8, 64 },
    { 0x66, _SC_LEVEL1_DCACHE_SIZE,    8192,  4, 64 },
    { 0x67, _SC_LEVEL1_DCACHE_SIZE,   16384,  4, 64 },
    { 0x68, _SC_LEVEL1_DCACHE_SIZE,   32768,  4, 64 },
    { 0x78, _SC_LEVEL2_CACHE_SIZE,  1048576,  8, 64 },
    { 0x79, _SC_LEVEL2_CACHE_SIZE,   131072,  8, 64 },
    { 0x7a, _SC_LEVEL2_CACHE_SIZE,   262144,  8, 64 },
    { 0x7b, _SC_LEVEL2_CACHE_SIZE,   524288,  8, 64 },
    { 0x7c, _SC_LEVEL2_CACHE_SIZE,  1048576,  8, 64 },
    { 0x7d, _SC_LEVEL2_CACHE_SIZE,  2097152,  8, 64 },
    { 0x7f, _SC_LEVEL2_CACHE_SIZE,   524288,  2, 64 },
    { 0x82, _SC_LEVEL2_CACHE_SIZE,   262144,  8, 32 },
    { 0x83, _SC_LEVEL2_CACHE_SIZE,   524288,  8, 32 },
    { 0x84, _SC_LEVEL2_CACHE_SIZE,  1048576,  8, 32 },
    { 0x85, _SC_LEVEL2_CACHE_SIZE,  2097152,  8, 32 },
    { 0x86, _SC_LEVEL2_CACHE_SIZE,   524288,  4, 64 },
    { 0x87, _SC_LEVEL2_CACHE_SIZE,  1048576,  8, 64 },
  };

#define nintel_02_known (sizeof (intel_02_known) / sizeof (intel_02_known [0]))

static int
intel_02_known_compare (const void *p1, const void *p2)
{
  const struct intel_02_cache_info *i1;
  const struct intel_02_cache_info *i2;

  i1 = (const struct intel_02_cache_info *) p1;
  i2 = (const struct intel_02_cache_info *) p2;

  if (i1->idx == i2->idx)
    return 0;

  return i1->idx < i2->idx ? -1 : 1;
}


static long int
__attribute__ ((noinline))
intel_check_word (int name, unsigned int value, bool *has_level_2,
		  bool *no_level_2_or_3)
{
  if ((value & 0x80000000) != 0)
    /* The register value is reserved.  */
    return 0;

  /* Fold the name.  The _SC_ constants are always in the order SIZE,
     ASSOC, LINESIZE.  */
  int folded_name = (_SC_LEVEL1_ICACHE_SIZE
		     + ((name - _SC_LEVEL1_ICACHE_SIZE) / 3) * 3);

  while (value != 0)
    {
      unsigned int byte = value & 0xff;

      if (byte == 0x40)
	{
	  *no_level_2_or_3 = true;

	  if (folded_name == _SC_LEVEL3_CACHE_SIZE)
	    /* No need to look further.  */
	    break;
	}
      else
	{
	  if (byte == 0x49 && folded_name == _SC_LEVEL3_CACHE_SIZE)
	    {
	      /* Intel reused this value.  For family 15, model 6 it
		 specifies the 3rd level cache.  Otherwise the 2nd
		 level cache.  */
	      unsigned int eax;
	      unsigned int ebx;
	      unsigned int ecx;
	      unsigned int edx;
	      asm volatile ("cpuid"
			    : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
			    : "0" (1));

	      unsigned int family = ((eax >> 20) & 0xff) + ((eax >> 8) & 0xf);
	      unsigned int model = ((((eax >>16) & 0xf) << 4)
				    + ((eax >> 4) & 0xf));
	      if (family == 15 && model == 6)
		{
		  /* The level 3 cache is encoded for this model like
		     the level 2 cache is for other models.  Pretend
		     the caller asked for the level 2 cache.  */
		  name = (_SC_LEVEL2_CACHE_SIZE
			  + (name - _SC_LEVEL3_CACHE_SIZE));
		  folded_name = _SC_LEVEL3_CACHE_SIZE;
		}
	    }

	  struct intel_02_cache_info *found;
	  struct intel_02_cache_info search;

	  search.idx = byte;
	  found = bsearch (&search, intel_02_known, nintel_02_known,
			   sizeof (intel_02_known[0]), intel_02_known_compare);
	  if (found != NULL)
	    {
	      if (found->name == folded_name)
		{
		  unsigned int offset = name - folded_name;

		  if (offset == 0)
		    /* Cache size.  */
		    return found->size;
		  if (offset == 1)
		    return found->assoc;

		  assert (offset == 2);
		  return found->linesize;
		}

	      if (found->name == _SC_LEVEL2_CACHE_SIZE)
		*has_level_2 = true;
	    }
	}

      /* Next byte for the next round.  */
      value >>= 8;
    }

  /* Nothing found.  */
  return 0;
}


static long int __attribute__ ((noinline))
handle_intel (int name, unsigned int maxidx)
{
  assert (maxidx >= 2);

  /* OK, we can use the CPUID instruction to get all info about the
     caches.  */
  unsigned int cnt = 0;
  unsigned int max = 1;
  long int result = 0;
  bool no_level_2_or_3 = false;
  bool has_level_2 = false;

  while (cnt++ < max)
    {
      unsigned int eax;
      unsigned int ebx;
      unsigned int ecx;
      unsigned int edx;
      asm volatile ("cpuid"
		    : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
		    : "0" (2));

      /* The low byte of EAX in the first round contain the number of
	 rounds we have to make.  At least one, the one we are already
	 doing.  */
      if (cnt == 1)
	{
	  max = eax & 0xff;
	  eax &= 0xffffff00;
	}

      /* Process the individual registers' value.  */
      result = intel_check_word (name, eax, &has_level_2, &no_level_2_or_3);
      if (result != 0)
	return result;

      result = intel_check_word (name, ebx, &has_level_2, &no_level_2_or_3);
      if (result != 0)
	return result;

      result = intel_check_word (name, ecx, &has_level_2, &no_level_2_or_3);
      if (result != 0)
	return result;

      result = intel_check_word (name, edx, &has_level_2, &no_level_2_or_3);
      if (result != 0)
	return result;
    }

  if (name >= _SC_LEVEL2_CACHE_SIZE && name <= _SC_LEVEL3_CACHE_LINESIZE
      && no_level_2_or_3)
    return -1;

  return 0;
}


static long int __attribute__ ((noinline))
handle_amd (int name)
{
  unsigned int eax;
  unsigned int ebx;
  unsigned int ecx;
  unsigned int edx;
  asm volatile ("cpuid"
		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
		: "0" (0x80000000));

  /* No level 4 cache (yet).  */
  if (name > _SC_LEVEL3_CACHE_LINESIZE)
    return 0;

  unsigned int fn = 0x80000005 + (name >= _SC_LEVEL2_CACHE_SIZE);
  if (eax < fn)
    return 0;

  asm volatile ("cpuid"
		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
		: "0" (fn));

  if (name < _SC_LEVEL1_DCACHE_SIZE)
    {
      name += _SC_LEVEL1_DCACHE_SIZE - _SC_LEVEL1_ICACHE_SIZE;
      ecx = edx;
    }

  switch (name)
    {
    case _SC_LEVEL1_DCACHE_SIZE:
      return (ecx >> 14) & 0x3fc00;

    case _SC_LEVEL1_DCACHE_ASSOC:
      ecx >>= 16;
      if ((ecx & 0xff) == 0xff)
	/* Fully associative.  */
	return (ecx << 2) & 0x3fc00;
      return ecx & 0xff;

    case _SC_LEVEL1_DCACHE_LINESIZE:
      return ecx & 0xff;

    case _SC_LEVEL2_CACHE_SIZE:
      return (ecx & 0xf000) == 0 ? 0 : (ecx >> 6) & 0x3fffc00;

    case _SC_LEVEL2_CACHE_ASSOC:
      switch ((ecx >> 12) & 0xf)
        {
        case 0:
        case 1:
        case 2:
        case 4:
	  return (ecx >> 12) & 0xf;
	case 6:
	  return 8;
	case 8:
	  return 16;
	case 10:
	  return 32;
	case 11:
	  return 48;
	case 12:
	  return 64;
	case 13:
	  return 96;
	case 14:
	  return 128;
	case 15:
	  return ((ecx >> 6) & 0x3fffc00) / (ecx & 0xff);
	default:
	  return 0;
        }
      /* NOTREACHED */

    case _SC_LEVEL2_CACHE_LINESIZE:
      return (ecx & 0xf000) == 0 ? 0 : ecx & 0xff;

    case _SC_LEVEL3_CACHE_SIZE:
      return (edx & 0xf000) == 0 ? 0 : (edx & 0x3ffc0000) << 1;

    case _SC_LEVEL3_CACHE_ASSOC:
      switch ((edx >> 12) & 0xf)
	{
	case 0:
	case 1:
	case 2:
	case 4:
	  return (edx >> 12) & 0xf;
	case 6:
	  return 8;
	case 8:
	  return 16;
	case 10:
	  return 32;
	case 11:
	  return 48;
	case 12:
	  return 64;
	case 13:
	  return 96;
	case 14:
	  return 128;
	case 15:
	  return ((edx & 0x3ffc0000) << 1) / (edx & 0xff);
	default:
	  return 0;
	}
      /* NOTREACHED */

    case _SC_LEVEL3_CACHE_LINESIZE:
      return (edx & 0xf000) == 0 ? 0 : edx & 0xff;

    default:
      assert (! "cannot happen");
    }
  return -1;
}


/* Get the value of the system variable NAME.  */
long int
attribute_hidden
__cache_sysconf (int name)
{
  /* Find out what brand of processor.  */
  unsigned int eax;
  unsigned int ebx;
  unsigned int ecx;
  unsigned int edx;
  asm volatile ("cpuid"
		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
		: "0" (0));

  /* This spells out "GenuineIntel".  */
  if (ebx == 0x756e6547 && ecx == 0x6c65746e && edx == 0x49656e69)
    return handle_intel (name, eax);

  /* This spells out "AuthenticAMD".  */
  if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
    return handle_amd (name);

  // XXX Fill in more vendors.

  /* CPU not known, we have no information.  */
  return 0;
}


/* Half the data cache size for use in memory and string routines, typically
   L1 size.  */
long int __x86_64_data_cache_size_half attribute_hidden = 32 * 1024 / 2;
/* Shared cache size for use in memory and string routines, typically
   L2 or L3 size.  */
long int __x86_64_shared_cache_size_half attribute_hidden = 1024 * 1024 / 2;
long int __x86_64_shared_cache_size attribute_hidden = 1024 * 1024;
/* PREFETCHW support flag for use in memory and string routines.  */
int __x86_64_prefetchw attribute_hidden;

/* Instructions preferred for memory and string routines.

  0: Regular instructions
  1: MMX instructions
  2: SSE2 instructions
  3: SSSE3 instructions

  */
int __x86_64_preferred_memory_instruction attribute_hidden;


static void
__attribute__((constructor))
init_cacheinfo (void)
{
  /* Find out what brand of processor.  */
  unsigned int eax;
  unsigned int ebx;
  unsigned int ecx;
  unsigned int edx;
  int max_cpuid;
  int max_cpuid_ex;
  long int data = -1;
  long int shared = -1;
  unsigned int level;
  unsigned int threads = 0;

  asm volatile ("cpuid"
		: "=a" (max_cpuid), "=b" (ebx), "=c" (ecx), "=d" (edx)
		: "0" (0));

  /* This spells out "GenuineIntel".  */
  if (ebx == 0x756e6547 && ecx == 0x6c65746e && edx == 0x49656e69)
    {
      data = handle_intel (_SC_LEVEL1_DCACHE_SIZE, max_cpuid);

      /* Try L3 first.  */
      level  = 3;
      shared = handle_intel (_SC_LEVEL3_CACHE_SIZE, max_cpuid);

      if (shared <= 0)
        {
	  /* Try L2 otherwise.  */
          level  = 2;
          shared = handle_intel (_SC_LEVEL2_CACHE_SIZE, max_cpuid);
	}

      asm volatile ("cpuid"
		    : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
		    : "0" (1));

      /* Intel prefers SSSE3 instructions for memory/string routines
	 if they are avaiable.  */
      if ((ecx & 0x200))
	__x86_64_preferred_memory_instruction = 3;
      else
	__x86_64_preferred_memory_instruction = 2;

      /* Figure out the number of logical threads that share the
	 highest cache level.  */
      if (max_cpuid >= 4)
        {
	  int i = 0;

	  /* Query until desired cache level is enumerated.  */
	  do
	    {
              asm volatile ("cpuid"
		            : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
		            : "0" (4), "2" (i++));

	      /* There seems to be a bug in at least some Pentium Ds
		 which sometimes fail to iterate all cache parameters.
		 Do not loop indefinitely here, stop in this case and
		 assume there is no such information.  */
	      if ((eax & 0x1f) == 0)
		goto intel_bug_no_cache_info;
	    }
          while (((eax >> 5) & 0x7) != level);

	  threads = ((eax >> 14) & 0x3ff) + 1;
	}
      else
        {
	intel_bug_no_cache_info:
	  /* Assume that all logical threads share the highest cache level.  */

	  threads = (ebx >> 16) & 0xff;
	}

      /* Cap usage of highest cache level to the number of supported
	 threads.  */
      if (shared > 0 && threads > 0)
        shared /= threads;
    }
  /* This spells out "AuthenticAMD".  */
  else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
    {
      data   = handle_amd (_SC_LEVEL1_DCACHE_SIZE);
      long int core = handle_amd (_SC_LEVEL2_CACHE_SIZE);
      shared = handle_amd (_SC_LEVEL3_CACHE_SIZE);

      /* Get maximum extended function. */
      asm volatile ("cpuid"
		    : "=a" (max_cpuid_ex), "=b" (ebx), "=c" (ecx), "=d" (edx)
		    : "0" (0x80000000));

      if (shared <= 0)
	/* No shared L3 cache.  All we have is the L2 cache.  */
	shared = core;
      else
	{
	  /* Figure out the number of logical threads that share L3.  */
	  if (max_cpuid_ex >= 0x80000008)
	    {
	      /* Get width of APIC ID.  */
	      asm volatile ("cpuid"
			    : "=a" (max_cpuid_ex), "=b" (ebx), "=c" (ecx),
			      "=d" (edx)
			    : "0" (0x80000008));
	      threads = 1 << ((ecx >> 12) & 0x0f);
	    }

	  if (threads == 0)
	    {
	      /* If APIC ID width is not available, use logical
		 processor count.  */
	      asm volatile ("cpuid"
			    : "=a" (max_cpuid_ex), "=b" (ebx), "=c" (ecx),
			      "=d" (edx)
			    : "0" (0x00000001));

	      if ((edx & (1 << 28)) != 0)
		threads = (ebx >> 16) & 0xff;
	    }

	  /* Cap usage of highest cache level to the number of
	     supported threads.  */
	  if (threads > 0)
	    shared /= threads;

	  /* Account for exclusive L2 and L3 caches.  */
	  shared += core;
	}

      if (max_cpuid_ex >= 0x80000001)
	{
	  asm volatile ("cpuid"
			: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
			: "0" (0x80000001));
	  /*  PREFETCHW     || 3DNow!  */
	  if ((ecx & 0x100) || (edx & 0x80000000))
	    __x86_64_prefetchw = -1;
	}
    }

  if (data > 0)
    __x86_64_data_cache_size_half = data / 2;

  if (shared > 0)
    {
      __x86_64_shared_cache_size_half = shared / 2;
      __x86_64_shared_cache_size = shared;
    }
}
