# Copyright 2015 Brian Smith.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND BRIAN SMITH AND THE AUTHORS DISCLAIM
# ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL BRIAN SMITH OR THE AUTHORS
# BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY
# DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
# AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

RING_PREFIX ?= ring/

RING_CPPFLAGS = -I$(RING_PREFIX)include -D_XOPEN_SOURCE=700

RING_LDLIBS = -pthread -L$(dir $(RING_LIB)) -lring

# Everything, except:
#   * Tests (e.g. *_test.*)
#   * Assembly language sources (TODO: add these)
#   * Directory stuff (TODO(ring): remove these):
#     * crypto/directory_posix.c
#     * crypto/directory_win.c
#   * Platform-specific threading (merged in below)
#     * crypto/thread_none.c
#     * crypto/thread_pthread.c
#     * crypto/thread_win.c
#   * Other Windows-specific files:
#     * crypto/rand/windows.c
#   * crypto/test/*
RING_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/aes/aes.c \
  crypto/aes/mode_wrappers.c \
  crypto/bn/add.c \
  crypto/bn/asm/x86_64-gcc.c \
  crypto/bn/bn.c \
  crypto/bn/bn_asn1.c \
  crypto/bn/cmp.c \
  crypto/bn/convert.c \
  crypto/bn/ctx.c \
  crypto/bn/div.c \
  crypto/bn/exponentiation.c \
  crypto/bn/gcd.c \
  crypto/bn/generic.c \
  crypto/bn/kronecker.c \
  crypto/bn/montgomery.c \
  crypto/bn/mul.c \
  crypto/bn/prime.c \
  crypto/bn/random.c \
  crypto/bn/rsaz_exp.c \
  crypto/bn/shift.c \
  crypto/bn/sqrt.c \
  crypto/buf/buf.c \
  crypto/bytestring/cbb.c \
  crypto/bytestring/cbs.c \
  crypto/chacha/chacha_generic.c \
  crypto/chacha/chacha_vec.c \
  crypto/cipher/aead.c \
  crypto/cipher/cipher.c \
  crypto/cipher/e_aes.c \
  crypto/cipher/e_chacha20poly1305.c \
  crypto/cipher/e_des.c \
  crypto/cipher/e_null.c \
  crypto/cipher/e_rc4.c \
  crypto/cipher/e_ssl3.c \
  crypto/cipher/e_tls.c \
  crypto/cipher/tls_cbc.c \
  crypto/cmac/cmac.c \
  crypto/cpu-arm.c \
  crypto/cpu-intel.c \
  crypto/crypto.c \
  crypto/des/des.c \
  crypto/dh/check.c \
  crypto/dh/dh.c \
  crypto/dh/dh_impl.c \
  crypto/dh/params.c \
  crypto/digest/digest.c \
  crypto/digest/digests.c \
  crypto/ec/ec.c \
  crypto/ec/ec_key.c \
  crypto/ec/ec_montgomery.c \
  crypto/ec/oct.c \
  crypto/ec/p256-64.c \
  crypto/ec/simple.c \
  crypto/ec/util-64.c \
  crypto/ec/wnaf.c \
  crypto/ecdh/ecdh.c \
  crypto/ecdsa/ecdsa.c \
  crypto/ecdsa/ecdsa_asn1.c \
  crypto/err/err.c \
  crypto/evp/digestsign.c \
  crypto/evp/evp.c \
  crypto/evp/evp_ctx.c \
  crypto/evp/pbkdf.c \
  crypto/evp/p_ec.c \
  crypto/evp/p_rsa.c \
  crypto/evp/sign.c \
  crypto/hkdf/hkdf.c \
  crypto/hmac/hmac.c \
  crypto/md4/md4.c \
  crypto/md5/md5.c \
  crypto/mem.c \
  crypto/modes/cbc.c \
  crypto/modes/ctr.c \
  crypto/modes/gcm.c \
  crypto/poly1305/poly1305.c \
  crypto/poly1305/poly1305_arm.c \
  crypto/poly1305/poly1305_vec.c \
  crypto/rand/hwrand.c \
  crypto/rand/rand.c \
  crypto/rand/urandom.c \
  crypto/rc4/rc4.c \
  crypto/refcount_c11.c \
  crypto/refcount_lock.c \
  crypto/rsa/blinding.c \
  crypto/rsa/padding.c \
  crypto/rsa/rsa.c \
  crypto/rsa/rsa_asn1.c \
  crypto/rsa/rsa_impl.c \
  crypto/sha/sha1.c \
  crypto/sha/sha256.c \
  crypto/sha/sha512.c \
  crypto/thread.c \
  $(NULL))

# TODO: make all .a files depend on these too.
RING_x86_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/aes/asm/aes-586.pl \
  crypto/aes/asm/aesni-x86.pl \
  crypto/aes/asm/vpaes-x86.pl \
  crypto/bn/asm/bn-586.pl \
  crypto/bn/asm/co-586.pl \
  crypto/bn/asm/x86-mont.pl \
  crypto/md5/asm/md5-586.pl \
  crypto/modes/asm/ghash-x86.pl \
  crypto/sha/asm/sha1-586.pl \
  crypto/sha/asm/sha256-586.pl \
  crypto/sha/asm/sha512-586.pl \
  $(NULL))

RING_x86_64_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/aes/asm/aes-x86_64.pl \
  crypto/aes/asm/aesni-x86_64.pl \
  crypto/aes/asm/bsaes-x86_64.pl \
  crypto/aes/asm/vpaes-x86_64.pl \
  crypto/bn/asm/rsaz-avx2.pl \
  crypto/bn/asm/x86_64-mont.pl \
  crypto/bn/asm/x86_64-mont5.pl \
  crypto/md5/asm/md5-x86_64.pl \
  crypto/modes/asm/aesni-gcm-x86_64.pl \
  crypto/modes/asm/ghash-x86_64.pl \
  crypto/rand/asm/rdrand-x86_64.pl \
  crypto/sha/asm/sha1-x86_64.pl \
  crypto/sha/asm/sha256-x86_64.pl \
  crypto/sha/asm/sha512-x86_64.pl \
  $(NULL))

RING_armv7_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/aes/asm/aes-armv4.pl \
  crypto/aes/asm/aesv8-armx.pl \
  crypto/aes/asm/bsaes-armv7.pl \
  crypto/bn/asm/armv4-mont.pl \
  crypto/modes/asm/ghash-armv4.pl \
  crypto/modes/asm/ghashv8-armx.pl \
  crypto/sha/asm/sha1-armv4-large.pl \
  crypto/sha/asm/sha256-armv4.pl \
  crypto/sha/asm/sha512-armv4.pl \
  $(NULL))

RING_armv8_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/sha/asm/sha1-armv8.pl \
  crypto/sha/asm/sha512-armv8.pl \
  $(NULL))

RING_SRCS += $(RING_$(TARGET_ARCH_BASE)_SRCS)

# TODO: Allow the choice of crypto/thread_none.c instead.
RING_SRCS += $(addprefix $(RING_PREFIX), crypto/thread_pthread.c)

RING_OBJS = $(addprefix $(OBJ_PREFIX), \
  $(patsubst %.c, %.o, \
  $(patsubst %.pl, %.o, \
  $(RING_SRCS)))) \
  $(RING_$(TARGET_ARCH_BASE)_EXTRA_OBJS) \
  $(NULL)

RING_LIB = $(LIB_PREFIX)libring.a

# Recent versions of Linux have the D flag for deterministic builds, but Darwin
# (at least) doesn't. Accroding to Debian's documentation, binutils is built
# with --enable-determnistic-archives by default and we shouldn't need to
# worry about it.
$(RING_LIB): ARFLAGS = crs
$(RING_LIB): $(RING_OBJS) $(RING_PREFIX)mk/ring.mk
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(filter-out $(RING_PREFIX)mk/ring.mk, $^)

RING_TEST_LIB_SRCS = \
  crypto/test/file_test.cc \
  crypto/test/malloc.cc \
  crypto/test/test_util.cc \
  $(NULL)

RING_TEST_LIB_OBJS = $(addprefix $(OBJ_PREFIX), \
  $(patsubst %.c, %.o, \
  $(patsubst %.cc, %.o, \
  $(RING_TEST_LIB_SRCS))))

RING_TEST_MAIN_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/aes/aes_test.cc \
  crypto/bn/bn_test.cc \
  crypto/bytestring/bytestring_test.cc \
  crypto/cipher/aead_test.cc \
  crypto/cipher/cipher_test.cc \
  crypto/cmac/cmac_test.cc \
  crypto/constant_time_test.c \
  crypto/dh/dh_test.cc \
  crypto/digest/digest_test.cc \
  crypto/ec/example_mul.c \
  crypto/ecdsa/ecdsa_test.cc \
  crypto/err/err_test.cc \
  crypto/evp/pbkdf_test.cc \
  crypto/hkdf/hkdf_test.c \
  crypto/hmac/hmac_test.cc \
  crypto/modes/gcm_test.c \
  crypto/poly1305/poly1305_test.cc \
  crypto/refcount_test.c \
  crypto/rsa/rsa_test.cc \
  crypto/thread_test.c \
  $(NULL))

RING_TEST_MAIN_OBJS = $(addprefix $(OBJ_PREFIX), \
  $(patsubst %.c, %.o, \
  $(patsubst %.cc, %.o, \
  $(RING_TEST_MAIN_SRCS))))

RING_TEST_EXES = $(RING_TEST_MAIN_OBJS:$(OBJ_PREFIX)%.o=$(EXE_PREFIX)%)

$(RING_TEST_EXES): LDLIBS += $(RING_LDLIBS)
$(RING_TEST_EXES): $(EXE_PREFIX)% : \
  $(OBJ_PREFIX)%.o \
  $(RING_LIB) \
  $(RING_TEST_LIB_OBJS) \
  $(NULL)
	$(CXX) $(filter-out $(RING_LIB),$^) $(LDFLAGS) $(LDLIBS) $(TARGET_ARCH) -o $@

# TODO: Fix the code so -Wno- overrides are not needed.
$(RING_OBJS) \
$(RING_TEST_LIB_OBJS) \
$(RING_TEST_MAIN_OBJS) \
$(NULL): CPPFLAGS += $(RING_CPPFLAGS) \
                     -DBORINGSSL_IMPLEMENTATION \
                     -Wno-cast-qual \
                     -Wno-pedantic \
                     -Wno-sign-compare \
                     -Wno-unused-parameter \
                     -Wno-cast-align \
                     -Wno-format \
                     -Wno-format-nonliteral \
                     -Wno-type-limits \
                     $(NULL)
$(RING_OBJS) \
$(RING_TEST_LIB_OBJS) \
$(RING_TEST_MAIN_OBJS) \
$(NULL): CFLAGS += -Wno-bad-function-cast \
                   -Wno-nested-externs \
                   $(NULL)


PERLASM_LIB_SRCS = $(addprefix $(RING_PREFIX), \
  crypto/perlasm/arm-xlate.pl \
  crypto/perlasm/cbc.pl \
  crypto/perlasm/x86asm.pl \
  crypto/perlasm/x86gas.pl \
  crypto/perlasm/x86masm.pl \
  crypto/perlasm/x86nasm.pl \
  crypto/perlasm/x86_64-xlate.pl \
  $(NULL))

PERL_EXECUTABLE ?= perl

# The British spelling "flavour" is used for consistency with perlasm's code.
ifeq ($(findstring darwin,$(TARGET_SYS)),darwin)
PERLASM_FLAVOUR ?= macosx
else
PERLASM_FLAVOUR ?= elf
endif

PERLASM_x86_ARGS = $(PERLASM_FLAVOUR) -fPIC -DOPENSSL_IA32_SSE2
PERLASM_x86_64_ARGS = $(PERLASM_FLAVOUR)
PERLASM_ARGS = $(PERLASM_$(TARGET_ARCH_BASE)_ARGS)

$(OBJ_PREFIX)%.S: %.pl $(PERLASM_LIB_SRCS)
	${PERL_EXECUTABLE} $< $(PERLASM_ARGS) > $@

.PHONY: check-ring
check-ring::
	go run $(RING_PREFIX)util/all_tests.go --build-dir=$(EXE_PREFIX)
