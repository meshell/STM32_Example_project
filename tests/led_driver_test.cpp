extern "C"
{
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

TEST(LED_Driver, Dummy)
{
  CHECK(false);
}