/* Low-level lock implementation.  Generic futex-based version.
   Copyright (C) 2005-2015 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library.  If not, see
   <http://www.gnu.org/licenses/>.  */

#ifndef _LOWLEVELLOCK_H
#define _LOWLEVELLOCK_H	1

#include <atomic.h>
#include <lowlevellock-futex.h>

/* Low-level locks use a combination of atomic operations (to acquire and
   release lock ownership) and futex operations (to block until the state
   of a lock changes).  A lock can be in one of three states:
   0:  not acquired,
   1:  acquired with no waiters; no other threads are blocked or about to block
       for changes to the lock state,
   >1: acquired, possibly with waiters; there may be other threads blocked or
       about to block for changes to the lock state.

   We expect that the common case is an uncontended lock, so we just need
   to transition the lock between states 0 and 1; releasing the lock does
   not need to wake any other blocked threads.  If the lock is contended
   and a thread decides to block using a futex operation, then this thread
   needs to first change the state to >1; if this state is observed during
   lock release, the releasing thread will wake one of the potentially
   blocked threads.

   Much of this code takes a 'private' parameter.  This may be:
   LLL_PRIVATE: lock only shared within a process
   LLL_SHARED:  lock may be shared across processes.

   Condition variables contain an optimization for broadcasts that requeues
   waiting threads on a lock's futex.  Therefore, there is a special
   variant of the locks (whose name contains "cond") that makes sure to
   always set the lock state to >1 and not just 1.

   Robust locks set the lock to the id of the owner.  This allows detection
   of the case where the owner exits without releasing the lock.  Flags are
   OR'd with the owner id to record additional information about lock state.
   Therefore the states of robust locks are:
    0: not acquired
   id: acquired (by user identified by id & FUTEX_TID_MASK)

   The following flags may be set in the robust lock value:
   FUTEX_WAITERS     - possibly has waiters
   FUTEX_OWNER_DIED  - owning user has exited without releasing the futex.  */


/* If LOCK is 0 (not acquired), set to 1 (acquired with no waiters) and return
   0.  Otherwise leave lock unchanged and return non-zero to indicate that the
   lock was not acquired.  */
#define lll_trylock(lock)	\
  atomic_compare_and_exchange_bool_acq (&(lock), 1, 0)

/* If LOCK is 0 (not acquired), set to 2 (acquired, possibly with waiters) and
   return 0.  Otherwise leave lock unchanged and return non-zero to indicate
   that the lock was not acquired.  */
#define lll_cond_trylock(lock)	\
  atomic_compare_and_exchange_bool_acq (&(lock), 2, 0)

extern void __lll_lock_wait_private (int *futex) attribute_hidden;
extern void __lll_lock_wait (int *futex, int private) attribute_hidden;
extern int __lll_robust_lock_wait (int *futex, int private) attribute_hidden;

/* This is an expression rather than a statement even though its value is
   void, so that it can be used in a comma expression or as an expression
   that's cast to void.  */
/* The inner conditional compiles to a call to __lll_lock_wait_private if
   private is known at compile time to be LLL_PRIVATE, and to a call to
   __lll_lock_wait otherwise.  */
/* If FUTEX is 0 (not acquired), set to 1 (acquired with no waiters) and
   return.  Otherwise, ensure that it is >1 (acquired, possibly with waiters)
   and then block until we acquire the lock, at which point FUTEX will still be
   >1.  The lock is always acquired on return.  */
#define __lll_lock(futex, private)                                      \
  ((void)                                                               \
   ({                                                                   \
     int *__futex = (futex);                                            \
     if (__glibc_unlikely                                               \
         (atomic_compare_and_exchange_bool_acq (__futex, 1, 0)))        \
       {                                                                \
         if (__builtin_constant_p (private) && (private) == LLL_PRIVATE) \
           __lll_lock_wait_private (__futex);                           \
         else                                                           \
           __lll_lock_wait (__futex, private);                          \
       }                                                                \
   }))
#define lll_lock(futex, private)	\
  __lll_lock (&(futex), private)


/* If FUTEX is 0 (not acquired), set to ID (acquired with no waiters) and
   return 0.  Otherwise, ensure that it is set to FUTEX | FUTEX_WAITERS
   (acquired, possibly with waiters) and block until we acquire the lock.
   FUTEX will now be ID | FUTEX_WAITERS and we return 0.
   If the previous owner of the lock dies before we acquire the lock then FUTEX
   will be the value of id as set by the previous owner, with FUTEX_OWNER_DIED
   set (FUTEX_WAITERS may or may not be set).  We return this value to indicate
   that the lock is not acquired.  */
#define __lll_robust_lock(futex, id, private)                           \
  ({                                                                    \
    int *__futex = (futex);                                             \
    int __val = 0;                                                      \
                                                                        \
    if (__glibc_unlikely                                                \
        (atomic_compare_and_exchange_bool_acq (__futex, id, 0)))        \
      __val = __lll_robust_lock_wait (__futex, private);                \
    __val;                                                              \
  })
#define lll_robust_lock(futex, id, private)     \
  __lll_robust_lock (&(futex), id, private)


/* This is an expression rather than a statement even though its value is
   void, so that it can be used in a comma expression or as an expression
   that's cast to void.  */
/* Unconditionally set FUTEX to 2 (acquired, possibly with waiters).  If FUTEX
   was 0 (not acquired) then return.  Otherwise, block until the lock is
   acquired, at which point FUTEX is 2 (acquired, possibly with waiters).  The
   lock is always acquired on return.  */
#define __lll_cond_lock(futex, private)                                 \
  ((void)                                                               \
   ({                                                                   \
     int *__futex = (futex);                                            \
     if (__glibc_unlikely (atomic_exchange_acq (__futex, 2) != 0))      \
       __lll_lock_wait (__futex, private);                              \
   }))
#define lll_cond_lock(futex, private) __lll_cond_lock (&(futex), private)


/* As __lll_robust_lock, but set to ID | FUTEX_WAITERS (acquired, possibly with
   waiters) if FUTEX is 0.  */
#define lll_robust_cond_lock(futex, id, private)	\
  __lll_robust_lock (&(futex), (id) | FUTEX_WAITERS, private)


extern int __lll_timedlock_wait (int *futex, const struct timespec *,
				 int private) attribute_hidden;
extern int __lll_robust_timedlock_wait (int *futex, const struct timespec *,
					int private) attribute_hidden;


/* As __lll_lock, but with a timeout.  If the timeout occurs then return
   ETIMEDOUT.  If ABSTIME is invalid, return EINVAL.  */
#define __lll_timedlock(futex, abstime, private)                \
  ({                                                            \
    int *__futex = (futex);                                     \
    int __val = 0;                                              \
                                                                \
    if (__glibc_unlikely                                        \
        (atomic_compare_and_exchange_bool_acq (__futex, 1, 0))) \
      __val = __lll_timedlock_wait (__futex, abstime, private); \
    __val;                                                      \
  })
#define lll_timedlock(futex, abstime, private)  \
  __lll_timedlock (&(futex), abstime, private)


/* As __lll_robust_lock, but with a timeout.  If the timeout occurs then return
   ETIMEDOUT.  If ABSTIME is invalid, return EINVAL.  */
#define __lll_robust_timedlock(futex, abstime, id, private)             \
  ({                                                                    \
    int *__futex = (futex);                                             \
    int __val = 0;                                                      \
                                                                        \
    if (__glibc_unlikely                                                \
        (atomic_compare_and_exchange_bool_acq (__futex, id, 0)))        \
      __val = __lll_robust_timedlock_wait (__futex, abstime, private);  \
    __val;                                                              \
  })
#define lll_robust_timedlock(futex, abstime, id, private)       \
  __lll_robust_timedlock (&(futex), abstime, id, private)


/* This is an expression rather than a statement even though its value is
   void, so that it can be used in a comma expression or as an expression
   that's cast to void.  */
/* Unconditionally set FUTEX to 0 (not acquired), releasing the lock.  If FUTEX
   was >1 (acquired, possibly with waiters), then wake any waiters.  The waiter
   that acquires the lock will set FUTEX to >1.  */
#define __lll_unlock(futex, private)                    \
  ((void)                                               \
   ({                                                   \
     int *__futex = (futex);                            \
     int __oldval = atomic_exchange_rel (__futex, 0);   \
     if (__glibc_unlikely (__oldval > 1))               \
       lll_futex_wake (__futex, 1, private);            \
   }))
#define lll_unlock(futex, private)	\
  __lll_unlock (&(futex), private)


/* This is an expression rather than a statement even though its value is
   void, so that it can be used in a comma expression or as an expression
   that's cast to void.  */
/* Unconditionally set FUTEX to 0 (not acquired), releasing the lock.  If FUTEX
   had FUTEX_WAITERS set then wake any waiters.  The waiter that acquires the
   lock will set FUTEX_WAITERS.  */
#define __lll_robust_unlock(futex, private)             \
  ((void)                                               \
   ({                                                   \
     int *__futex = (futex);                            \
     int __oldval = atomic_exchange_rel (__futex, 0);   \
     if (__glibc_unlikely (__oldval & FUTEX_WAITERS))	\
       lll_futex_wake (__futex, 1, private);            \
   }))
#define lll_robust_unlock(futex, private)       \
  __lll_robust_unlock (&(futex), private)


#define lll_islocked(futex) \
  ((futex) != LLL_LOCK_INITIALIZER)


/* Our internal lock implementation is identical to the binary-compatible
   mutex implementation. */

/* Initializers for lock.  */
#define LLL_LOCK_INITIALIZER		(0)
#define LLL_LOCK_INITIALIZER_LOCKED	(1)


/* The kernel notifies a process which uses CLONE_CHILD_CLEARTID via futex
   wake-up when the clone terminates.  The memory location contains the
   thread ID while the clone is running and is reset to zero by the kernel
   afterwards.  The kernel up to version 3.16.3 does not use the private futex
   operations for futex wake-up when the clone terminates.  */
#define lll_wait_tid(tid) \
  do {					\
    __typeof (tid) __tid;		\
    while ((__tid = (tid)) != 0)	\
      lll_futex_wait (&(tid), __tid, LLL_SHARED);\
  } while (0)

extern int __lll_timedwait_tid (int *, const struct timespec *)
     attribute_hidden;

/* As lll_wait_tid, but with a timeout.  If the timeout occurs then return
   ETIMEDOUT.  If ABSTIME is invalid, return EINVAL.  */
#define lll_timedwait_tid(tid, abstime) \
  ({							\
    int __res = 0;					\
    if ((tid) != 0)					\
      __res = __lll_timedwait_tid (&(tid), (abstime));	\
    __res;						\
  })


#endif	/* lowlevellock.h */
