' *************************************
'    KISS Game Rules
'
Const KissRulesV=1.04
' *************************************
' 20161030 - Super targets,bumpers
' 20161031 - save demon lock state between players
' 20161113 - strengthen demon kicker and enable ball save during multiball
' 20161119 - ball audio on right ramp

Dim cRGB,xx
cRGB=1 ' Starting Colour

Sub InitMode(tr)
  debug.print "InitMode " & tr
  for each xx in ShotsColl
    xx.state=LightStateOff
  Next
  i35.state=LightStateOff ' KISS Targets
  i36.state=LightStateOff
  i37.state=LightStateOff
  i38.state=LightStateOff
  ModeInProgress=True
  Select Case tr
    case 1: ' two shots  lo-58, sc-68
      SetLightColor i58, RGBColors(cRGB), 2
      SetLightColor i68, RGBColors(cRGB), 2
    case 2: ' lo, sc
      SetLightColor i58, RGBColors(cRGB), 2
      SetLightColor i68, RGBColors(cRGB), 2
    case 3: ' ro
      SetLightColor i98, RGBColors(cRGB), 2
    case 4: ' kiss targets
      debug.print "KISS Targets Flash here..."
      SetLightColor i35, "white", 2
      SetLightColor i36, "white", 2
      SetLightColor i37, "white", 2
      SetLightColor i38, "white", 2
    case 5: ' sc, mr
      for each xx in ShotsColl
        SetLightColor xx, RGBColors(cRGB), 2
      Next
    case 6: ' lo, ro
      SetLightColor i58, RGBColors(cRGB), 2
      SetLightColor i98, RGBColors(cRGB), 2
    case 7: ' mid ramp
      SetLightColor i73, RGBColors(cRGB), 2
    case 8: ' mid ramp
      SetLightColor i73, RGBColors(cRGB), 2
    End Select
   cRGB=cRGB+1
   if cRGB>5 then cRGB=1
End Sub

'   ******************************************************
'   Rollover Switches

Sub sw1_hit  ' Leftmost Inlane
  DOF 133, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  If i7.state <> LightStateOff then 'Light Bumper Shot
    SetLightColor i7, "white", 0
   ' light one of the "Light bumper" lights   i101,102,103,104, pf 17,18,19,20
   ' if any pf & upper lights are off then choose it
    if i17.state=LightStateOff or i18.state=lightstateoff or i19.state=lightstateoff or i20.state=lightstateoff then
      if i17.state=lightstateoff and i101.state=lightstateoff then
           SetLightColor i101, "white", 1
      else
        if i18.state=lightstateoff and i102.state=lightstateoff then
             SetLightColor i102, "white", 1
        else
          if i19.state=lightstateoff and i103.state=lightstateoff then
                SetLightColor i103, "white", 1
          else
            if i20.state=lightstateoff and i104.state=lightstateoff then
                SetLightColor i104, "white", 1
            end if
          end if
        end if
      end if
    else ' all of the lights were already done atleast once
      if i17.state=LightStateBlinking or i18.state=lightstateBlinking or i19.state=lightstateBlinking or i20.state=lightstateBlinking then
        if i17.state=lightstateBlinking and i101.state=lightstateoff then
                SetLightColor i101, "white", 1
        else
          if i18.state=lightstateBlinking and i102.state=lightstateoff then
                SetLightColor i102, "white", 1
          else
            if i19.state=lightstateBlinking and i103.state=lightstateoff then
                SetLightColor i103, "white", 1
            else
              if i20.state=lightstateBlinking and i104.state=lightstateoff then
                SetLightColor i104, "white", 1
              end if
            end if
          end if
        end if
      else ' already got all the pf lights so lets just build them up for increased bumper points and light colours
        if i101.state=lightstateoff and bumpercolor(4) < 4 then   ' probably should light them based on bumper colours!!
                SetLightColor i101, "white", 1
        else
          if i102.state=lightstateoff and bumpercolor(3) < 4  then
              SetLightColor i102, "white", 1
          else
            if i103.state=lightstateoff and bumpercolor(1) < 4 then
                SetLightColor i103, "white", 1
            else
              if i104.state=lightstateoff and bumpercolor(2) < 4 then
                SetLightColor i104, "white", 1
              end if
            end if
          end if
        end if
      end if
    end if
  End if
  AddScore(5000)
End Sub

Sub sw2_hit ' Right Inlane Kiss Combo
  DOF 134, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub

  If i33.state=LightStateOff then
    KissCombo.Interval=10000
    KissCombo.enabled=True
    SetLightColor i33, "white", 2
    if i9.state = LightStateOff or i10.state = LightStateOff or i11.state = LightStateOff or i12.state = LightStateOff then
      DisplayI(5)
    else  ' you hit all the targets so now its a hurry up bonus
      SetLightColor i115, "white", 2
      DMDTextI "KISS COMBO","HURRY UP!", bgi                          ' right Lane
      KISSBonus=1000000
      KISSHurryUp.Interval=400
      KISSHurryUp.Enabled=True
    End if
  End if
  AddScore(5000)
End Sub

Sub sw3_hit
  DOF 132, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  if LightRockAgain.state=LightStateOff then ' Save BallHit 
    if i6.state <> LightStateOff then
      if not DemonMBMode then
        DisplayI(13)
        PlaySound "audio113"
        Debug.print "Exit via Front Row"
'      FrontRowSave=True ' Next Drain is just a drain .. 
        bBallSaverActive=True
'      BallReleaseTimer.enabled=TRUE
      End IF
    end if
  end if
  AddScore(5000)
End Sub

Sub sw4_hit
  DOF 135, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  AddScore(5000)
End Sub

Sub sw14_hit   ' left orbit
  DOF 130, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  If BallLooping.enabled=False then ' Ignore Initial ball plunge
    BallLooping.enabled=True ' Ignore next switch if looping around 
    if KISSHurryUp.enabled=True Then ' Score KISSHurryUp
      KISSHurryUp.Enabled=False
      AddScore(KISSBONUS) ' HurryUp Bonus Award
      KissCombo.enabled=False
      debug.print "kiss Hurry Up"
      DMDFlush()
      DMDTextI ">KISS Hurry Up!<", KISSBONUS, bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i33.state=LightStateOff
    else
      DMDGif "scene51.gif","YOU ROCK!","",slen(51)
    end if
    AddScore(10000)
    if NOT i58.state=LightStateOff then
      processLO()
    else
      LastShot(CurPlayer)=-1
    end if
    if NOT i62.state=LightStateOff then ' Collect Instrument Drums
      DMDGif "scene58.gif","","",slen(58)
      i62.state=LightStateOff  
      SetLightColor i24, "white", 1  ' pf instrument light 
      i97.state=LightStateBlinking  ' Light Instrument Light
      instruments(CurPlayer)=instruments(CurPlayer)+1
      CheckInstruments()
    end if
    if i7.state=LightStateOff then ' Light Bumper Shot
      SetLightColor i7, "white", 1
    end if
  end if
End Sub

Sub sw24_hit
  debug.print "sw24_hit()"
  DOF 131, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  if BallLooping.enabled=False then ' Ignore if this is the initial ball plunge
    BallLooping.enabled=True ' Ignore next switch if looping around 
    AddScore(10000)
    if NOT i98.state=LightStateOff then
      processRO()
    else
      LastShot(CurPlayer)=-1
    end if

    if i101.state=LightStateOn then  ' for catman bumper4 
      i101.state=LightStateOff
      if i17.state=LightStateOff then
          SetLightColor i17, "white", 2
    else
      if i17.state=LightStateBlinking then
            SetLightColor i17, "white", 1
      end if
    end if

    ' add one to the bumper light!

    if BumperColor(4)=0 then  ' None
       flasher4.visible=True
       flasher4.color=RGB(255, 255, 255) ' white
       SetLightColor B4L, "white", 1
    else
      if BumperColor(4)=1 Then
         debug.print "green"
         flasher4.color=RGB(0, 255, 0) ' green
         SetLightColor B4L, "green", 1
      else
         if BumperColor(4)=2 then
           flasher4.color=RGB(0, 0, 128) ' blue
           SetLightColor B4L, "blue", 1
           debug.print "purple"
         else
           if BumperColor(4)=3 then
             flasher4.color=RGB(255,0,0) ' red
             SetLightColor B4L, "red", 1
             debug.print "red"
           end if
         end if
      end if
    End If

    BumperColor(4)=BumperColor(4)+1
  end if

  if i102.state=LightStateOn then  ' for Spaceman  bumper3 
    i102.state=LightStateOff
    if i18.state=LightStateOff then
          SetLightColor i18, "white", 2
    else
      if i18.state=LightStateBlinking then
            SetLightColor i18, "white", 1
      end if
    end if

    ' add one to the bumper light!

    if BumperColor(3)=0 then  ' None
       flasher3.visible=True
       flasher3.color=RGB(255, 255, 255) ' white
       SetLightColor B3L, "white", 1
    else
      if BumperColor(3)=1 Then
         debug.print "green"
         flasher3.color=RGB(0, 255, 0) ' green
         SetLightColor B3L, "green", 1
      else
         if BumperColor(3)=2 then
           flasher3.color=RGB(0, 0, 128) ' blue
           SetLightColor B3L, "blue", 1
           debug.print "purple"
         else
           if BumperColor(3)=3 then
             flasher3.color=RGB(255,0,0) ' red
             SetLightColor B3L, "red", 1
             debug.print "red"
           end if
         end if
      end if
    End If

    BumperColor(3)=BumperColor(3)+1
  end if

  if i103.state=LightStateOn then   ' for Starchild   bumper1 
    i103.state=LightStateOff
    if i19.state=LightStateOff then
          SetLightColor i19, "white", 2
    else
      if i19.state=LightStateBlinking then
            SetLightColor i19, "white", 1
      end if
    end if

    ' add one to the bumper light!

    if BumperColor(1)=0 then  ' None
       flasher1.visible=True
       flasher1.color=RGB(255, 255, 255) ' white
       SetLightColor B1L, "white", 1
    else
      if BumperColor(1)=1 Then
         debug.print "green"
         flasher1.color=RGB(0, 255, 0) ' green
         SetLightColor B1L, "green", 1
      else
         if BumperColor(1)=2 then
           flasher1.color=RGB(0, 0, 128) ' blue
           SetLightColor B1L, "blue", 1
           debug.print "purple"
         else
           if BumperColor(1)=3 then
             flasher1.color=RGB(255,0,0) ' red
             SetLightColor B1L, "red", 1
             debug.print "red"
           end if
         end if
      end if
    End If

    BumperColor(1)=BumperColor(1)+1
  end if
'
   if i104.state=LightStateOn then    ' for demon   bumper2 
    i104.state=LightStateOff
    if i20.state=LightStateOff then
          SetLightColor i20, "white", 2
    else
      if i20.state=LightStateBlinking then
            SetLightColor i20, "white", 1
      end if
    end if

    ' add one to the bumper light!

    if BumperColor(2)=0 then  ' None
       flasher2.visible=True
       flasher2.color=RGB(255, 255, 255) ' white
       SetLightColor B2L, "white", 1
    else
      if BumperColor(2)=1 Then
         debug.print "green"
         flasher2.color=RGB(0, 255, 0) ' green
         SetLightColor B2L, "green", 1
      else
         if BumperColor(2)=2 then
           flasher2.color=RGB(0, 0, 128) ' blue
           SetLightColor B2L, "blue", 1
           debug.print "purple"
         else
           if BumperColor(2)=3 then
             flasher2.color=RGB(255,0,0) ' red
             SetLightColor B2L, "red", 1
             debug.print "red"
           end if
         end if
      end if
    End If

    BumperColor(2)=BumperColor(2)+1
  end if
   CheckBumpers()
 end if
End Sub

Sub BallLooping_Timer()
  BallLooping.enabled=False
End Sub

' ***********************
' STAR Targets
' ***********************
Sub sw25_hit  ' S-tar
  PlaySound SoundFXDOF("audio22",117,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If

  i64.state=LightStateOn   ' S
  CheckInstrument1()
  CheckLoveGun()
End Sub

Sub sw26_hit  ' s-T-tar
  PlaySound SoundFXDOF("audio22",117,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End If
  Else
    AddScore(5000)
  End If

  I65.state=LightStateOn   ' S
  CheckInstrument1()
  CheckLoveGun()
End Sub
Sub sw27_hit  ' st-A-r
  PlaySound SoundFXDOF("audio22",117,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If

  I66.state=LightStateOn   ' S
  CheckInstrument1()
  CheckLoveGun()
End Sub
Sub sw28_hit  ' sta-R
  PlaySound SoundFXDOF("audio22",117,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If

  I67.state=LightStateOn   ' S
  CheckInstrument1()
  CheckLoveGun()
End Sub

'***************
' Ramp Switches
'***************

Sub sw56_Hit() ' Right Ramp1  RightRampDone
  PlaySound "fx_metalrolling", 0, 1, pan(ActiveBall)
  DOF 131, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  PlaySound "audio167",0,0.2

  if NOT i118.state=LightStateOff then ' Super Ramps
      debug.print "Ramp Cnt is " & RampCnt(CurPlayer)
      RampCnt(CurPlayer)=RampCnt(CurPlayer)+1
      if lastShot(CurrentPlayer)=3 then ' if prior shot was mid ramp
        AddScore(150000)
      else
        AddScore(75000)
      End if
      if RampCnt(CurPlayer) > 9 Then  
        i118.state=LightStateOff
        DisplayI(27) ' Completed

        SpinCnt(CurPlayer) = 0
      else
        DisplayI(31)
      end if
  else
      AddScore(10000)
  end if

  if NOT i92.state=LightStateOff then
    processRR()
  else
    LastShot(CurPlayer)=-1
  end if

  if i97.state=LightStateBlinking then ' Light Instrument
    debug.print "Light an instrument"
    i97.state=LightStateOff
    if NOT i21.state=LightStateOn then
      SetLightColor i72, "white", 2   ' Light  star child
      DisplayI(14)
    else
      if NOT i22.state=LightStateOn then
        SetLightColor i78, "white", 2   ' Light center Ramp
        DisplayI(14)
      else
        if NOT i23.state=LightStateOn then
          SetLightColor i91, "white", 2   ' Light  Demon 
          DisplayI(3)
        else
          if NOT i24.state=LightStateOn then
            SetLightColor i62, "white", 2   ' Light 
            DisplayI(4)
          end if
        end if
      end if
    end if
  end if
  if i7.state=LightStateOff then ' Light Bumper Shot
    SetLightColor i7, "white", 2   ' Light Bumper
  end if
  RandomScene()
End sub

Sub sw64_Hit  ' Center Ramp
  debug.print "sw64_hit"
  PlaySound "fx_metalrolling", 0, 1, pan(ActiveBall)
  If Tilted Then Exit Sub
  PlaySound "audio166",0,0.2

  if NOT i118.state=LightStateOff then ' Super Ramps
      debug.print "Ramp Cnt is " & RampCnt(CurPlayer)
      RampCnt(CurPlayer)=RampCnt(CurPlayer)+1
      if lastShot(CurrentPlayer)=5 then  ' If prior shot was RR
        AddScore(150000)
      else
        AddScore(75000)
      End if
      if RampCnt(CurPlayer) > 9 Then  
        i118.state=LightStateOff
        DisplayI(27) ' Completed
        SpinCnt(CurPlayer) = 0
      else
        DisplayI(31) ' SuperRamps
      end if
  else
      AddScore(10000)
  end if

  if NOT i73.state=LightStateOff then
    debug.print "process MR()"
    processMR()
  else
    LastShot(CurPlayer)=-1
  end if

  if ArmyHurryUp.enabled then ' ArmyHurryUp 
    AddScore(ArmyBonus)
    DMDFlush()
    DMDTextPause ">Army Hurry Up!<", ArmyBonus, 500
    i77.state=LightStateOff
    ArmyHurryUp.enabled=False
  end if

  if NOT i78.state=LightStateOff then ' Collect Instrument Aces Guitar
    DMDGif "scene53.gif","","",slen(53) 
    i78.state=LightStateOff
    i22.state=LightStateOn        ' pf instrument light 
    i97.state=LightStateBlinking  ' Light Instrument Light
    instruments(CurPlayer)=instruments(CurPlayer)+1
    CheckInstruments()
  end if	
  if i7.state=LightStateOff then ' Light Bumper Shot
    SetLightColor i7,"white",2
  end if      
  RandomScene()
End sub

'   *********************************
'   Demon Lock Targets
Sub sw44_Hit
  PlaySound SoundFXDOF("audio22",128,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  if I82.state=LightStateBlinking then
    if Not i95.state=LightStateOff then
      targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
      if targetCnt(CurPlayer)=100 then
        DisplayI(30)
        AddScore(40000)
        i95.state=LightStateOff
      else
        if TargetCnt(CurPlayer) < 100 then
            AddScore(40000)
            if rnd*10 > 4 then 
              UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
            Else  
              DisplayI(34)
            end if
        Else  
            AddScore(5000)
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
        End If
      End if
    Else
      AddScore(5000)
    End If
    SetLightColor i82, "green", 1
    CheckLock
  else
    AddScore(100)
  end if
End Sub

Sub sw45_Hit
  PlaySound SoundFXDOF("audio22",128,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  if I84.state=LightStateBlinking then
    if Not i95.state=LightStateOff then
      targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
      if targetCnt(CurPlayer)=100 then
        DisplayI(30)
        AddScore(40000)
        i95.state=LightStateOff
      else
        if TargetCnt(CurPlayer) < 100 then
            AddScore(40000)
            if rnd*10 > 4 then 
              UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
            Else  
              DisplayI(34)
            end if
        Else  
            AddScore(5000)
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
        End If
      End if
    Else
      AddScore(5000)
    End If
    SetLightColor i84, "green", 1
    CheckLock
  else
    AddScore(100)
  end if
End Sub

Sub CheckLock()
    If bLockEnabled Then Exit Sub
    If i82.State + i84.State = 2 Then
        bLockEnabled = True
        SetLightColor i90, "green", 2 
    End If
End Sub

' ***********************************
Sub sw46_hit ' Rightmost Left Inlane Army Combo
  DOF 133, DOFPulse
  PlaySound "fx_sensor", 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  ArmyCombo.Interval=10000
  ArmyCombo.enabled=True
  SetLightColor i8, "white", 2

  if i13.state=LightStateOff or i14.state=LightStateOff or i15.state=LightStateOff or i16.state=LightStateOff then
    AddScore(5000) ' just a normal combo shot lit
    DisplayI(11)
  else
    DMDTextI "ARMY", "HURRYUP!", bgi
    SetLightColor i77, "white", 2 ' Kiss Army Lights 
        ' start hurry Update  
     ArmyBonus=900000
     ArmyHurryUp.Interval=400
     ArmyHurryUp.Enabled=True
  end if
End Sub

Sub ArmyCombo_Timer()
  i8.state=LightStateOff
  ArmyCombo.enabled=False
End Sub

Sub KissCombo_Timer()
  i33.state=LightStateOff
  KissCombo.enabled=False
End Sub

'  *******************************************************
'     Right StandUp Targets
Sub sw58_hit
  PlaySound SoundFXDOF("audio134",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  FlashForMs SmallFlasher2, 1000, 50, 0
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  SetLightColor i106, "white", 1
  SetLightColor i13, "yellow", 2
' Check for a Combo bonus
  if NOT i8.state = lightStateOff then ' check if this is a hurryup or just a combo 
    if i13.state=LightStateOff or i14.state=LightStateOff or i15.state=LightStateOff or i16.state=LightStateOff then
      ArmyCombo.enabled=False
      debug.print "army combo"
      DMDTextI "ARMY COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i8.state=LightStateOff
      AddScore(100000)
    End If
  end if
  CheckBackStage()
End Sub

Sub sw59_hit
  PlaySound SoundFXDOF("audio134",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  FlashForMs SmallFlasher2, 1000, 50, 0
  SetLightColor i107, "white", 1
  SetLightColor i14, "yellow", 2
' Check for a Combo bonus
  if NOT i8.state = lightStateOff then ' check if this is a hurryup or just a combo 
    if i13.state=LightStateOff or i14.state=LightStateOff or i15.state=LightStateOff or i16.state=LightStateOff then
      ArmyCombo.enabled=False
      debug.print "army combo"
      DMDTextI "ARMY COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i8.state=LightStateOff
      AddScore(100000)
    End If
  end if
  CheckBackStage()
End Sub

Sub sw60_hit
  PlaySound SoundFXDOF("audio134",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  FlashForMs SmallFlasher2, 1000, 50, 0
  SetLightColor i108, "white", 1
  SetLightColor i15, "yellow", 2
' Check for a Combo bonus
  if NOT i8.state = lightStateOff then ' check if this is a hurryup or just a combo 
    if i13.state=LightStateOff or i14.state=LightStateOff or i15.state=LightStateOff or i16.state=LightStateOff then
      ArmyCombo.enabled=False
      debug.print "army combo"
      DMDTextPause "ARMY COMBO", ArmyBonus,500
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i8.state=LightStateOff
      AddScore(100000)
    End If
  end if
  CheckBackStage()
End Sub

Sub sw61_hit
  PlaySound SoundFXDOF("audio134",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  FlashForMs SmallFlasher2, 1000, 50, 0
  SetLightColor i109, "white", 1
  SetLightColor i16, "yellow", 2
' Check for a Combo bonus
  if NOT i8.state = lightStateOff then ' check if this is a hurryup or just a combo 
    if i13.state=LightStateOff or i14.state=LightStateOff or i15.state=LightStateOff or i16.state=LightStateOff then
      ArmyCombo.enabled=False
      debug.print "army combo"
      DMDTextI "ARMY COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i8.state=LightStateOff
      AddScore(100000)
    End If
  End if
  CheckBackStage()
End Sub

'  *******************************************************
'     Left Drop Targets

Sub sw38_hit
  PlaySound SoundFXDOF("audio22",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
End Sub

Sub sw38_Dropped
  debug.print "Target Dropped"
  if Tilted Then Exit Sub
  if NOT i33.state=LightStateOff then
    if i9.state = LightStateOff or i10.state = LightStateOff or i11.state = LightStateOff or i12.state = LightStateOff then
      AddScore(100000)  ' Combo but No HurryUp
      KissCombo.enabled=False
      debug.print "kiss combo"
      DMDTextI "KISS COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i33.state=LightStateOff
    end if 
  end if

  if i35.state=LightStateBlinking then 'Hotter Than Hell Mode
    ProcessTarget()
  end if

  SetLightColor i35, "white", 1
  SetLightColor i9, "white", 1
  if B2SOn=True then
    Controller.B2SSetData 1, 1
  end if
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  If sw38.IsDropped=1 and sw39.IsDropped=1 and sw40.IsDropped=1 and sw41.IsDropped=1 then 
    debug.print "All targets dropped"
    KissTargetStack=KissTargetStack+1
    FrontRowStack=FrontRowStack+1
    ResetTargets()
  End if
  CheckBackStage():CheckFrontRow()
End Sub

Sub sw39_hit
  PlaySound SoundFXDOF("audio22",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
End Sub

Sub sw39_Dropped
  debug.print "Target Dropped"
  if Tilted Then Exit Sub
  if NOT i33.state=LightStateOff then
    if i9.state = LightStateOff or i10.state = LightStateOff or i11.state = LightStateOff or i12.state = LightStateOff then
      AddScore(100000)  ' Combo but No HurryUp
      KissCombo.enabled=False
      debug.print "kiss combo"
      DMDTextI "KISS COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i33.state=LightStateOff
    end if 
  end if

  if i36.state=LightStateBlinking then 'Hotter Than Hell Mode
    ProcessTarget()
  end if

  SetLightColor i36, "white", 1
  SetLightColor i10, "white", 1
  if B2SOn=True then
    Controller.B2SSetData 2, 1
  end if
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  If sw38.IsDropped=1 and sw39.IsDropped=1 and sw40.IsDropped=1 and sw41.IsDropped=1 then 
    debug.print "All targets dropped"
    KissTargetStack=KissTargetStack+1
    FrontRowStack=FrontRowStack+1
    ResetTargets()
  End if
  CheckBackStage():CheckFrontRow()
End Sub

Sub sw40_hit
  PlaySound SoundFXDOF("audio22",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
End Sub

Sub sw40_Dropped
  debug.print "Target Dropped"
  if Tilted Then Exit Sub
  if NOT i33.state=LightStateOff then
    if i9.state = LightStateOff or i10.state = LightStateOff or i11.state = LightStateOff or i12.state = LightStateOff then
      AddScore(100000)  ' Combo but No HurryUp
      KissCombo.enabled=False
      debug.print "kiss combo"
      DMDTextI "KISS COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i33.state=LightStateOff
    end if 
  end if

  if i37.state=LightStateBlinking then 'Hotter Than Hell Mode
    ProcessTarget()
  end if

  SetLightColor i37, "white", 1
  SetLightColor i11, "white", 1
  if B2SOn=True then
    Controller.B2SSetData 3, 1
  end if
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  If sw38.IsDropped=1 and sw39.IsDropped=1 and sw40.IsDropped=1 and sw41.IsDropped=1 then 
    debug.print "All targets dropped"
    KissTargetStack=KissTargetStack+1
    FrontRowStack=FrontRowStack+1
    ResetTargets()
  End if
  CheckBackStage():CheckFrontRow()
End Sub

Sub sw41_hit
  PlaySound SoundFXDOF("audio22",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
End Sub

Sub sw41_Dropped
  debug.print "Target Dropped"
  if Tilted Then Exit Sub
  if NOT i33.state=LightStateOff then
    if i9.state = LightStateOff or i10.state = LightStateOff or i11.state = LightStateOff or i12.state = LightStateOff then
      AddScore(100000)  ' Combo but No HurryUp
      KissCombo.enabled=False
      debug.print "kiss combo"
      DMDTextI "KISS COMBO", "100000", bgi
      ComboCnt(CurPlayer)=ComboCnt(CurPlayer)+1
      i33.state=LightStateOff
    end if 
  end if

  if i38.state=LightStateBlinking then 'Hotter Than Hell Mode
    ProcessTarget()
  end if

  SetLightColor i38, "white", 1
  SetLightColor i12, "white", 1
  if B2SOn=True then
    Controller.B2SSetData 4, 1
  end if
  if Not i95.state=LightStateOff then
    targetCnt(CurPlayer)=targetCnt(CurPlayer)+1
    if targetCnt(CurPlayer)=100 then
      DisplayI(30)
      AddScore(40000)
      i95.state=LightStateOff
    else
      if TargetCnt(CurPlayer) < 100 then
          AddScore(40000)
          if rnd*10 > 4 then 
            UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("40k",INT(RND*8)+3," "), 15, 14, 100, 14
          Else  
            DisplayI(34)
          end if
      Else  
          AddScore(5000)
          UltraDMD.DisplayScene00 "scene19.gif", LPad("",INT(RND*3)," "), 10, Lpad("5k",INT(RND*8)+3," "), 15, 14, 100, 14
      End If
    End if
  Else
    AddScore(5000)
  End If
  If sw38.IsDropped=1 and sw39.IsDropped=1 and sw40.IsDropped=1 and sw41.IsDropped=1 then 
    debug.print "All targets dropped"
    KissTargetStack=KissTargetStack+1
    FrontRowStack=FrontRowStack+1
    ResetTargets()
  End if
  CheckBackStage():CheckFrontRow()
End Sub


' *********************************************************************
'                        General Routines
' *********************************************************************

Sub CheckBackStage
   debug.print "CheckBackStage"
   if I106.state=LightStateOn and I107.state=LightStateOn and I108.state=LightStateOn and I109.state=LightStateOn then
     ArmyTargetStack=ArmyTargetStack+1
     I106.state=LightStateOff:I107.state=LightStateOff:I108.state=LightStateOff:I109.state=LightStateOff
   end if

   if i41.state=LightStateOff then ' Not already lit
     if KissTargetStack > 0 then
       debug.print "Kiss Targets Complete"
       KissTargetStack=KissTargetStack-1
       DMDGif "scene37.gif"," ","LIT",slen(37)
       i41.state=LightStateBlinking:i42.state=LightStateBlinking
       SetLightColor i41, "white", 2
       SetLightColor i42, "white", 2
     else
       if ArmyTargetStack > 0 then 
         debug.print "Army targets complete"
         ArmyTargetStack=ArmyTargetStack-1
         DMDGif "scene37.gif"," ","LIT",slen(37)
         SetLightColor i41, "white", 2
         SetLightColor i42, "white", 2
       '  textline1.text="backstage pass"
       end if
     end if
   end if
End Sub

Sub CheckFrontRow
   if i6.state=LightStateOff and FrontRowStack > 0 and Not LoveGunMode and Not DemonMBMode then
     FrontRowStack=FrontRowStack-1
     SetLightColor i6, "orange", 2
     DMDTextI "FRONT ROW", "", bgi
   end if
End Sub

Sub ArmyHurryUp_timer
  ArmyBonus=ArmyBonus-15000
  DMDTextPause "ARMY Hurry Up!", ArmyBonus, 0
  if ArmyBonus <=0 then
    ArmyHurryUp.Enabled=False
    i77.state=LightStateOff
  end if
End Sub


Sub KISSHurryUp_timer
  KISSBonus=KISSBonus- 25000
  DMDTextPause "KISS Hurry Up!", KISSBonus,0
  if KISSBonus <=0 then
    KISSHurryUp.Enabled=False
    i115.state=LightStateOff  ' Doublecheck that light
  end if
End Sub

Sub sctarget_hit
  PlaySound SoundFXDOF("audio22",116,DOFPulse,DOFTargets), 0, 1, pan(ActiveBall)
  if Tilted Then Exit Sub
  AddScore(15000)
End Sub

Sub ResetTargets()
  debug.print "ResetTargets()"
  sw38.isDropped = False ' KISS Drop Targets
  sw39.isDropped = False
  sw40.isDropped = False
  sw41.isDropped = False
  if cursong(CurPlayer)=4 then ' Hotter Than Hell means they need to flash on Reset 
    debug.print "Target lights blink for Hotter Than Hell"
    I35.state=LightStateBlinking:I36.state=LightStateBlinking:I37.state=LightStateBlinking:I38.state=LightStateBlinking
  else
    I35.state=LightStateOff:I36.state=LightStateOff:I37.state=LightStateOff:I38.state=LightStateOff
  end if
  if B2SOn=True then
    Controller.B2SSetData 1, 0
    Controller.B2SSetData 2, 0
    Controller.B2SSetData 3, 0
    Controller.B2SSetData 4, 0
  end if
End Sub

'***********************************
'Demon Lock
'***********************************

Dim bLockEnabled

Sub sw42_Hit()
    PlaySound "fx_kicker_enter", 0, 1, 0.1
    If Tilted Then Exit Sub
    if NOT i79.state=LightStateOff then
      processD()
    else
      LastShot(CurPlayer)=-1
    end if
    Addscore 10000
    if NOT i91.state=LightStateOff then ' Collect Instrument Genes Bass
           DMDGif "scene56.gif","","",slen(56) 
           i91.state=LightStateOff
           SetLightColor i23, "white", 1  ' pf instrument light 
           SetLightColor i97, "white", 2  ' Light Instrument Light
           instruments(CurPlayer)=instruments(CurPlayer)+1
           CheckInstruments()
    end if
    if i85.state=lightstateoff then  'D-E-M-O-N lights
          SetLightColor i85, "orange", 1:DisplayI(6)
    else
      if i86.state=lightstateoff then
            SetLightColor i86, "orange", 1:DisplayI(6)
      else
            if i87.state=lightstateoff then
              SetLightColor i87, "orange", 1:DisplayI(6)
            else
              if i88.state=lightstateoff then
                SetLightColor i88, "orange", 1:DisplayI(6)
              else
                if i89.state=lightstateoff then
                  SetLightColor i89, "orange", 1:DisplayI(6)
                  PlaySound "audio429"
                end if
              end if
            end if
      end if
    end if
    If bLockEnabled and NOT demonMBMode and NOT LoveGunMode Then
            LockedBalls(CurPlayer) = LockedBalls(CurPlayer) + 1
            bLockEnabled=False
            Playsound "audio" & 657 + LockedBalls(CurPlayer)
            SetLightColor i82, "orange", 2
            SetLightColor i84, "orange", 2
            i90.State = 0
            DMDTextI "BALL " & LockedBalls(CurPlayer), "IS LOCKED", bgi
            If LockedBalls(CurPlayer) = 3 Then
                MBPauseTimer.interval=2000:MBPauseTimer.enabled=True
                vpmtimer.addtimer 2000, "DemonKickBall '"
            else
                vpmtimer.addtimer 1500, "DemonKickBall '"
            End IF
    Else
       vpmtimer.addtimer 1500, "DemonKickBall '"
    End If

End Sub

Sub MBPauseTimer_Timer()
  MBPauseTimer.enabled=False
  DemonMultiball
End Sub

Sub DemonMultiball()
    FlashForMs Flasher9, 1000, 50, 0
    FlashForMs Flasher10, 1000, 50, 0 
    DemonMBMode=True
    SaveSong=cursong(CurPlayer)
    debug.print "Saving Song #" & SaveSong
    SaveShots()
    AddMultiball 3
    if Not bBallSaverActive then
      EnableBallSaver(9) ' Multiball BallSaver
    end if

    LockedBalls(CurPlayer) = 0
    bLockEnabled = False
    i85.State = 0
    i86.State = 0
    i87.State = 0
    i88.State = 0
    i89.State = 0

    ' turn off the lock lights
    SetLightColor i82, "orange", 0
    SetLightColor i84, "orange", 0
    i90.State = 0

   ' turn off front row ball Save
    i6.state=lightStateOff
    i44.state=lightstateOff
   
   'Turn On the Jackpot lights
    for each xx in ShotsColl
      SetLightColor xx, "red", 2
    Next
    for xx = 1 to 4
      LastShot(xx)=-1  ' Clear JackPot Shots
    Next
   
    debug.print "Start DEMON MB" 
    DMDGif "scene64.gif","","",slen(64)
    StopSound Track(cursong(CurPlayer))
  ' play speach
    PlaySound "audio662"
    cursong(CurPlayer)=9  ' Calling DR Love
    Song = track(CurSong(CurPlayer))
    PlayMusic Song
    debug.print "Show Saved Song #" & SaveSong
End Sub


Sub Start_LoveGun()
    SetLightColor i25, "white", 2    ' Flash Start Child
    if NOT LoveGunMode and NOT DemonMBMode then ' Not already in MB
      debug.print "Start LoveGun()"
      LoveGunMode=True
      DMDGif "scene50.gif","LOVE GUN","",slen(50) 
      EndMusic
      ' save the previous states
      SaveSong=cursong(CurPlayer)
      SaveShots()
      AddMultiball 3
      if Not bBallSaverActive then
        EnableBallSaver(9) ' Multiball BallSaver
      end if

      'Turn Off Demon Locks
      SetLightColor i82, "orange", 0
      SetLightColor i84, "orange", 0
      i90.State = 0
      bLockEnabled = False    ' Lose the locks 
      
      PlaySound "audio472" ' Love Gun

      for each xx in ShotsColl
        SetLightColor xx, "blue", 1
      Next
      for xx = 1 to 4
        LastShot(xx)=-1  ' Clear JackPot Shots
      Next
      cursong(CurPlayer)=10
      Song = track(CurSong(CurPlayer))
      PlayMusic Song
    end if
End Sub

Sub DemonKickBall()
    PlaySound "fx_kicker", 0, 1, 0.1
    debug.print "DemonKickball Destroyball"
    sw42.destroyball
    sw42top.createball
    sw42top.Kick 200, 8	
    PlaySound "audio65"
End Sub

Sub ResetJackpotLights()
    debug.print "ResetJackpotLights()"
    i118.State = 0
    RightRampLight.State = 0

    LoveGunMode=False ' Turn off the All Jackpot Mode
    DemonMBMode=False

    PlaySound "audio501" ' that was insane
    debug.print "Done MB .. start original track #" & SaveSong

    EndMusic
    cursong(CurPlayer)=SaveSong
    Song = track(CurSong(CurPlayer))
    PlayMusic Song

    LoadShots() ' should restore last state here
    SetLightColor i82, "orange", 2  ' Demon Lock Light
    SetLightColor i84, "orange", 2  ' Demon Lock Light

    if cursong(CurPlayer)=4 then ' Hotter Than Hell means they need to flash on Reset 
      if sw38.isdropped=1 then i35.state=LightStateOn else i35.state=2 end if
      if sw39.isdropped=1 then i36.state=LightStateOn else i36.state=2 end if
      if sw40.isdropped=1 then i37.state=LightStateOn else i37.state=2 end if
      if sw41.isdropped=1 then i38.state=LightStateOn else i38.state=2 end if
    else
      if sw38.isdropped=1 then i35.state=LightStateOn else i35.state=LightStateOff end if
      if sw39.isdropped=1 then i36.state=LightStateOn else i36.state=LightStateOff end if
      if sw40.isdropped=1 then i37.state=LightStateOn else i37.state=LightStateOff end if
      if sw41.isdropped=1 then i38.state=LightStateOn else i38.state=LightStateOff end if
    end if
End Sub

Sub CheckRockCity
  if i25.state=LightStateOn and i26.state=LightStateOn and i27.state=LightStateOn and i28.state=LightStateOn then
    SetLightColor i43, "yellow", 2   ' Rock City
  end if
End Sub

Sub CheckKissArmy
  if i25.state=LightStateBlinking or i26.state=LightStateBlinking or i27.state=LightStateBlinking or i28.state=LightStateBlinking then '1 flashing
    if i25.state <> LightStateOff and i26.state <> LightStateOff and i27.state <> LightStateOff and i28.state <> LightStateOff then
      PlaySound "audio560"
      SetLightColor i40, "yellow", 2 ' KissArmy
    end if
  end if
End Sub

' *********************************************************************
'                        Game Choices
' *********************************************************************

Sub NextCity
  CurCity(CurPlayer)=CurCity(CurPlayer)+1
  if CurCity(CurPlayer) > 15 then
    CurCity(CurPlayer)=1
  end if
  debug.print "Change of city to " & CurCity(CurPlayer)
  PlaySound "audio" & 429+CurCity(CurPlayer),0,1,0.25,0.25
End Sub

Sub NextSong
  debug.print "Stopping "  & Track(cursong(CurPlayer)) 
  EndMusic   
  if NewTrackTimer.enabled then NewTrackTimer.enabled=False:NewTrackTimer.enabled=True  ' auto plunge in NewTrack Mode
  cursong(CurPlayer) = cursong(CurPlayer) + 1
  if cursong(CurPlayer) > 8 then 
    cursong(CurPlayer) = 1
  end if
  If UseUDMD Then UltraDMD.SetScoreboardBackgroundImage CurSong(CurPlayer) & ".png",15,13:UltraDMD.Clear:OnScoreboardChanged()
  if cursong(CurPlayer) = SaveShot(CurPlayer,9) then
    LoadShots()
  else
    InitMode(cursong(CurPlayer))
  End if
  Song=Track(CurSong(CurPlayer))
  SongPause.interval=500
  SongPause.enabled=True ' Play song after short pause in case they change their mind

 End Sub

' ***********************************************************************************
' Save and Load the Shots from player to player
' ***********************************************************************************

Dim SaveShot(4,25), SaveCol(4,6), SaveColf(4,6)

' Save the status of the 6 shots for MB start
Sub SaveShots() 'after MB
  debug.print "SaveShots for player " & CurPlayer
  SaveShot(CurPlayer,1)=i58.state
  SaveShot(CurPlayer,2)=i68.state
  SaveShot(CurPlayer,3)=i73.state
  SaveShot(CurPlayer,4)=i79.state
  SaveShot(CurPlayer,5)=i92.state
  SaveShot(CurPlayer,6)=i98.state
  SaveShot(CurPlayer,7)=i6.state ' front row
  SaveShot(CurPlayer,8)=i44.state 'next track
  SaveShot(CurPlayer,9)=CurSong(CurPlayer)
  if i35.state=LightStateBlinking or i36.state=LightStateBlinking or i37.state=LightStateBlinking or i38.state=LightStateBlinking then
    debug.print "SaveShots .. blinking"
    SaveShot(CurPlayer,10)=1
  else
    SaveShot(CurPlayer,10)=0
  end if
  SaveCol(CurPlayer,1)=i58.color
  SaveCol(CurPlayer,2)=i68.color
  SaveCol(CurPlayer,3)=i73.color
  SaveCol(CurPlayer,4)=i79.color
  SaveCol(CurPlayer,5)=i92.color
  SaveCol(CurPlayer,6)=i98.color
  SaveColf(CurPlayer,1)=i58.colorfull
  SaveColf(CurPlayer,2)=i68.colorfull
  SaveColf(CurPlayer,3)=i73.colorfull
  SaveColf(CurPlayer,4)=i79.colorfull
  SaveColf(CurPlayer,5)=i92.colorfull
  SaveColf(CurPlayer,6)=i98.colorfull
End Sub

' Restore the status of the 6 shots after MB Ends
Sub LoadShots() ' after MB
  debug.print "Load Shots for Player " & CurPlayer
  i58.state=SaveShot(CurPlayer,1)
  i68.state=SaveShot(CurPlayer,2)
  i73.state=SaveShot(CurPlayer,3)
  i79.state=SaveShot(CurPlayer,4)
  i92.state=SaveShot(CurPlayer,5)
  i98.state=SaveShot(CurPlayer,6)
  i6.state =SaveShot(CurPlayer,7)
  i44.state=SaveShot(CurPlayer,8)

  debug.print "Loadshots - targets if 1" & SaveShot(CurPlayer,10)
  if SaveShot(CurPlayer,10)=1 then
    i35.state=LightStateBlinking 
    i36.state=LightStateBlinking 
    i37.state=LightStateBlinking 
    i38.state=LightStateBlinking 
  end if
  i58.color = SaveCol(CurPlayer,1)
  i68.color = SaveCol(CurPlayer,2)
  i73.color = SaveCol(CurPlayer,3)
  i79.color = SaveCol(CurPlayer,4)
  i92.color = SaveCol(CurPlayer,5)
  i98.color = SaveCol(CurPlayer,6)

  i58.colorfull = SaveColf(CurPlayer,1)
  i68.colorfull = SaveColf(CurPlayer,2)
  i73.colorfull = SaveColf(CurPlayer,3)
  i79.colorfull = SaveColf(CurPlayer,4)
  i92.colorfull = SaveColf(CurPlayer,5)
  i98.colorfull = SaveColf(CurPlayer,6)
End Sub

Sub SaveState 'at ball end   ' BSP, SuperTargets, Super Ramps, SuperBumpers, SuperSpinner
  if i41.state=LightStateBlinking then ' BSP
    SaveShot(CurPlayer,11)=1
  else
    SaveShot(CurPlayer,11)=0
  end if
  if i122.state=LightStateBlinking then ' 
    SaveShot(CurPlayer,12)=1
  else
    SaveShot(CurPlayer,12)=0
  end if
  if i95.state=LightStateBlinking then ' 
    SaveShot(CurPlayer,13)=1
  else
    SaveShot(CurPlayer,13)=0
  end if
  if i118.state=LightStateBlinking then ' BSP
    SaveShot(CurPlayer,14)=1
  else
    SaveShot(CurPlayer,14)=0
  end if
  if i61.state=LightStateBlinking then ' Bumpers
    SaveShot(CurPlayer,15)=1
  else
    SaveShot(CurPlayer,15)=0
  end if
  SaveShot(CurPlayer,16)=i90.state
End Sub

Sub LoadState ' At InitBall
  if SaveShot(CurPlayer,11)=1 then
    i41.state=LightStateBlinking 
    i42.state=LightStateBlinking 
  end if
  if SaveShot(CurPlayer,12)=1 then
    i122.state=LightStateBlinking
  end if
  if SaveShot(CurPlayer,13)=1 then
    i95.state=LightStateBlinking
  end if
  if SaveShot(CurPlayer,14)=1 then
    i118.state=LightStateBlinking
  end if
  if SaveShot(CurPlayer,15)=1 then
    i61.state=LightStateBlinking
  end if
  i90.state=SaveShot(CurPlayer,16)
End Sub
