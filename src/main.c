#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>

static const struct device *gpio_ct_dev = 
    DEVICE_DT_GET(DT_NODELABEL(gpio0));


void main(void) {

if (!device_is_ready(gpio_ct_dev))
{
    return;
}

gpio_pin_configure(gpio_ct_dev, 2, GPIO_OUTPUT_ACTIVE);


    while (1) {
        gpio_pin_set_raw(gpio_ct_dev, 2, 1);
        printk("LED ON !\n");
        k_msleep(1000);

        gpio_pin_set_raw(gpio_ct_dev, 2, 0);
        printk("LED OFF !\n");
        k_msleep(1000);
    }
}
