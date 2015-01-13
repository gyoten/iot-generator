Template_stbledevice = <<-EOS

#ifndef INCLUDED_BLEDEVICE
#include "BLEDevice.h"
#endif

#ifndef INCLUDED_STDEVICEINFO
#include "STDeviceInfo.h"
#endif


class STBLEDevice : public BLEDevice{
public:
  /**
   * Initialize BLEDevice instanse
   */
  void setup() {
    this->init();
    this->setDeviceName( (const uint8_t *)COMP_NAME );
  }

  /**
   * Add Service array
   * @param *GattServices array of GATT service
   * @param length length of *GattServices array
   */
  void addServices(GattService *GattServices[], uint16_t length) {
  	for (int i=0; i<length ; i++) {
    	this->addService( *GattServices[i] );
  	}
  }

  /**
   * Set Advertising Packet
   */
  void setAdPacket() {
    /**
     * Set PDU type
     * Types of PDU type
     * - ADV_CONNECTABLE_UNDIRECTED
     * - ADV_CONNECTABLE_DIRECTED
     * - ADV_SCANNABLE_UNDIRECTED
     * - ADV_NON_CONNECTABLE_UNDIRECTED
     */
    GapAdvertisingParams::AdvertisingType advType = GapAdvertisingParams::ADV_CONNECTABLE_UNDIRECTED;
    this->setAdvertisingType( advType );

    /**
     * Set Flags
     * - BR/EDR not supported
     */
    this->accumulateAdvertisingPayload(GapAdvertisingData::BREDR_NOT_SUPPORTED);

    /**
     * Set Device Name.
     * Developer has to choose one from belows.
     * - SHORTENED_LOCAL_NAME
     * - COMPLETE_LOCAL_NAME
     */
    if (SHORT_FLG) {
      this->accumulateAdvertisingPayload(
          GapAdvertisingData::SHORTENED_LOCAL_NAME,
          (const uint8_t *)SHORT_NAME,
          sizeof(SHORT_NAME)
                                         );
    } else {
      this->accumulateAdvertisingPayload(
          GapAdvertisingData::COMPLETE_LOCAL_NAME,
          (const uint8_t *)COMP_NAME,
          sizeof(COMP_NAME)
                                         );
    }

    /**
     * Set advertising Interval
     */
    this->setAdvertisingInterval(AD_INTERVAL);
  }

};


EOS
