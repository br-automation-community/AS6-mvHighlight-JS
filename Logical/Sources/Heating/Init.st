

PROGRAM _INIT
	(* Insert code here *)
	Kachel[0].Image := 'Media/AppIcons/Boiler.svg';
	Kachel[1].Image := 'Media/AppIcons/MODE_FireOff.svg';
	Kachel[2].Image := 'Media/AppIcons/MODE_Heating.svg';
	Kachel[3].Image := 'Media/AppIcons/Boiler.svg';
	Kachel[4].Image := 'Media/AppIcons/MODE_IgniteAuto.svg';
	Kachel[5].Image := 'Media/AppIcons/MODE_IgniteTime.svg';
	FOR i := 0 TO 9 DO
		Kachel[i].SetTemp := 50 - i;	
		Kachel[i].SaveTemp := Kachel[i].SetTemp;	
	END_FOR
	
	isHeating := TRUE;
	alarmHistoryStyle := '[{"styleNbr":1,"alarmState":1,"logicalOperator":"and","severity":[{"useState":false,"value":0,"conditionType":">"},{"useState":false,"value":0,"conditionType":"<"}]}]';
	alarmListStyle := '[{"styleNbr":1,"alarmState":1,"logicalOperator":"and","severity":[{"useState":false,"value":0,"conditionType":">"},{"useState":false,"value":0,"conditionType":"<"}]}]';
END_PROGRAM