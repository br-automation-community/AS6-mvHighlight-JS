
PROGRAM _CYCLIC
		
	t := startAngleVer;
	
	radius := 0.0;
	
	FOR i := 0 TO NUMBER_OF_DOTS BY 1 DO
		

		XCoords[i] := radius * COS(t);
		YCoords[i] := radius * SIN(t);
		
		//angleVer := angleVer + verticalSpeed * 0.035;
		//angleHor := angleHor + horizontalSpeed * 0.035;
		
		t := t + (3.0 * 3.141592654 / 180.0) ;
		
		radius := radius + 1;
		
	END_FOR;
	
	startAngleVer := startAngleVer + 0.1;
	 
END_PROGRAM
