#include <Timer.h>
#include "task415.h"
#include "printf.h"

module task415C{
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface SplitControl as AMControl;
	uses interface Receive;
}
implementation{
	bool busy=FALSE;
	bool check=FALSE;
	uint32_t counter=0;
	message_t pkt;
	am_addr_t x;
	uint8_t hops=0;
	int i=0;
	uint32_t avx=0;

	event void Boot.booted(){
		// TODO Auto-generated method stub
		call AMControl.start();
	}

	event void AMControl.startDone(error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
	
		}else{
			call AMControl.start();
		}
	}


	event void Timer0.fired(){
	counter++;
	
		if(call AMSend.send(AM_BROADCAST_ADDR,&pkt, sizeof(task3CMsg))==SUCCESS){
			call Leds.led2Toggle();			
			}
	}

	event void AMControl.stopDone(error_t error){
		// TODO Auto-generated method stub
	}

	event void AMSend.sendDone(message_t *msg, error_t error){
		// TODO Auto-generated method stub
		if(error==SUCCESS){
			task3CMsg* btrpkt = (task3CMsg*)(call Packet.getPayload(&pkt, sizeof (task3CMsg)));						
			busy=FALSE;
			btrpkt->sourceid0=TOS_NODE_ID;
			btrpkt->sourceid1=0;
			btrpkt->sourceid2=0;
			btrpkt->sourceid3=0;
			btrpkt->sourceid4=0;
			btrpkt->sourceid5=0;
			btrpkt->sourceid6=0;
			btrpkt->sourceid7=0;
			btrpkt->sourceid8=0;
			btrpkt->sourceid9=0;
			btrpkt->sourceid10=0;
			btrpkt->sourceid11=0;
			btrpkt->sourceid12=0;
			btrpkt->hopcnt=1;
			if(TOS_NODE_ID==1)
			btrpkt->counter0=counter;
			else
			btrpkt->counter0=0;
			hops=1;
		}
	}

	event message_t * Receive.receive(message_t *msg, void *payload, uint8_t len){
		// TODO Auto-generated method stub
				
		//Saving the packet and appending it
		x=call AMPacket.source(msg);
		if(x==16){		//16
			task3CMsg* btrpkt = (task3CMsg*)(call Packet.getPayload(&pkt, sizeof (task3CMsg)));
			counter=0;
			call Leds.led0Toggle();
			btrpkt->sourceid0=TOS_NODE_ID;
			btrpkt->sourceid1=0;
			btrpkt->sourceid2=0;
			btrpkt->sourceid3=0;
			btrpkt->sourceid4=0;
			btrpkt->sourceid5=0;
			btrpkt->sourceid6=0;
			btrpkt->sourceid7=0;
			btrpkt->sourceid8=0;
			btrpkt->sourceid9=0;
			btrpkt->sourceid10=0;
			btrpkt->sourceid11=0;
			btrpkt->sourceid12=0;
			btrpkt->hopcnt=1;
			if(TOS_NODE_ID==1)
			btrpkt->counter0=counter;
			else
			btrpkt->counter0=0;
			hops=1;
			call Timer0.startPeriodicAt(TOS_NODE_ID*TIMER_PERIOD_MILLI,9000);
			avx=TOS_NODE_ID*TIMER_PERIOD_MILLI;
		}
		else{
			task3CMsg* btrpkt=(task3CMsg*) payload;
			call Leds.led1Toggle();
			if((TOS_NODE_ID-x)==1){
				check=TRUE;
			}else if((TOS_NODE_ID-x)==4){
				check=TRUE;
			}
			if(check){
				task3CMsg* reqd = (task3CMsg*)(call Packet.getPayload(&pkt, sizeof (task3CMsg)));
				if(hops==1){//////IF HOPS then IF HOPCNTR
					for(i=1;i<(btrpkt->hopcnt)+1;i++){
						switch(i){
							case(1):reqd->sourceid1=btrpkt->sourceid0;
								break;
							case(2):reqd->sourceid2=btrpkt->sourceid1;
								break;
							case(3):reqd->sourceid3=btrpkt->sourceid2;
								break;
							case(4):reqd->sourceid4=btrpkt->sourceid3;
								break;
							case(5):reqd->sourceid5=btrpkt->sourceid4;
								break;
							case(6):reqd->sourceid6=btrpkt->sourceid5;
								break;
							case(7):reqd->sourceid7=btrpkt->sourceid6;
								break;
							case(8):reqd->sourceid8=btrpkt->sourceid7;
								break;
						}
					}
				}else if(hops==3){//////IF HOPS then IF HOPCNTR
					for(i=1;i<(btrpkt->hopcnt)+1;i++){
						switch(i){
							case(1):reqd->sourceid3=btrpkt->sourceid0;
								break;
							case(2):reqd->sourceid4=btrpkt->sourceid1;
								break;
							case(3):reqd->sourceid5=btrpkt->sourceid2;
								break;
							case(4):reqd->sourceid6=btrpkt->sourceid3;
								break;
							case(5):reqd->sourceid7=btrpkt->sourceid4;
								break;
							case(6):reqd->sourceid8=btrpkt->sourceid5;
								break;
							case(7):reqd->sourceid9=btrpkt->sourceid6;
								break;
							case(8):reqd->sourceid10=btrpkt->sourceid7;
								break; 
						}
					}
				}else if(hops==2){//////IF HOPS then IF HOPCNTR
					for(i=1;i<(btrpkt->hopcnt)+1;i++){
						switch(i){
							case(1):reqd->sourceid2=btrpkt->sourceid0;
								break;
							case(2):reqd->sourceid3=btrpkt->sourceid1;
								break;
							case(3):reqd->sourceid4=btrpkt->sourceid2;
								break;
							case(4):reqd->sourceid5=btrpkt->sourceid3;
								break;
							case(5):reqd->sourceid6=btrpkt->sourceid4;
								break;
							case(6):reqd->sourceid7=btrpkt->sourceid5;
								break;
							case(7):reqd->sourceid8=btrpkt->sourceid6;
								break;
							case(8):reqd->sourceid9=btrpkt->sourceid7;
								break;
						}
					}
				}else if(hops==4){//////IF HOPS then IF HOPCNTR
					for(i=1;i<(btrpkt->hopcnt)+1;i++){
						switch(i){
							case(1):reqd->sourceid4=btrpkt->sourceid0;
								break;
							case(2):reqd->sourceid5=btrpkt->sourceid1;
								break;
							case(3):reqd->sourceid6=btrpkt->sourceid2;
								break;
							case(4):reqd->sourceid7=btrpkt->sourceid3;
								break;
							case(5):reqd->sourceid8=btrpkt->sourceid4;
								break;
							case(6):reqd->sourceid9=btrpkt->sourceid5;
								break;
							case(7):reqd->sourceid10=btrpkt->sourceid6;
								break;
						}					
					}
				}else if(hops==5){
					for(i=1;i<(btrpkt->hopcnt)+1;i++){
						switch(i){
							case(1):reqd->sourceid5=btrpkt->sourceid0;
								break;
							case(2):reqd->sourceid6=btrpkt->sourceid1;
								break;
							case(3):reqd->sourceid7=btrpkt->sourceid2;
								break;
							case(4):reqd->sourceid8=btrpkt->sourceid3;
								break;
							case(5):reqd->sourceid9=btrpkt->sourceid4;
								break;
							case(6):reqd->sourceid10=btrpkt->sourceid5;
								break;
							case(7):reqd->sourceid11=btrpkt->sourceid6;
								break;
						}					
					}
				}else{
				for(i=1;i<(btrpkt->hopcnt)+1;i++){
						switch(i){
							case(1):reqd->sourceid5=btrpkt->sourceid0;
								break;
							case(2):reqd->sourceid6=btrpkt->sourceid1;
								break;
							case(3):reqd->sourceid7=btrpkt->sourceid2;
								break;
							case(4):reqd->sourceid8=btrpkt->sourceid3;
								break;
							case(5):reqd->sourceid9=btrpkt->sourceid4;
								break;
							case(6):reqd->sourceid10=btrpkt->sourceid5;
								break;
							case(7):reqd->sourceid11=btrpkt->sourceid6;
								break;
						}					
					}
				}
				reqd->counter0=btrpkt->counter0;
				hops=hops+btrpkt->hopcnt;
				reqd->hopcnt=hops;
				check=FALSE;
				printfflush();
				printf("%u-%u-%u-%u%u%u%u%u%u%u\n",hops,reqd->counter0,reqd->sourceid0,reqd->sourceid1,reqd->sourceid2,reqd->sourceid3,reqd->sourceid4,reqd->sourceid5,reqd->sourceid6,reqd->sourceid7);
			}
		}
		return msg;
	}
}
