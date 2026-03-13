/*
 * Stub implementations of GCC atomic builtins for RISC-V (e.g. ESP32-C3)
 * when libatomic is not available in the toolchain. Uses Zephyr's atomic API.
 * Only linked when building for RISC-V (see CMakeLists.txt).
 */
#include <zephyr/kernel.h>
#include <stdbool.h>
#include <stdint.h>

/* GCC libatomic ABI: 4-byte compare-and-exchange */
bool __atomic_compare_exchange_4(void *ptr, void *expected, uint32_t desired,
				 int weak, int success_memorder, int failure_memorder)
{
	(void)weak;
	(void)success_memorder;
	(void)failure_memorder;
	uint32_t exp = *(uint32_t *)expected;
	bool ok = atomic_cas((atomic_t *)ptr, (atomic_val_t)exp, (atomic_val_t)desired);
	if (!ok)
		*(uint32_t *)expected = (uint32_t)atomic_get((atomic_t *)ptr);
	return ok;
}

/* GCC libatomic ABI: 4-byte exchange */
uint32_t __atomic_exchange_4(void *ptr, uint32_t val, int memorder)
{
	(void)memorder;
	return (uint32_t)atomic_set((atomic_t *)ptr, (atomic_val_t)val);
}
