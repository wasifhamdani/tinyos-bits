#include "task5.h"
#include "printf.h"
configuration task5AppC{
}
implementation{
	components MainC;
	components LedsC;
	components task5C2 as App;
	components ActiveMessageC;
	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	components new AMSenderC(AM_SEND);
	components new AMReceiverC(AM_SEND);
	components PrintfC;
	components SerialStartC;
  
   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Timer0 -> Timer0;
   App.Timer1 -> Timer1;   
   App.Packet -> AMSenderC;
   App.AMPacket -> AMSenderC;
   App.AMSend -> AMSenderC;
   App.AMControl -> ActiveMessageC;
   App.Receive -> AMReceiverC;
}
