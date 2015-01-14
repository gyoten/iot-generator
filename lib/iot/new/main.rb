Template_main = <<-EOS
#ifndef INCLUDED_MBED
#include "mbed.h"
#endif

#ifndef INCLUDED_BLEDEVICE
#include "BLEDevice.h"
#endif

#include "STService.h"
#include "STBLEDevice.h"

STBLEDevice ble;

/**
 * BLE callback
 */
void onConnectionCallback(Gap::Handle_t handle, Gap::addr_type_t peerAddrType, const Gap::address_t peerAddr, const Gap::ConnectionParams_t *params)
{
}

void disconnectionCallback(Gap::Handle_t handle, Gap::DisconnectionReason_t reason)
{
  ble.startAdvertising();
}

void onDataWritten(const GattCharacteristicWriteCBParams *params)
{
}

/**
 * main function
 */
int main(void) {

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
    /*
     * write some code
     */
  }
}
EOS
