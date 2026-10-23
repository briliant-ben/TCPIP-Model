#ifndef PROTOCOL_LAB_ARCH_CC_H
#define PROTOCOL_LAB_ARCH_CC_H
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#define LWIP_PLATFORM_ASSERT(x) do { fprintf(stderr, "lwIP assertion: %s\n", (x)); abort(); } while (0)
#define LWIP_RAND() ((uint32_t)rand())
#endif
