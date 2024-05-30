#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>

void main(void) {

    while (1) {
        printk("Hello World !\n");
        k_msleep(1000);
    }
}
