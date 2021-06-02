#include "led_driver.h"


static uint16_t * leds_address;
void LedDriver_Create(uint16_t * address)
{
    leds_address = address;
    *leds_address = 0u;
}

void LedDriver_Destroy(void)
{

}