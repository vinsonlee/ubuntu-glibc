/* Test for processing of invalid group entries.  [BZ #18724]
   Copyright (C) 2015-2016 Free Software Foundation, Inc.
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

#include <errno.h>
#include <grp.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static bool errors;

static void
check (struct group e, const char *expected)
{
  char *buf;
  size_t buf_size;
  FILE *f = open_memstream (&buf, &buf_size);

  if (f == NULL)
    {
      printf ("open_memstream: %m\n");
      errors = true;
      return;
    }

  int ret = putgrent (&e, f);

  if (expected == NULL)
    {
      if (ret == -1)
	{
	  if (errno != EINVAL)
	    {
	      printf ("putgrent: unexpected error code: %m\n");
	      errors = true;
	    }
	}
      else
	{
	  printf ("putgrent: unexpected success (\"%s\", \"%s\")\n",
		  e.gr_name, e.gr_passwd);
	  errors = true;
	}
    }
  else
    {
      /* Expect success.  */
      size_t expected_length = strlen (expected);
      if (ret == 0)
	{
	  long written = ftell (f);

	  if (written <= 0 || fflush (f) < 0)
	    {
	      printf ("stream error: %m\n");
	      errors = true;
	    }
	  else if (buf[written - 1] != '\n')
	    {
	      printf ("FAILED: \"%s\" without newline\n", expected);
	      errors = true;
	    }
	  else if (strncmp (buf, expected, written - 1) != 0
		   || written - 1 != expected_length)
	    {
	      buf[written - 1] = '\0';
	      printf ("FAILED: \"%s\" (%ld), expected \"%s\" (%zu)\n",
		      buf, written - 1, expected, expected_length);
	      errors = true;
	    }
	}
      else
	{
	  printf ("FAILED: putgrent (expected \"%s\"): %m\n", expected);
	  errors = true;
	}
    }

  fclose (f);
  free (buf);
}

static int
do_test (void)
{
  check ((struct group) {
      .gr_name = (char *) "root",
    },
    "root::0:");
  check ((struct group) {
      .gr_name = (char *) "root",
      .gr_passwd = (char *) "password",
      .gr_gid = 1234,
      .gr_mem = (char *[2]) {(char *) "member1", NULL}
    },
    "root:password:1234:member1");
  check ((struct group) {
      .gr_name = (char *) "root",
      .gr_passwd = (char *) "password",
      .gr_gid = 1234,
      .gr_mem = (char *[3]) {(char *) "member1", (char *) "member2", NULL}
    },
    "root:password:1234:member1,member2");

  /* Bad values.  */
  {
    static const char *const bad_strings[] = {
      ":",
      "\n",
      ":bad",
      "\nbad",
      "b:ad",
      "b\nad",
      "bad:",
      "bad\n",
      "b:a\nd"
      ",",
      "\n,",
      ":,",
      ",bad",
      "b,ad",
      "bad,",
      NULL
    };
    for (const char *const *bad = bad_strings; *bad != NULL; ++bad)
      {
	char *members[]
	  = {(char *) "first", (char *) *bad, (char *) "last", NULL};
	if (strpbrk (*bad, ":\n") != NULL)
	  {
	    check ((struct group) {
		.gr_name = (char *) *bad,
	      }, NULL);
	    check ((struct group) {
		.gr_name = (char *) "root",
		.gr_passwd = (char *) *bad,
	      }, NULL);
	  }
	check ((struct group) {
	    .gr_name = (char *) "root",
	    .gr_passwd = (char *) "password",
	    .gr_mem = members,
	  }, NULL);
      }
  }

  return errors;
}

#define TEST_FUNCTION do_test ()
#include "../test-skeleton.c"
