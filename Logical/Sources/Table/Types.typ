
TYPE
	TableStruct : 	STRUCT 
		TimeStamp : ARRAY[0..19]OF DATE_AND_TIME := [DT#2023-01-01-10:00:00,DT#2023-01-01-11:00:00,9(DT#2023-01-01-00:00:00),9(DT#1970-01-01-00:00:00)];
		Message : ARRAY[0..19]OF WSTRING[256] := ["Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea tak","Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.",18("")];
		State : ARRAY[0..19]OF USINT := [0,3(1),16(0)];
		Value : ARRAY[0..19]OF REAL := [1.1,200.4,400.2,100.0,3(10),4(0.0),9(0.0)];
	END_STRUCT;
END_TYPE
