#include "task5.h"
#include "printf.h"
configuration task5AppC{
}
implementation{
	components MainC;
	components LedsC;
	components task5C as App;
	components ActiveMessageC;
	components new TimerMilliC() as Timer0;
	components SerialPrintfC;
	components SerialStartC;
  
   App.Boot -> MainC;
   App.Leds -> LedsC;
   App.Timer0 -> Timer0;
   App.AMControl -> ActiveMessageC;
}
