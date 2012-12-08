#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

#AC_PREREQ([2.69])
AC_INIT([mget], [0.1.2], [tim.ruehsen@gmx.de])
AC_CONFIG_SRCDIR([src/mget.c])
AC_CONFIG_HEADERS([config.h])

AC_CANONICAL_HOST
#case $host_os in
#  linux*)
#        ;;
#  *)
#        AC_MSG_ERROR([$host_os is not currently supported])
#        ;;
#esac

# Checks for programs.

# If CFLAGS isn't defined and using gcc, set CFLAGS to something reasonable.
# Otherwise, just prevent autoconf from molesting CFLAGS.
CFLAGS=$CFLAGS
LDFLAGS=$LDFLAGS
AC_PROG_CC
if test "x$CFLAGS" = "x" ; then
  if test "x$GCC" = "xyes" ; then
   CFLAGS="-g -std=gnu99 -pedantic -fPIC\
 -Wall -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes\
 -Wwrite-strings -Wformat=2 -Wformat -Wformat-security\
 -Wno-sign-compare -Wextra -D_FORTIFY_SOURCE=2\
 -Wcast-align -O2"
  fi
fi
if test "x$LDFLAGS" = "x" ; then
  if test "x$GCC" = "xyes" ; then
    LDFLAGS="-fPIE -pie -Wl,-z,relro,--as-needed"
  fi
fi
# Append EXTRA_CFLAGS to CFLAGS, if defined.
if test "x$EXTRA_CFLAGS" != "x" ; then
  CFLAGS="$CFLAGS $EXTRA_CFLAGS"
fi

AC_PROG_LEX
AC_PROG_INSTALL
AC_PROG_LN_S

#AC_ARG_WITH(gnutls, AS_HELP_STRING([--with-gnutls[=PATH]], [compile with SSL support]), , with_gnutls="no")
#if test $with_gnutls != "no"
#then
#  if test $with_gnutls != "yes"
#  then
#    export PKG_CONFIG_PATH="$with_gnutls:$with_gnutls/pkgconfig:$with_gnutls/lib/pkgconfig:$PKG_CONFIG_PATH"
#    GNUTLS_BIN_DIR="$with_gnutls/bin/"
#    AC_SUBST(GNUTLS_BIN_DIR)
#  fi
#  echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
#  PKG_CHECK_MODULES([GNUTLS], [gnutls >= 3.0.11], [AC_DEFINE([WITH_SSL], [1], [Use GNUTLS])])
#  echo "GNUTLS_CFLAGS=$GNUTLS_CFLAGS"
#  echo "GNUTLS_LIBS=$GNUTLS_LIBS"
#  echo "GNUTLS_BIN_DIR=$GNUTLS_BIN_DIR"
#fi

AC_ARG_WITH(gnutls, AS_HELP_STRING([--without-gnutls], [disable GNUTLS SSL support]), with_gnutls=$withval, with_gnutls=yes)
if test $with_gnutls != "no"
then
  AC_CHECK_LIB(gnutls, gnutls_global_init, [with_gnutls=yes; AC_SUBST(GNUTLS_LIBS, "-lgnutls") AC_DEFINE([WITH_GNUTLS], [1], [Use gnutls])], [with_gnutls=no; AC_MSG_WARN(*** GNUTLS was not found. You will not be able to use HTTPS or Metalink checksumming)])
fi
AM_CONDITIONAL([WITH_GNUTLS], [test $with_gnutls = "yes"])

#AC_DEFINE([WITH_SSL], [1], [Use SSL])]
#AM_CONDITIONAL([WITH_SSL], [test $with_gnutls = "yes"])

AC_ARG_WITH(zlib, AS_HELP_STRING([--without-zlib], [disable gzip compression support]), with_zlib=$withval, with_zlib=yes)
if test $with_zlib != "no"
then
  AC_CHECK_LIB(z, deflate, [with_zlib=yes; AC_SUBST(ZLIB_LIBS, "-lz") AC_DEFINE([WITH_ZLIB], [1], [Use zlib])], [with_zlib=no; AC_MSG_WARN(*** ZLIB was not found. You will not be able to use gzip compression)])
fi
AM_CONDITIONAL([WITH_ZLIB], [test $with_zlib = "yes"])


# Checks for libraries.
#AC_CHECK_LIB([gnutls], [gnutls_global_init])
AC_CHECK_LIB([pthread], [pthread_attr_init])
AC_CHECK_LIB([rt], [clock_gettime])
#AC_CHECK_LIB([z], [deflate])

AC_SUBST(LIBS, "$GNUTLS_LIBS $ZLIB_LIBS $LIBS")

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h inttypes.h libintl.h locale.h netdb.h netinet/in.h stddef.h stdlib.h string.h strings.h sys/socket.h sys/time.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_C_INLINE
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT8_T
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_C_RESTRICT
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT8_T
AC_CHECK_TYPES([ptrdiff_t])

# Checks for library functions.
AC_FUNC_ALLOCA
AC_FUNC_FORK
AC_FUNC_MALLOC
AC_FUNC_MMAP
AC_FUNC_REALLOC
AC_CHECK_FUNCS([clock_gettime dup2 gettimeofday localtime_r memchr memmove memset mkdir munmap select setlocale socket strcasecmp strchr strdup strerror strncasecmp strndup strrchr strstr strlcpy futimens])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 tests/Makefile])
AC_OUTPUT

AC_MSG_NOTICE([Summary of build options:

  Version:           ${PACKAGE_VERSION}
  Host OS:           ${host_os}
  Install prefix:    ${prefix}
  Compiler:          ${CC}
  CFlags:            ${CFLAGS}
  LDFlags:           ${LDFLAGS}
  Libs:              ${LIBS}
  SSL support:       $with_gnutls
  GZIP compression:  $with_zlib
])