Template_main = <<-EOS
/* Strobo BLE Prototyping 1
 * Copyright (c) 2014 Strobo, inc
 *
 * Product name: Strobo Tap
 * Description:
 *  A SSR controller with BLE
 */

#define CONSOLE_OUTPUT true

#if CONSOLE_OUTPUT
#define DEBUG(...) { printf(__VA_ARGS__); }
#else
#define DEBUG(...) /* nothing */
#endif

#ifndef INCLUDED_MBED
#include "mbed.h"
#endif

#ifndef INCLUDED_BLEDEVICE
#include "BLEDevice.h"
#endif

#include "STService.h"
#include "STBLEDevice.h"

DigitalOut ssrPin(p18);
Serial pc(USBTX, USBRX);
STBLEDevice ble;

/*
 * BLE callback
 */
void onConnectionCallback(Gap::Handle_t handle, Gap::addr_type_t peerAddrType, const Gap::address_t peerAddr, const Gap::ConnectionParams_t *params)
{
  DEBUG("BLE: OnConnection\\n\\r");
}

void disconnectionCallback(Gap::Handle_t handle, Gap::DisconnectionReason_t reason)
{
	DEBUG("BLE: Disconneted\\n\\r");
	ble.startAdvertising(); // restart advertising
}

void onDataWritten(const GattCharacteristicWriteCBParams *params)
{
  if ( params->charHandle == PowerControlChar.getValueHandle() ) {
		DEBUG("Data is written\\n\\r");
  }
}

/*
 * main function
 */

int timeCnt = 0;

int main(void) {

  ssrPin = 0;

  ble.setup();  // custom method of STBLEDevice class
  ble.setAdPacket(); // custom method of STBLEDevice class
  uint8_t serviceCount = sizeof(GattServices) / sizeof(GattService *);
  ble.addServices( GattServices, serviceCount ); // custom method of STBLEDevice class
  
  // set up callback
  ble.onConnection( onConnectionCallback );
  ble.onDisconnection( disconnectionCallback );
	ble.onDataWritten( onDataWritten );

  ble.startAdvertising();

  while (true) {
    //ble.waitForEvent();

    uint8_t temp1[8];

    uint16_t bytesRead;
    ble.readCharacteristicValue(PowerControlChar.getValueHandle(), temp1, &bytesRead);
    if (temp1[0] > 0) {
      if (timeCnt < 255) {
        timeCnt++;
      } else {
        timeCnt = 0;
      }
	    DEBUG("time: %d\\n\\r", timeCnt);

      uint8_t temp[8] = {timeCnt, };
	    ble.updateCharacteristicValue(TimeMonitorChar.getValueHandle(), temp, sizeof(temp));
    }

    uint16_t bytesRead1 = 8;
    ble.readCharacteristicValue(PowerControlChar.getValueHandle(), temp1, &bytesRead1);
    wait(temp1[0] / 10.0);
  }
}
EOS
