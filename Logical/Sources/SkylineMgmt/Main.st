PROGRAM _CYCLIC
	
	SkylineNotification := Module.Notification[SelectedModuleIndex];
	
	ModulName := Module.Name[SelectedModuleIndex];
	
	
	CASE Step OF
		WAIT:
			
			IF Cmd.Activate THEN
				Step := ACTIVATE;
				BlockDeactivate := FALSE;
				BlockFunctions := FALSE;
				State := 'Ready';

			ELSIF Cmd.Deactivate THEN
				Step := DEACTIVATE;
				BlockActivate := FALSE;
				BlockFunctions := FALSE;
				Active := FALSE;
				State := 'Off';
					
			ELSIF Cmd.ActivateOption THEN
				Step := ACTIVATE_OPTION;
				Cmd.ActivateOption := FALSE;
				
			ELSIF Cmd.DeactivateOption THEN
				Step := DEACTIVATE_OPTION;
				Cmd.DeactivateOption := FALSE;
			END_IF
			
			IF i > MAX_MODULES THEN
				i := 0;
			END_IF

		ACTIVATE:
		
			Active := TRUE;
			Deactive := FALSE;
			
			IF y <= ACTIVATION THEN
				
				y := y + 1;
				
				IF i <= MAX_MODULES AND y = ACTIVATION THEN
					
					//Check module state
					IF Module.AlarmFlag[i] OR Module.AcknowledgeFlag[i] = FALSE THEN
						MpSkylineSetModuleState(gSkyline, Module.Name[i], 'Error');
					ELSE
						
						MpSkylineSetModuleState(gSkyline, Module.Name[i], 'Ready');
					END_IF
				
					//Check notification
					IF Module.IngredientLevel[i] <= LEVEL_LIMIT THEN
						MpSkylineSetNotification(gSkyline, Module.Name[i], 'Information');
						Module.Notification[i] := 'Information: Module ok!'; 
					END_IF
					
					//Check alarm
					IF Module.AcknowledgeFlag[i] = FALSE THEN
						MpSkylineSetNotification(gSkyline, Module.Name[i], 'Alarm');
					END_IF

					i := i + 1;	
					y := 0;
					
				ELSIF i > MAX_MODULES THEN
					Step := WAIT;
					BlockDeactivate := TRUE;
					BlockFunctions := TRUE;	
					Cmd.Activate := FALSE;
					State := 'Activated';
				END_IF
			END_IF

		DEACTIVATE:
			
			IF y <= ACTIVATION THEN
				
				y := y + 1;
			
				IF i <= MAX_MODULES AND y = ACTIVATION THEN
					MpSkylineSetModuleState(gSkyline, Module.Name[i], 'Off');
					MpSkylineResetNotification(gSkyline, Module.Name[i], 'Alarm');
					MpSkylineResetNotification(gSkyline, Module.Name[i], 'Information');
					i := i + 1;
					y := 0;
					
				ELSIF i > MAX_MODULES THEN
					Step := WAIT;
					BlockActivate := TRUE;
					Cmd.Deactivate := FALSE;
					Deactive := TRUE;
				END_IF
			END_IF
		
		ACTIVATE_OPTION:
		
			Module.ShowOption := TRUE;
			
			FOR i := 0 TO MAX_OPTIONS DO
				
				IF Module.Option.Activate[i] = ON THEN
					MpSkylineSetOptionState(gSkyline, Module.Option.Modules[i], Module.Option.Name[i], Module.Option.StateON[i]);
				ELSE
					MpSkylineSetOptionState(gSkyline, Module.Option.Modules[i], Module.Option.Name[i], Module.Option.StateOFF[i]);
				END_IF

			END_FOR;
			
			Step := WAIT;
			i := 0;
		
		DEACTIVATE_OPTION:
			
			Module.ShowOption := FALSE;
			Step := WAIT;
		
	END_CASE
	
		
	IF State = 'Activated' THEN
	  
		IF MpAlarmXCheckReaction(gAlarmXCore, 'BoilerPermanentLoad') THEN
			MpSkylineSetModuleState(gSkyline, 'Boiler_Tank', 'Error');
			MpSkylineSetNotification(gSkyline, 'Boiler_Tank', 'Alarm');
			Module.Notification[1] := 'Alarm: Temperature not ok!';
			
		ELSE
			MpSkylineSetModuleState(gSkyline, 'Boiler_Tank', 'Ready');
			MpSkylineResetNotification(gSkyline, 'Boiler_Tank', 'Alarm');
			Module.Notification[1] := 'Information: Module ok!';
		END_IF;
		
		IF MpAlarmXCheckReaction(gAlarmXCore, 'ForwardHeating') THEN
			MpSkylineSetModuleState(gSkyline, 'Forward_Tank', 'Error');
			MpSkylineSetNotification(gSkyline, 'Forward_Tank', 'Alarm');
			Module.Notification[3] := 'Alarm: Temperature not ok!';
			
		ELSE
			MpSkylineSetModuleState(gSkyline, 'Forward_Tank', 'Ready');
			MpSkylineResetNotification(gSkyline, 'Forward_Tank', 'Alarm');
			Module.Notification[3] := 'Information: Module ok!';
		END_IF;
		
		IF MpAlarmXCheckReaction(gAlarmXCore, 'ReturnCooling') THEN
			MpSkylineSetModuleState(gSkyline, 'Return_Tank', 'Error');
			MpSkylineSetNotification(gSkyline, 'Return_Tank', 'Alarm');
			Module.Notification[5] := 'Alarm: Temperature not ok!';
			
		ELSE
			MpSkylineSetModuleState(gSkyline, 'Return_Tank', 'Ready');
			MpSkylineResetNotification(gSkyline, 'Return_Tank', 'Alarm');
			Module.Notification[5] := 'Information: Module ok!';
		END_IF;
		
		
		IF MpAlarmXCheckReaction(gAlarmXCore, 'BoilerHeating') THEN
			MpSkylineSetModuleState(gSkyline, 'Boiler_Tank2', 'Error');
			MpSkylineSetNotification(gSkyline, 'Boiler_Tank2', 'Alarm');
			Module.Notification[2] := 'Alarm: Temperature not ok!';
			
		ELSE
			MpSkylineSetModuleState(gSkyline, 'Boiler_Tank2', 'Ready');
			MpSkylineResetNotification(gSkyline, 'Boiler_Tank2', 'Alarm');
			Module.Notification[2] := 'Information: Module ok!';
		END_IF;
		
		
		IF MpAlarmXCheckReaction(gAlarmXCore, 'ForwardHeat') THEN
			MpSkylineSetModuleState(gSkyline, 'Forward_Tank2', 'Error');
			MpSkylineSetNotification(gSkyline, 'Forward_Tank2', 'Alarm');
			Module.Notification[4] := 'Alarm: Temperature not ok!';
			
		ELSE
			MpSkylineSetModuleState(gSkyline, 'Forward_Tank2', 'Ready');
			MpSkylineResetNotification(gSkyline, 'Forward_Tank2', 'Alarm');
			Module.Notification[4] := 'Information: Module ok!';
		END_IF;
		
		
		IF MpAlarmXCheckReaction(gAlarmXCore, 'ReturnCool') THEN
			MpSkylineSetModuleState(gSkyline, 'Return_Tank2', 'Error');
			MpSkylineSetNotification(gSkyline, 'Return_Tank2', 'Alarm');
			Module.Notification[6] := 'Alarm: Temperature not ok!';
			
		ELSE
			MpSkylineSetModuleState(gSkyline, 'Return_Tank2', 'Ready');
			MpSkylineResetNotification(gSkyline, 'Return_Tank2', 'Alarm');
			Module.Notification[6] := 'Information: Module ok!';
		END_IF;
		
	END_IF;	
	
		

END_PROGRAM

