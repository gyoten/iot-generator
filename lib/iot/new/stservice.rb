Template_stservice = <<-EOS
EOS


# #ifndef INCLUDED_MBED
# #include "mbed.h"
# #endif

# #ifndef INCLUDED_BLEDEVICE
# #include "BLEDevice.h"
# #endif

# /*
#  * Power control service
#  * Service_Uuid: 0xFF00
#  */
# static const uint16_t power_control_char_uuid = 0xFF00;
# uint8_t power_control_char_value[8] = {0,};
# GattCharacteristic PowerControlChar(
#                                     power_control_char_uuid,
#                                     power_control_char_value,
#                                     sizeof(power_control_char_value),
#                                     sizeof(power_control_char_value),
#                                     GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_READ |
#                                     GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_WRITE
#                                     );

# static const uint16_t power_state_char_uuid = 0xFF01;
# uint8_t power_state_char_value[8] = {0x41,0x42,0x43};
# GattCharacteristic PowerStateChar(
#                                   power_state_char_uuid,
#                                   power_state_char_value,
#                                   sizeof(power_control_char_value),
#                                   sizeof(power_control_char_value),
#                                   GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_READ
# );

# GattCharacteristic *PowerControlChars[] = { &PowerControlChar, &PowerStateChar };

# static const uint8_t power_control_service_uuid[] = {
#   0x7d, 0x2e, 0x51, 0xcd,
#   0x5a, 0xa0,
#   0x4f, 0x45,
#   0x84, 0xcf,
#   0xad, 0x3d, 0xbd, 0xf2, 0x54, 0x40
# };
# GattService PowerControlService(
#                                 power_control_service_uuid,
#                                 PowerControlChars,
#                                 sizeof(PowerControlChars) / sizeof(GattCharacteristic *)
#                                 );

# /**
#  * 2nd Service
#  */
# static const uint16_t energy_monitor_char_uuid = 0xFF01;
# uint8_t energy_monitor_char_value[8] = {0,};
# GattCharacteristic EnergyMonitorChar(
#                                      energy_monitor_char_uuid,
#                                      energy_monitor_char_value,
#                                      sizeof(energy_monitor_char_value),
#                                      sizeof(energy_monitor_char_value),
#                                      GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_READ
# );

# GattCharacteristic *EnergyChars[] = { &EnergyMonitorChar };

# static const uint8_t energy_service_uuid[] = {
#   0x7d, 0x2e, 0x51, 0xcd,
#   0x5a, 0xa0,
#   0x4f, 0x45,
#   0x84, 0xcf,
#   0xad, 0x3d, 0xbd, 0xf2, 0x54, 0x41
# };

# GattService EnergyService(
#                           energy_service_uuid,
#                           EnergyChars,
#                           sizeof(EnergyChars) / sizeof(GattCharacteristic *)
# );

# /**
#  * Time Count Service
#  */
# static const uint16_t time_monitor_char_uuid = 0xFF01;
# uint8_t time_monitor_char_value[8] = {0,};
# GattCharacteristic TimeMonitorChar(
#     time_monitor_char_uuid,
#     time_monitor_char_value,
#     sizeof(time_monitor_char_value),
#     sizeof(time_monitor_char_value),
#     //GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_READ
#     GattCharacteristic::BLE_GATT_CHAR_PROPERTIES_NOTIFY
# );

# GattCharacteristic *TimeChars[] = { &TimeMonitorChar };

# static const uint8_t time_service_uuid[] = {
#   0x7d, 0x2e, 0x51, 0xcd,
#   0x5a, 0xa0,
#   0x4f, 0x45,
#   0x84, 0xcf,
#   0xad, 0x3d, 0xbd, 0xf2, 0x54, 0x42
# };

# GattService TimeService(
#     time_service_uuid,
#     TimeChars,
#     sizeof(TimeChars) / sizeof(GattCharacteristic *)
# );

# GattService *GattServices[] = {
#   &EnergyService,
#   &PowerControlService,
#   &TimeService };



