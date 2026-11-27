# FreeRTOS Port (`port/freertos/`)

`sys_port_freertos.c` implements the architecture abstraction declared in `include/tcpip/sys.h` on top of FreeRTOS primitives:

- `sys_sem_t`: binary semaphore (`xSemaphoreCreateBinary` / `xSemaphoreCreateCounting`, `xSemaphoreTake`, `xSemaphoreGive`)
- `sys_mbox_t`: fixed-size pointer queue (`xQueueCreate(TCPIP_MBOX_SIZE, sizeof(void *))`, `xQueueSend`, `xQueueReceive`)
- `sys_thread_t`: FreeRTOS task (`xTaskCreate`)
- `sys_now()`: millisecond clock (`xTaskGetTickCount() * portTICK_PERIOD_MS`)

## Usage
1. Ensure FreeRTOS headers (`FreeRTOS.h`, `task.h`, `semphr.h`, `queue.h`) are in the include search path.
2. Compile with `-DTCPIP_NO_SYS=0` alongside `src/core/*.c`, `src/api/*.c`, and `port/freertos/sys_port_freertos.c` (excluding `port/posix/sys_port.c`).
3. Call `tcpip_init(app_ready_cb, ctx)` after starting the scheduler or inside a bootstrap task; `tcpip_thread` becomes the single-writer actor owning all PCBs and timers.
