/* Copyright (c) 2015, Google Inc.
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE. */

#ifndef OPENSSL_HEADER_CRYPTO_TEST_TEST_UTIL_H
#define OPENSSL_HEADER_CRYPTO_TEST_TEST_UTIL_H

#include <stddef.h>
#include <stdio.h>

#if defined(_MSC_VER) && _MSC_VER < 1900
#define OPENSSL_PR_SIZE_T "Iu" /* MSVC doesn't support %zu until MSVC 2015. */
#else
#define OPENSSL_PR_SIZE_T "zu" /* "%zu" is the C99 standard format specifier. */
#endif

#if defined(__cplusplus)
extern "C" {
#endif

void hexdump(FILE *fp, const char *msg, const void *in, size_t len);

#if defined(__cplusplus)
}
#endif

#endif /* OPENSSL_HEADER_CRYPTO_TEST_TEST_UTIL_H */
