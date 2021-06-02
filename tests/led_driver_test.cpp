extern "C"
{
    #include "led_driver.h"
    // #includes for things with C linkage
}


// #includes for things with C++ linkage

#include "CppUTest/TestHarness.h"

TEST_GROUP(LED_Driver)
{
void setup()
  {
  }

  void teardown()
  {
  }

};

TEST(LED_Driver, Led_off_after_create)
{
  uint16_t virtual_leds = 0xffff;
  LedDriver_Create(&virtual_leds);
  CHECK_EQUAL(0, virtual_leds);     
}