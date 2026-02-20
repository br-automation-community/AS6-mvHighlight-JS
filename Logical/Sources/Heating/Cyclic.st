
PROGRAM _CYCLIC
	(* Insert code here *)

	counter:=counter+1;
	
	FOR i:= 0 TO 9 DO
		IF Kachel[i].CurrentTemp < Kachel[i].SetTemp THEN
			Kachel[i].CurrentTemp := Kachel[i].CurrentTemp + 0.1;
		ELSIF Kachel[i].CurrentTemp > Kachel[i].SetTemp THEN
			Kachel[i].CurrentTemp := Kachel[i].CurrentTemp - 0.1;
		END_IF
		
	END_FOR;
	
	
	
	
	IF  EDGENEG(isHeating) THEN
		FOR j:= 0 TO 9 DO
			Kachel[j].SaveTemp  := Kachel[j].SetTemp;
			Kachel[j].SetTemp := 20;
		END_FOR	
	END_IF
	IF EDGEPOS(isHeating) THEN
		FOR k:= 0 TO 9 DO
			Kachel[k].SetTemp := Kachel[k].SaveTemp;
		END_FOR
	END_IF
	
	
//	FOR i:= 0 TO 9 DO
//		MTBasicsPT1_0[i].Enable := 1;
//		MTBasicsPT1_0[i].Gain := 1;
//		MTBasicsPT1_0[i].TimeConstant := 1;
//		MTBasicsPT1_0[i].In := INT_TO_REAL(Kachel[i].SetTemp);
//			
//		MTBasicsPT1_0[i]();
//	
//		Kachel[i].CurrentTemp := REAL_TO_INT(MTBasicsPT1_0{i].Out);
//	END_FOR
	

END_PROGRAM
