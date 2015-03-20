/* Copyright (C) 2000-2015 Free Software Foundation, Inc.

   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public License as
   published by the Free Software Foundation; either version 2.1 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#include <sysdeps/microblaze/sysdep.h>
#include <sys/syscall.h>

/* Defines RTLD_PRIVATE_ERRNO.  */
#include <dl-sysdep.h>

/* In order to get __set_errno() definition in INLINE_SYSCALL.  */
#ifndef __ASSEMBLER__
# include <errno.h>
#endif

/* For Linux we can use the system call table in the header file
    /usr/include/asm/unistd.h
   of the kernel.  But these symbols do not follow the SYS_* syntax
   so we have to redefine the `SYS_ify' macro here.  */
#undef SYS_ify
#define SYS_ify(syscall_name)   __NR_##syscall_name

#ifdef __ASSEMBLER__

/* In microblaze ABI function call arguments are passed in registers
   r5...r10. The return value is stored in r3 (or r3:r4 regiters pair).
   Linux syscall uses the same convention with the addition that the
   syscall number is passed in r12. To enter the kernel "brki r14,8"
   instruction is used.
   None of the abovementioned registers are presumed across function call
   or syscall.
*/
/* Linux uses a negative return value to indicate syscall errors, unlike
   most Unices, which use the condition codes' carry flag.

   Since version 2.1 the return value of a system call might be negative
   even if the call succeeded.  E.g., the `lseek' system call might return
   a large offset.  Therefore we must not anymore test for < 0, but test
   for a real error by making sure the value in %d0 is a real error
   number.  Linus said he will make sure the no syscall returns a value
   in -1 .. -4095 as a valid result so we can savely test with -4095.  */

/* We don't want the label for the error handler to be visible in the symbol
   table when we define it here.  */
# ifdef PIC
#  define SYSCALL_ERROR_LABEL 0f
# else
#  define SYSCALL_ERROR_LABEL __syscall_error
# endif

# undef PSEUDO
# define PSEUDO(name, syscall_name, args)           \
  .text;                                            \
  ENTRY (name)                                      \
    DO_CALL (syscall_name, args);                   \
    addik r12,r0,-4095;                             \
    cmpu  r12,r12,r3;                               \
    bgei  r12,SYSCALL_ERROR_LABEL;

# undef PSEUDO_END
# define PSEUDO_END(name)                           \
  SYSCALL_ERROR_HANDLER;                            \
  END (name)

# undef PSEUDO_NOERRNO
# define PSEUDO_NOERRNO(name, syscall_name, args)   \
  .text;                                            \
  ENTRY (name)                                      \
    DO_CALL (syscall_name, args);

# undef PSEUDO_END_NOERRNO
# define PSEUDO_END_NOERRNO(name)                   \
  END (name)

/* The function has to return the error code.  */
# undef  PSEUDO_ERRVAL
# define PSEUDO_ERRVAL(name, syscall_name, args)    \
  .text;                                            \
  ENTRY (name)                                      \
    DO_CALL (syscall_name, args);                   \

# undef  PSEUDO_END_ERRVAL
# define PSEUDO_END_ERRVAL(name)                    \
  END (name)

# define ret_NOERRNO                                \
  rtsd r15,8; addk r0,r0,r0;

# define ret_ERRVAL                                 \
  rtsd r15,8; rsubk r3,r3,r0;

# ifdef PIC
#  define SYSCALL_ERROR_LABEL_DCL 0
#  if RTLD_PRIVATE_ERRNO
#   define SYSCALL_ERROR_HANDLER                    \
SYSCALL_ERROR_LABEL_DCL:                            \
    mfs   r12,rpc;                                  \
    addik r12,r12,_GLOBAL_OFFSET_TABLE_+8;          \
    lwi   r12,r12,rtld_errno@GOT;                   \
    rsubk r3,r3,r0;                                 \
    swi   r3,r12,0;                                 \
    rtsd  r15,8;                                    \
    addik r3,r0,-1;
#  else /* !RTLD_PRIVATE_ERRNO.  */
/* Store (-r3) into errno through the GOT.  */
#   if defined _LIBC_REENTRANT
#    define SYSCALL_ERROR_HANDLER                   \
SYSCALL_ERROR_LABEL_DCL:                            \
    addik r1,r1,-16;                                \
    swi   r15,r1,0;                                 \
    swi   r20,r1,8;                                 \
    rsubk r3,r3,r0;                                 \
    swi   r3,r1,12;                                 \
    mfs   r20,rpc;                                  \
    addik r20,r20,_GLOBAL_OFFSET_TABLE_+8;          \
    brlid r15,__errno_location@PLT;                 \
    nop;                                            \
    lwi   r4,r1,12;                                 \
    swi   r4,r3,0;                                  \
    lwi   r20,r1,8;                                 \
    lwi   r15,r1,0;                                 \
    addik r1,r1,16;                                 \
    rtsd  r15,8;                                    \
    addik r3,r0,-1;
#   else /* !_LIBC_REENTRANT.  */
#    define SYSCALL_ERROR_HANDLER                   \
SYSCALL_ERROR_LABEL_DCL:                            \
    mfs   r12,rpc;                                  \
    addik r12,r12,_GLOBAL_OFFSET_TABLE_+8;          \
    lwi   r12,r12,errno@GOT;                        \
    rsubk r3,r3,r0;                                 \
    swi   r3,r12,0;                                 \
    rtsd  r15,8;                                    \
    addik r3,r0,-1;
#    endif /* _LIBC_REENTRANT.  */
# endif /* RTLD_PRIVATE_ERRNO.  */
# else
#  define SYSCALL_ERROR_HANDLER  /* Nothing here; code in sysdep.S is used.  */
# endif /* PIC.  */

# define DO_CALL(syscall_name, args)                \
    addik r12,r0,SYS_ify (syscall_name);            \
    brki  r14,8;                                    \
    addk  r0,r0,r0;

#else /* not __ASSEMBLER__ */

/* Define a macro which expands into the inline wrapper code for a system
   call.  */
# undef INLINE_SYSCALL
# define INLINE_SYSCALL(name, nr, args...)                           \
({  INTERNAL_SYSCALL_DECL(err);                                      \
    unsigned long resultvar = INTERNAL_SYSCALL(name, err, nr, args); \
    if (INTERNAL_SYSCALL_ERROR_P (resultvar, err))                   \
       {                                                             \
        __set_errno (INTERNAL_SYSCALL_ERRNO (resultvar, err));       \
        resultvar = (unsigned long) -1;                              \
       }                                                             \
    (long) resultvar;                                                \
})

# undef INTERNAL_SYSCALL_DECL
# define INTERNAL_SYSCALL_DECL(err) do { } while (0)

/* Define a macro which expands inline into the wrapper code for a system
   call.  This use is for internal calls that do not need to handle errors
   normally.  It will never touch errno.  This returns just what the kernel
   gave back.  */
# undef INTERNAL_SYSCALL
# define INTERNAL_SYSCALL(name, err, nr, args...)                    \
  inline_syscall##nr(SYS_ify(name), args)

# undef INTERNAL_SYSCALL_NCS
# define INTERNAL_SYSCALL_NCS(name, err, nr, args...)                \
  inline_syscall##nr(name, args)

# undef INTERNAL_SYSCALL_ERROR_P
# define INTERNAL_SYSCALL_ERROR_P(val, err)                          \
  ((unsigned int) (val) >= -4095U)

# undef INTERNAL_SYSCALL_ERRNO
# define INTERNAL_SYSCALL_ERRNO(val, err)    (-(val))

# define SYSCALL_CLOBBERS_6 "r11", "r4", "memory"
# define SYSCALL_CLOBBERS_5 "r10", SYSCALL_CLOBBERS_6
# define SYSCALL_CLOBBERS_4 "r9", SYSCALL_CLOBBERS_5
# define SYSCALL_CLOBBERS_3 "r8", SYSCALL_CLOBBERS_4
# define SYSCALL_CLOBBERS_2 "r7", SYSCALL_CLOBBERS_3
# define SYSCALL_CLOBBERS_1 "r6", SYSCALL_CLOBBERS_2
# define SYSCALL_CLOBBERS_0 "r5", SYSCALL_CLOBBERS_1

# define inline_syscall0(name,dummy)                                          \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r12)                                                            \
      : SYSCALL_CLOBBERS_0 ); ret;                                            \
  })

# define inline_syscall1(name,arg1)                                           \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    register long __r5 __asm__("r5") = (long)(arg1);                          \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r5), "r"(__r12)                                                 \
      : SYSCALL_CLOBBERS_1 ); ret;                                            \
  })

# define inline_syscall2(name,arg1,arg2)                                      \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    register long __r5 __asm__("r5") = (long)(arg1);                          \
    register long __r6 __asm__("r6") = (long)(arg2);                          \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r5), "r"(__r6), "r"(__r12)                                      \
      : SYSCALL_CLOBBERS_2 ); ret;                                            \
  })


# define inline_syscall3(name,arg1,arg2,arg3)                                 \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    register long __r5 __asm__("r5") = (long)(arg1);                          \
    register long __r6 __asm__("r6") = (long)(arg2);                          \
    register long __r7 __asm__("r7") = (long)(arg3);                          \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r5), "r"(__r6), "r"(__r7), "r"(__r12)                           \
      : SYSCALL_CLOBBERS_3 ); ret;                                            \
  })


# define inline_syscall4(name,arg1,arg2,arg3,arg4)                            \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    register long __r5 __asm__("r5") = (long)(arg1);                          \
    register long __r6 __asm__("r6") = (long)(arg2);                          \
    register long __r7 __asm__("r7") = (long)(arg3);                          \
    register long __r8 __asm__("r8") = (long)(arg4);                          \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r5), "r"(__r6), "r"(__r7), "r"(__r8),"r"(__r12)                 \
      : SYSCALL_CLOBBERS_4 ); ret;                                            \
  })


# define inline_syscall5(name,arg1,arg2,arg3,arg4,arg5)                       \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    register long __r5 __asm__("r5") = (long)(arg1);                          \
    register long __r6 __asm__("r6") = (long)(arg2);                          \
    register long __r7 __asm__("r7") = (long)(arg3);                          \
    register long __r8 __asm__("r8") = (long)(arg4);                          \
    register long __r9 __asm__("r9") = (long)(arg5);                          \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r5), "r"(__r6), "r"(__r7), "r"(__r8),"r"(__r9), "r"(__r12)      \
      : SYSCALL_CLOBBERS_5 ); ret;                                            \
  })


# define inline_syscall6(name,arg1,arg2,arg3,arg4,arg5,arg6)                  \
  ({                                                                          \
    register long ret __asm__("r3");                                          \
    register long __r12 __asm__("r12") = name;                                \
    register long __r5 __asm__("r5") = (long)(arg1);                          \
    register long __r6 __asm__("r6") = (long)(arg2);                          \
    register long __r7 __asm__("r7") = (long)(arg3);                          \
    register long __r8 __asm__("r8") = (long)(arg4);                          \
    register long __r9 __asm__("r9") = (long)(arg5);                          \
    register long __r10 __asm__("r10") = (long)(arg6);                        \
    __asm__ __volatile__( "brki r14,8; nop;"                                  \
      : "=r"(ret)                                                             \
      : "r"(__r5), "r"(__r6), "r"(__r7), "r"(__r8),"r"(__r9), "r"(__r10),     \
      "r"(__r12)                                                              \
      : SYSCALL_CLOBBERS_6 ); ret;                                            \
  })


/* Pointer mangling is not yet supported for Microblaze.  */
# define PTR_MANGLE(var) (void) (var)
# define PTR_DEMANGLE(var) (void) (var)

#endif /* not __ASSEMBLER__ */
