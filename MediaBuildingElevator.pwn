#include <a_samp>
#include <streamer>
#include <string>
new dtDialogID = 3011;
new dtOBJ[10];
new Float:dtHeight[30];
new Float:dtDoorHeight[30];
new LeftDoorOBJ[50];
new RightDoorOBJ[50];
new CurrentFloor = 1;
new dtMoving;
new DoorOpen[30];
new FloorText[30][64];
new Text3D:Tips3DText[60];
public OnFilterScriptInit()
{
	printf("[��ý����]���ڴ���....");
	format(FloorText[1],64,"1¥");
	format(FloorText[2],64,"2¥");
	format(FloorText[3],64,"3¥");
	format(FloorText[4],64,"4¥");
	format(FloorText[5],64,"5¥");
	format(FloorText[6],64,"6¥");
	format(FloorText[7],64,"7¥");
	format(FloorText[8],64,"8¥");
	format(FloorText[9],64,"9¥");
	format(FloorText[10],64,"10¥");
	format(FloorText[11],64,"11¥");
	format(FloorText[12],64,"12¥");
	format(FloorText[13],64,"13¥");
	format(FloorText[14],64,"14¥");
	format(FloorText[15],64,"15¥");
    format(FloorText[16],64,"16¥");
    format(FloorText[17],64,"17¥");
    format(FloorText[18],64,"18¥");
    format(FloorText[19],64,"19¥");
    format(FloorText[20],64,"20¥");
    format(FloorText[21],64,"21¥");
	dtHeight[1] = 14.6084;
	dtHeight[2] = 23.1484;
	dtDoorHeight[1] = 14.5746;
	dtDoorHeight[2] = dtDoorHeight[1] + 8.53;
	for(new i = 3; i <= 21 ; i++){
		dtHeight[i] = dtHeight[i-1] + 5.45;
		dtDoorHeight[i] = dtDoorHeight[i-1] + 5.45;
	}
	DoorOpen[1] = 1;
	dtOBJ[0] = CreateDynamicObject(18755,1786.6709,-1303.4305,dtHeight[1],0,0,270);//����
	dtOBJ[1] = CreateDynamicObject(18756,1786.684936-1.8,-1303.395996,dtDoorHeight[1],0,0,-90);//����������  --�͵���һ���ƶ�
	dtOBJ[2] = CreateDynamicObject(18757,1786.684936+1.8,-1303.395996,dtDoorHeight[1],0,0,-90);//����������  --�͵���һ���ƶ�
	LeftDoorOBJ[1] = CreateDynamicObject(18757,1786.684936+1.8,-1303.185996,dtDoorHeight[1],0,0,-90);//��������
	RightDoorOBJ[1] = CreateDynamicObject(18756,1786.684936-1.8,-1303.185996,dtDoorHeight[1],0,0,-90);//��������

	for(new i = 2; i <= 21 ; i++){
		RightDoorOBJ[i] = CreateDynamicObject(18756,1786.684936,-1303.185996,dtDoorHeight[i],0,0,-90);//��������
		LeftDoorOBJ[i] = CreateDynamicObject(18757,1786.684936,-1303.185996,dtDoorHeight[i],0,0,-90);//��������
        DoorOpen[i] = 0;
	}
	for(new i = 1; i <= 21 ; i++){
	    new tips[256];
	    format(tips,sizeof(tips),"{FFFF00}[%s]{00FF00}��[{FF0000}H{00FF00}]���е���",FloorText[i]);
		Tips3DText[i] = CreateDynamic3DTextLabel(tips, 0xFFFFFFFF,1786.7131,-1298.09,dtDoorHeight[i] - 1.5, 5,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0);
        format(tips,sizeof(tips),"{FFFF00}[%s]{00FF00}{00FF00}��[{FF0000}Y{00FF00}]ѡ��¥��",FloorText[i]);
		Tips3DText[21 + i] = CreateDynamic3DTextLabel("{00FF00}��[{FF0000}Y{00FF00}]ѡ��¥��", 0xFFFFFFFF,1786.72,-1304.75,dtDoorHeight[i] - 1.5, 5,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0);
	}
	printf("[��ý����]�������");
	CurrentFloor = 1;
	dtMoving = 0;
	return 1;
}

public OnFilterScriptExit()
{
    for(new i = 1; i <= 150 ; i++){
    	if(IsValidDynamicObject(dtOBJ[i])){
			DestroyDynamicObject(dtOBJ[i]);
		}
		if(IsValidDynamicObject(LeftDoorOBJ[i])){
			DestroyDynamicObject(LeftDoorOBJ[i]);
		}
		if(IsValidDynamicObject(RightDoorOBJ[i])){
			DestroyDynamicObject(RightDoorOBJ[i]);
		}
		if(IsValidDynamicObject(dtOBJ[i])){
			DestroyDynamicObject(dtOBJ[i]);
		}
		if(IsValidDynamic3DTextLabel(Tips3DText[i])){
			DestroyDynamic3DTextLabel(Tips3DText[i]);
		}
		if(IsValidDynamic3DTextLabel(Tips3DText[i + 21])){
			DestroyDynamic3DTextLabel(Tips3DText[i + 21]);
		}
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == dtDialogID){
		if(response){
		    if(listitem != 0 && listitem != CurrentFloor && dtMoving == 0){
		    	new msg[256];
            	CloseDoor();
 				SetTimerEx("GotoFloor",2000,false,"i",listitem);
				printf("[��ý��¥]����ǰ��%d¥",listitem);
				format(msg,sizeof(msg),"{FFFF00}[��ý��¥]���ݼ���ǰ��[{00FF00}%s{FFFF00}]",FloorText[listitem]);
				SendClientMessage(playerid,-1,msg);
				dtMoving = 1;
			}
		}
	}
	return 0;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!IsPlayerInAnyVehicle(playerid) && newkeys == 262144){
		for(new i = 1;i<= 21; i++){
			if(IsPlayerInRangeOfPoint(playerid,3,1786.7131,-1298.09,dtDoorHeight[i])){
				if(i != CurrentFloor){
					new msg[256];
				    if(dtMoving != 1){
				    	CloseDoor();
				    	SetTimerEx("GotoFloor",2000,false,"i",i);
						printf("[��ý��¥]%d¥���е���",i);
						format(msg,sizeof(msg),"{FFFF00}[��ý��¥]���Ѻ���[{00FF00}%s{FFFF00}]���ݣ������ĵȴ�!",FloorText[i]);
						SendClientMessage(playerid,-1,msg);
						dtMoving = 1;
						new tips[256];
						format(tips,sizeof(tips),"{FF1493}[{00FF00}%s{FFFF00}{FF1493}]�������ڸ����������ĵȴ�!",FloorText[i]);
						UpdateDynamic3DTextLabelText(Tips3DText[i],0xFFFFFFFF,tips);
					}
					else{
                        format(msg,sizeof(msg),"{FFFF00}[��ý��¥]��������ǰ��[{00FF00}%s{FFFF00}]����ȴ����ݵ�����ٺ��е���",FloorText[CurrentFloor]);
                        SendClientMessage(playerid,-1,msg);
					}
				}
				break;
			}
		}
	}
	if(!IsPlayerInAnyVehicle(playerid) && newkeys == 	65536){
		for(new i = 1;i<= 21; i++){
			if(IsPlayerInRangeOfPoint(playerid,2,1786.72,-1304.75,dtDoorHeight[i])){
   				if(dtMoving == 0){
                    new dialogMsg[512];
       				format(dialogMsg,sizeof(dialogMsg),"{00FF00}��ѡ��¥��");
		    		for(new j = 1;j<= 21; j++){
		    	    	if(j != i){
	    					format(dialogMsg,sizeof(dialogMsg),"%s\n%s",dialogMsg,FloorText[j]);
						}
						else{
    						format(dialogMsg,sizeof(dialogMsg),"%s\n{FF0000}%s",dialogMsg,FloorText[j]);
						}
					}
					ShowPlayerDialog(playerid,dtDialogID,DIALOG_STYLE_LIST,"��ý����",dialogMsg,"ǰ��","ȡ��");
			    	break;
	   			}
	   			else{
					SendClientMessage(playerid,-1,"{FFFF00}[��ý��¥]���������ƶ������Ժ�!");
				}
			}
		}
	}
	return 1;
}
forward OpenDoor();
public OpenDoor()
{
	new Float:x,Float:y,Float:z;
	GetDynamicObjectPos(LeftDoorOBJ[CurrentFloor],x,y,z);
	MoveDynamicObject(LeftDoorOBJ[CurrentFloor],x+1.8,y,z,5);
	GetDynamicObjectPos(RightDoorOBJ[CurrentFloor],x,y,z);
	MoveDynamicObject(RightDoorOBJ[CurrentFloor],x-1.8,y,z,5);
	DoorOpen[CurrentFloor] = 1;
	GetDynamicObjectPos(dtOBJ[1],x,y,z);
	MoveDynamicObject(dtOBJ[1],x-1.8,y,z,5);
	GetDynamicObjectPos(dtOBJ[2],x,y,z);
	MoveDynamicObject(dtOBJ[2],x+1.8,y,z,5);
	dtMoving = 0;
	new tips[256];
	format(tips,sizeof(tips),"{FFFF00}[%s]{00FF00}��[{FF0000}H{00FF00}]���е���",FloorText[CurrentFloor]);
	UpdateDynamic3DTextLabelText(Tips3DText[CurrentFloor],0xFFFFFFFF,tips);
}
forward CloseDoor();
public CloseDoor()
{
	new Float:x,Float:y,Float:z;
	GetDynamicObjectPos(LeftDoorOBJ[CurrentFloor],x,y,z);
	MoveDynamicObject(LeftDoorOBJ[CurrentFloor],x-1.8,y,z,5);
	GetDynamicObjectPos(RightDoorOBJ[CurrentFloor],x,y,z);
	MoveDynamicObject(RightDoorOBJ[CurrentFloor],x+1.8,y,z,5);
	DoorOpen[CurrentFloor] = 0;
	GetDynamicObjectPos(dtOBJ[1],x,y,z);
	MoveDynamicObject(dtOBJ[1],x+1.8,y,z,5);
	GetDynamicObjectPos(dtOBJ[2],x,y,z);
	MoveDynamicObject(dtOBJ[2],x-1.8,y,z,5);
}
forward GotoFloor(fid);
public GotoFloor(fid)
{
	MoveDynamicObject(dtOBJ[0],1786.6709,-1303.4305,dtHeight[fid],5);
	MoveDynamicObject(dtOBJ[1],1786.684936,-1303.395996,dtDoorHeight[fid],5);
	MoveDynamicObject(dtOBJ[2],1786.684936,-1303.395996,dtDoorHeight[fid],5);
	new Float:diff = dtHeight[fid] - dtHeight[CurrentFloor];
	if(diff < 0) diff = - diff;
	new Float:time = diff / 5 * 1000;
	new tmp[20];
	format(tmp,sizeof(tmp),"%.0f",time+2000);
	SetTimer("OpenDoor", strval(tmp), false);
	CurrentFloor = fid;
}
