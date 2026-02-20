
PROGRAM _INIT

	MpReportCore_0.Enable := TRUE;
	MpReportCore_0.MpLink := ADR(gReport);
	MpReportCore_0.DeviceName := ADR('USER');
	MpReportCore_0.FileName := ADR('{&id}_%Y_%m_%d_%H_%M_%S');
	MpReportCore_0.ReportID := ADR('AlarmHistoryReport');
	MpReportCore_0.Language := ADR(ReportLanguage);
	MpReportCore_0();
	
	
	MpFileManagerUI_0.Enable := TRUE;
	MpFileManagerUI_0.MpLink := ADR(gFileManagerUI);
	MpFileManagerUI_0.UIConnect := ADR(FileUIConnect);
	FileUIConnect.File.Filter := '*.pdf';
	
	MpFileManagerUI_0();
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	
	IF MpReportCore_0.Generate AND MpReportCore_0.CommandDone THEN
	  
		FileUIConnect.File.Refresh := TRUE;
		MpReportCore_0.Generate := FALSE;
		
	END_IF;
	
	
	FOR i := 0 TO 49 DO							
		// Save Filenames to a seperate array for display in Table
		DisplayFileName[i] := FileUIConnect.File.List.Items[i].Name;
		IF DisplayFileNameIndex = i THEN		
			// if selected set a index for display selected file in table
			FileUIConnect.File.List.Items[i].IsSelected := TRUE;	
		END_IF
	END_FOR

	SelectedFile := CONCAT(STR_FILE_DEVICE, FileUIConnect.File.List.Items[DisplayFileNameIndex].Name);		

	
	MpReportCore_0();
	MpFileManagerUI_0();
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

