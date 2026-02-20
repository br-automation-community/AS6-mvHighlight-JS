
PROGRAM _CYCLIC
	(* Insert code here *)
	
	size := (amplitude-50.0 ) / 2.0;
	
	angleVer := startAngleVer;
	angleHor := startAngleHor;
	
	steps := 2.0*3.1415926535 / (NUMBER_OF_DOTS-1.0);
	
	FOR i := 0 TO NUMBER_OF_DOTS  BY 1 DO
		

		XCoords[i] := amplitude - (SIN(angleVer)*size + amplitude / 2.0);
		YCoords[i] := SIN(angleHor)*size + amplitude / 2.0;
		
		//angleVer := angleVer + verticalSpeed * 0.035;
		//angleHor := angleHor + horizontalSpeed * 0.035;
		
		angleVer := angleVer + verticalSpeed * steps;
		angleHor := angleHor + horizontalSpeed * steps;
		
	END_FOR;
	
	startAngleVer := startAngleVer + 0.03;
	
	
	
END_PROGRAM
