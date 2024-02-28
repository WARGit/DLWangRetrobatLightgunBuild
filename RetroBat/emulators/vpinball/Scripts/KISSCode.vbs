' *************************************
'    KISS Code 
'
Const KissCodeV=1.02
' *************************************
' Code to handle the various modes
' *************************************
' 20161031 track shots made by player by song as some songs require more/less shots to complete

' LO-sw14/58, sc-68, MR-sw64/73, D-sw42/79, RR-sw56/92, ro-sw24/98


Dim Curcolor, Curcolorfull

Sub SaveRGB(ll)
  CurColor=ll.color
  Curcolorfull=ll.colorfull
End Sub

Sub RestoreRGB(ll)
  ll.color=Curcolor
  ll.colorfull=Curcolorfull
End Sub

Sub ProcessLO
  Debug.print "ProcessLO Cursong is " & CurSong(CurPlayer)
  SaveRGB(i58):i58.state=LightStateOff
  if DemonMBMode then
    if LastShot(CurPlayer) = -1 then
      DisplayI(18)
      AddScore(1000000)
    else
     DisplayI(19)
      AddScore(2000000)
    end if
    LastShot(CurPlayer)=1
    Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
    exit sub
  else
    if LoveGunMode then
      if LastShot(CurPlayer) = -1 then
        DisplayI(17)
        AddScore(1000000)
      else
        DisplayI(19)
        AddScore(2000000)
      end if
      LastShot(CurPlayer)=1
      Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
      exit sub
    end if
  end if
  LastShot(CurPlayer)=1
  Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1

  Select Case CurSong(CurPlayer)
    case 5: 
      ShowShot(Shots(CurPlayer,CurSong(CurPlayer))*200000)
      if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff  then ' reset lights
        InitMode(CurSong(CurPlayer))
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 10 = 0 then SongComplete()
    case 2:
      ShowShot(100000)
      if i68.state=LightStateBlinking then
        RestoreRGB(i68):i68.state=LightStateBlinking:RestoreRGB(i73):i73.state=LightStateBlinking:
        SetLightColor i58, "white", 0
      else
        RestoreRGB(i58):i58.state=LightStateBlinking:RestoreRGB(i68):i68.state=LightStateBlinking
        SetLightColor i98, "white", 0
      end if
        DisplayI(8) ' Deuce
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 3:
      ShowShot(100000):i98.state=LightStateBlinking:RestoreRGB(i98)
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 4:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 17 then
        ShowShot(2000000)
      else
        ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if sw38.isdropped=False then i35.state=LightStateBlinking end if
      if sw39.isdropped=False then i36.state=LightStateBlinking end if
      if sw40.isdropped=False then i37.state=LightStateBlinking end if
      if sw41.isdropped=False then i38.state=LightStateBlinking end if
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
    case 1:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 20 then
        ShowShot(2000000)
      else
        ShowShot(50000+ (50000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if NOT i68.state=LightStateOff then  ' Move Left
        i98.state=LightStateBlinking:RestoreRGB(i98):i58.state=LightStateBlinking:RestoreRGB(i58)
        SetLightColor i68, "white", 0
      else
        SetLightColor i98, "white", 0
        RestoreRGB(i58):i58.state=LightStateBlinking:RestoreRGB(i68):i68.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 6:
      ShowShot(300000)
      if i58.state=LightStateOff and i98.state=LightStateoff then ' Both Orbits complete
        RestoreRGB(i68):RestoreRGB(i73):RestoreRGB(i79):RestoreRGB(i92)
        i68.state=LightStateBlinking:i73.state=LightStateBlinking:i79.state=LightStateBlinking:i92.state=LightStateBlinking
      end if
    case 7:
      ShowShot(100000):RestoreRGB(i73):i73.state=LightStateBlinking
    case 8:
       ShowShot(100000)
       if i58.state=LightStateOff and i98.state=LightStateOff then 
          RestoreRGB(i68):i68.state=LightStateBlinking
          RestoreRGB(i79):i79.state=LightStateBlinking
          RestoreRGB(i92):i92.state=LightStateBlinking
       end if
    case 9:
    case 10:
  End Select
End Sub

Sub ProcessSC
  debug.print "ProcessSC"
  SaveRGB(i68)
  SetLightColor i68, "white", 0
  LastShot(CurPlayer)=2
  Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
  debug.print "Shots=" & Shots(CurPlayer,CurSong(CurPlayer))
  Select Case CurSong(CurPlayer)
    case 5: 
      ShowShot(Shots(CurPlayer,CurSong(CurPlayer))*200000)
      if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff  then ' reset lights
        InitMode(CurSong(CurPlayer))
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) = 10 then SongComplete()
    case 2:
      ShowShot(100000)
      if i73.state=LightStateBlinking then
        RestoreRGB(i73):i73.state=LightStateBlinking:RestoreRGB(i79):i79.state=LightStateBlinking:SetLightColor i68, "white", 0
      else
        RestoreRGB(i68):i68.state=LightStateBlinking:RestoreRGB(i73):i73.state=LightStateBlinking:SetLightColor i58, "white", 0
      end if
   '   DisplayI(8) ' Deuce
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 3:
      ShowShot(100000):i98.state=LightStateBlinking:RestoreRGB(i98)
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 4:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 17 then
        ShowShot(2000000)
      else
        ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if sw38.isdropped=False then i35.state=LightStateBlinking end if
      if sw39.isdropped=False then i36.state=LightStateBlinking end if
      if sw40.isdropped=False then i37.state=LightStateBlinking end if
      if sw41.isdropped=False then i38.state=LightStateBlinking end if
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
    case 1:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 20 then
        ShowShot(2000000)
      else
        ShowShot(50000+ (50000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if NOT i73.state=LightStateOff then  ' Move Left
        RestoreRGB(i58):i58.state=LightStateBlinking:RestoreRGB(i68):i68.state=LightStateBlinking:SetLightColor i73, "white", 0
      else
        SetLightColor i58, "white", 0:RestoreRGB(i68):i68.state=LightStateBlinking:RestoreRGB(i73):i73.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 6:
      ShowShot(200000*(Shots(CurPlayer,CurSong(CurPlayer))-1))
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then
        SongComplete()
        SetLightColor i68, "white", 0
        SetLightColor i73, "white", 0
        SetLightColor i79, "white", 0
        SetLightColor i92, "white", 0
      else
        RestoreRGB(i73):RestoreRGB(i79):RestoreRGB(i92)
        SetLightColor i68, "white", 0
        i73.state=LightStateBlinking:i79.state=LightStateBlinking:i92.state=LightStateBlinking
      end if
    case 7:
      ShowShot(100000):RestoreRGB(i73):i73.state=LightStateBlinking
    case 8:
      ShowShot(100000)
      if i68.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff then
         RestoreRGB(i73):i73.state=LightStateBlinking
         SongComplete()
      End If
    case 9:
    case 10:
  End Select
End Sub

Sub RandomBD ' When Bumper is hit & Black Diamond then target moves if its not the RO
  if i98.state=LightStateOff and CurSong(CurPlayer) = 3 then
    debug.print "RandomBD"
    SetLightColor i58,"white", 0
    SetLightColor i68,"white", 0
    SetLightColor i73,"white", 0
    SetLightColor i79,"white", 0
    SetLightColor i92,"white", 0
      Select Case INT(RND*5)+1
        case 1: SetLightColor i58,RGBColors(cRGB), 2
        case 2: SetLightColor i68,RGBColors(cRGB), 2
        case 3: SetLightColor i73,RGBColors(cRGB), 2
        case 4: SetLightColor i79,RGBColors(cRGB), 2
        case 5: SetLightColor i92,RGBColors(cRGB), 2
      End Select
  End If
End Sub

Sub ProcessTarget
   LastShot(CurPlayer)=7 
   ' If Random Shot not already lit then light one
   if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff then
     Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
     if Shots(CurPlayer,CurSong(CurPlayer)) > 5 then
       ShowShot(2000000)
     else
       ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
     end if
    ' light random shot
     debug.print "Light Random shot "
   
     Select Case INT(RND*6)+1
      case 1: SetLightColor i58, "red", 2
      case 2: SetLightColor i68, "red", 2
      case 3: SetLightColor i73, "red", 2
      case 4: SetLightColor i79, "red", 2
      case 5: SetLightColor i92, "red", 2
      case 6: SetLightColor i98, "red", 2
     End Select
  End If
  if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
End Sub

Sub ProcessMR
  SaveRGB(i73):SetLightColor i73, "white", 0
  if DemonMBMode then
    if LastShot(CurPlayer) = -1 then
      DisplayI(18)
      AddScore(1000000)
    else
      DisplayI(19)
      AddScore(2000000)
    end if
    LastShot(CurPlayer)=3
    Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
    exit sub
  else
    if LoveGunMode then
      if LastShot(CurPlayer) = -1 then
        DisplayI(17)
        AddScore(1000000)
      else
        DisplayI(19)
        AddScore(2000000)
      end if
      LastShot(CurPlayer)=3
      Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
      exit sub
    end if
  end if
  LastShot(CurPlayer)=3
  Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
  debug.print "Shots=" & Shots(CurPlayer,CurSong(CurPlayer))
  Select Case CurSong(CurPlayer)
    case 5: 
      ShowShot(Shots(CurPlayer,CurSong(CurPlayer))*200000)
      if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff  then ' reset lights
        InitMode(CurSong(CurPlayer))
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) = 10 then SongComplete()
    case 2:
   '   DisplayI(8) ' Deuce
      ShowShot(100000)
       if i79.state=LightStateBlinking then
        RestoreRGB(i79):i79.state=LightStateBlinking:RestoreRGB(i92):i92.state=LightStateBlinking:SetLightColor i73, "white", 0
      else
        RestoreRGB(i73):i73.state=LightStateBlinking:RestoreRGB(i79):i79.state=LightStateBlinking:SetLightColor i68, "white", 0
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 3:
      ShowShot(100000):i98.state=LightStateBlinking:RestoreRGB(i98)
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 4:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 17 then
        ShowShot(2000000)
      else
        ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if sw38.isdropped=False then i35.state=LightStateBlinking end if
      if sw39.isdropped=False then i36.state=LightStateBlinking end if
      if sw40.isdropped=False then i37.state=LightStateBlinking end if
      if sw41.isdropped=False then i38.state=LightStateBlinking end if
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
    case 1:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 20 then
        ShowShot(2000000)
      else
        ShowShot(50000+ (50000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if Not i79.state=LightStateOff then  ' Move Left
        RestoreRGB(i68):i68.state=LightStateBlinking:RestoreRGB(i73):i73.state=LightStateBlinking:SetLightColor i79, "white", 0
      else
        SetLightColor i68, "white", 0:RestoreRGB(i73):i73.state=LightStateBlinking:RestoreRGB(i79):i79.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 6:
      ShowShot(200000*(Shots(CurPlayer,CurSong(CurPlayer))-1))
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then
        SongComplete()
        SetLightColor i68, "white", 0
        SetLightColor i73, "white", 0
        SetLightColor i79, "white", 0
        SetLightColor i92, "white", 0
      else
        RestoreRGB(i68):RestoreRGB(i79):RestoreRGB(i92)
        SetLightColor i73, "white", 0
        i68.state=LightStateBlinking:i79.state=LightStateBlinking:i92.state=LightStateBlinking
      end if
    case 7:
      ShowShot(100000)
      ' Light Next Light In Sequence
      Select Case Shots(CurPlayer,CurSong(CurPlayer))
        Case 1: RestoreRGB(i68):i68.state=LightStateBlinking
        Case 3: RestoreRGB(i79):i79.state=LightStateBlinking
        Case 5: RestoreRGB(i92):i92.state=LightStateBlinking
        Case 7: RestoreRGB(i98):i98.state=LightStateBlinking
        Case 9: SongComplete()
      End Select  
    case 8:
      debug.print "R&R All night light Orbits"
      ShowShot(100000)
      SaveRGB(i58):i58.state=LightStateBlinking
      RestoreRGB(i98):i98.state=LightStateBlinking  ' Two orbits
    case 9:
    case 10:
  End Select
End Sub

Sub ProcessD
  SaveRGB(i79):SetLightColor i79, "white", 0
  if DemonMBMode then
    if LastShot(CurPlayer) = -1 then
      DisplayI(18)
      AddScore(1000000)
    else
      DisplayI(19)
      AddScore(2000000)
    end if
    LastShot(CurPlayer)=4
    Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
    Exit sub
  else
    if LoveGunMode then
      if LastShot(CurPlayer) = -1 then
        DisplayI(17)
        AddScore(1000000)
      else
        DisplayI(19)
        AddScore(2000000)
      end if
      LastShot(CurPlayer)=4
      Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
      exit sub
    end if
  end if
  LastShot(CurPlayer)=4
  Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
  debug.print "Shots=" & Shots(CurPlayer,CurSong(CurPlayer))
  Select Case CurSong(CurPlayer)
    case 5: 
      ShowShot(Shots(CurPlayer,CurSong(CurPlayer))*200000)
      if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff  then ' reset lights
        InitMode(CurSong(CurPlayer))
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) = 10 then SongComplete()
    case 2:
      ShowShot(100000)
       if i92.state=LightStateBlinking then
        RestoreRGB(i92):i92.state=LightStateBlinking:SaveRGB(i98):i98.state=LightStateBlinking:SetLightColor i79, "white", 0
      else
        RestoreRGB(i79):i79.state=LightStateBlinking:RestoreRGB(i92):i92.state=LightStateBlinking:SetLightColor i73, "white", 0
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 3:
      ShowShot(100000):i98.state=LightStateBlinking:RestoreRGB(i98)
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 4:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 17 then
        ShowShot(2000000)
      else
        ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if sw38.isdropped=False then i35.state=LightStateBlinking end if
      if sw39.isdropped=False then i36.state=LightStateBlinking end if
      if sw40.isdropped=False then i37.state=LightStateBlinking end if
      if sw41.isdropped=False then i38.state=LightStateBlinking end if
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
    case 1:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 20 then
        ShowShot(2000000)
      else
        ShowShot(50000+ (50000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if NOT i92.state=LightStateOff then  ' Move Left
        RestoreRGB(i73):i73.state=LightStateBlinking:RestoreRGB(i79):i79.state=LightStateBlinking:SetLightColor i92, "white", 0
      else
        SetLightColor i73, "white", 0:RestoreRGB(i79):i79.state=LightStateBlinking:RestoreRGB(i92):i92.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 6:
      ShowShot(200000*(Shots(CurPlayer,CurSong(CurPlayer))-1))
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then 
        SongComplete()
        SetLightColor i68, "white", 0
        SetLightColor i73, "white", 0
        SetLightColor i79, "white", 0
        SetLightColor i92, "white", 0
      else
        RestoreRGB(i68):RestoreRGB(i73):RestoreRGB(i92)
        SetLightColor i79, "white", 0
        i68.state=LightStateBlinking:i73.state=LightStateBlinking:i92.state=LightStateBlinking
      end if
    case 7:
      ShowShot(100000):RestoreRGB(i73):i73.state=LightStateBlinking
    case 8:
      ShowShot(100000)
      if i68.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff then
        RestoreRGB(i73):i73.state=LightStateBlinking
        SongComplete()
      End If
    case 9:
    case 10:
  End Select
End Sub

Sub ProcessRR
  SaveRGB(i92):SetLightColor i92, "white", 0
  if DemonMBMode then
    if LastShot(CurPlayer) = -1 then
      DisplayI(17)
      AddScore(1000000)
    else
      DisplayI(28)
      AddScore(2000000)
    end if
    LastShot(CurPlayer)=5
    Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
    exit sub
  else
    if LoveGunMode then
      if LastShot(CurPlayer) = -1 then
        DisplayI(19)
        AddScore(1000000)
      else
        DisplayI(19)
        AddScore(2000000)
      end if
      LastShot(CurPlayer)=5
      Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
      exit sub
    end if
  end if
  LastShot(CurPlayer)=5
  Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
  debug.print "Shots=" & Shots(CurPlayer,CurSong(CurPlayer))
  Select Case CurSong(CurPlayer)
    case 5: 
      ShowShot(Shots(CurPlayer,CurSong(CurPlayer))*200000)
      if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff  then ' reset lights
        InitMode(CurSong(CurPlayer))
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) = 10 then SongComplete()
    case 2:
   '   DisplayI(8) ' Deuce
      ShowShot(100000)
       if i98.state=LightStateBlinking then
        RestoreRGB(i98):i98.state=LightStateBlinking:RestoreRGB(i58):i58.state=LightStateBlinking:SetLightColor i92, "white", 0
      else
        SetLightColor i79, "white", 0:RestoreRGB(i98):i98.state=LightStateBlinking:RestoreRGB(i92):i92.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 3:
      ShowShot(100000):i98.state=LightStateBlinking:RestoreRGB(i98)
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 4:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 17 then
        ShowShot(2000000)
      else
        ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if sw38.isdropped=False then i35.state=LightStateBlinking end if
      if sw39.isdropped=False then i36.state=LightStateBlinking end if
      if sw40.isdropped=False then i37.state=LightStateBlinking end if
      if sw41.isdropped=False then i38.state=LightStateBlinking end if
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
    case 1:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 20 then
        ShowShot(2000000)
      else
        ShowShot(50000+ (50000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if i98.state=LightStateBlinking then  ' Move Left
        RestoreRGB(i79):i79.state=LightStateBlinking:RestoreRGB(i92):i92.state=LightStateBlinking:SetLightColor i98, "white", 0
      else
        SetLightColor i79, "white", 0:RestoreRGB(i92):i92.state=LightStateBlinking:RestoreRGB(i98):i98.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 6:
      ShowShot(200000*(Shots(CurPlayer,CurSong(CurPlayer))-1))
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then
        SongComplete()
        SetLightColor i68, "white", 0
        SetLightColor i73, "white", 0
        SetLightColor i79, "white", 0
        SetLightColor i92, "white", 0
      else
        RestoreRGB(i68):RestoreRGB(i73):RestoreRGB(i79):SetLightColor i92, "white", 0
        i68.state=LightStateBlinking:i73.state=LightStateBlinking:i79.state=LightStateBlinking
      end if
    case 7:
      ShowShot(100000):RestoreRGB(i73):i73.state=LightStateBlinking
    case 8:
      ShowShot(100000)
      if i68.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff then
         RestoreRGB(i73):i73.state=LightStateBlinking
         SongComplete()
     End if
    case 9:
    case 10:
  End Select
End Sub

Sub ProcessRO
  debug.print "ProcessRO"
  SaveRGB(i98):SetLightColor i98, "white", 0
  if DemonMBMode then
    if LastShot(CurPlayer) = -1 then
      DisplayI(18)
      AddScore(1000000)
    else
      DisplayI(19)
      AddScore(2000000)
    end if
    LastShot(CurPlayer)=6
    Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
    exit sub
  else
    if LoveGunMode then
      if LastShot(CurPlayer) = -1 then
        DisplayI(17)
        AddScore(1000000)
      else
        DisplayI(19)
        AddScore(2000000)
      end if
      LastShot(CurPlayer)=6
      Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
      exit sub
    end if
  end if
  LastShot(CurPlayer)=6
  Shots(CurPlayer,CurSong(CurPlayer))=Shots(CurPlayer,CurSong(CurPlayer))+1
  debug.print "Shots=" & Shots(CurPlayer,CurSong(CurPlayer))
  Select Case CurSong(CurPlayer)
    case 5: 
      ShowShot(Shots(CurPlayer,CurSong(CurPlayer))*200000)
      if i58.state=LightStateOff and i68.state=LightStateOff and i73.state=LightStateOff and i79.state=LightStateOff and i92.state=LightStateOff and i98.state=LightStateOff  then ' reset lights
        InitMode(CurSong(CurPlayer))
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) = 10 then SongComplete()
    case 2:
   '   DisplayI(8) ' Deuce
      ShowShot(100000)
      if i58.state=LightStateBlinking then
        RestoreRGB(i58):i58.state=LightStateBlinking:RestoreRGB(i68):i68.state=LightStateBlinking:SetLightColor i98, "white", 0
      else
        RestoreRGB(i98):i98.state=LightStateBlinking:RestoreRGB(i58):i58.state=LightStateBlinking:SetLightColor i98, "white", 0
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 3: ' Goes to a random light
      ShowShot(100000)
      Select Case INT(RND*5)+1
        case 1: i58.state=LightStateBlinking:RestoreRGB(i58)
        case 2: i68.state=LightStateBlinking:RestoreRGB(i68)
        case 3: i73.state=LightStateBlinking:RestoreRGB(i73)
        case 4: i79.state=LightStateBlinking:RestoreRGB(i79)
        case 5: i92.state=LightStateBlinking:RestoreRGB(i92)
      End Select
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then SongComplete()
    case 4: 
      if Shots(CurPlayer,CurSong(CurPlayer)) > 17 then
        ShowShot(2000000)
      else
        ShowShot(250000+(100000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if sw38.isdropped=False then i35.state=LightStateBlinking end if
      if sw39.isdropped=False then i36.state=LightStateBlinking end if
      if sw40.isdropped=False then i37.state=LightStateBlinking end if
      if sw41.isdropped=False then i38.state=LightStateBlinking end if
      if Shots(CurPlayer,CurSong(CurPlayer)) > 10 then SongComplete()
    case 1:
      if Shots(CurPlayer,CurSong(CurPlayer)) > 20 then
        ShowShot(2000000)
      else
        ShowShot(50000+ (50000*Shots(CurPlayer,CurSong(CurPlayer))))
      end if
      if i58.state=LightStateBlinking then  ' Move Left
        RestoreRGB(i92):i92.state=LightStateBlinking:RestoreRGB(i98):i98.state=LightStateBlinking:SetLightColor i58, "white", 0
      else
        SetLightColor i92, "white", 0:RestoreRGB(i98):i98.state=LightStateBlinking:RestoreRGB(i58):i58.state=LightStateBlinking
      end if
      if Shots(CurPlayer,CurSong(CurPlayer)) Mod 12 = 0 then 
        SongComplete()
      end if
    case 6:
      ShowShot(300000)
      if i58.state=LightStateOff and i98.state=LightStateoff Then ' Both Orbits complete
        RestoreRGB(i68):RestoreRGB(i73):RestoreRGB(i79):RestoreRGB(i92)
        i68.state=LightStateBlinking:i73.state=LightStateBlinking:i79.state=LightStateOn:i92.state=LightStateBlinking
      end if
    case 7:
      ShowShot(100000):RestoreRGB(i73):i73.state=LightStateBlinking
    case 8:
       ShowShot(100000)
       if i58.state=LightStateOff then 
          RestoreRGB(i68):RestoreRGB(i68):i68.state=LightStateBlinking
          RestoreRGB(i79):RestoreRGB(i79):i79.state=LightStateBlinking
          RestoreRGB(i92):RestoreRGB(i92):i92.state=LightStateBlinking
       end if
    case 9:
    case 10:
  End Select
End Sub

Sub sw43HoleExit()
    If BallInHole > 0 Then
' check extraball
' check kiss Army
' check rock City
        ProcessScoop()
    End If
End Sub

Sub NewTrackTimer_Timer
   NewTrackTimer.enabled=False
   ChooseSongMode=False
   ScoopDelay.interval=500
   ScoopDelay.Enabled = True
   vpmtimer.addtimer 500, "FlashForMs FlasherExitHole, 1500, 30, 0 '"
   vpmtimer.addtimer 500, "FlashForMs SmallFlasher1, 1500, 30, 0 '"
End Sub

Sub ProcessScoop
  InScoop=True
  ScoopDelay.interval=4000

  if Not i40.state=LightStateOff then ' Kiss ArmyBonus  
    i40.state=LightStateOff 
    msgbox "NOT IMPLEMENTED YET"
  else
    if NOT i43.state=LightStateOff then ' Rock City
      debug.print "Rock City"
      i43.state=LightStateOff
      i25.state=LightStateOff:i26.state=LightStateOff:i27.state=LightStateOff:i28.state=LightStateOff ' Characters
      ' Light All Jackpots
      StopSound Track(cursong(CurPlayer))
      cursong(CurPlayer)=1
      PlaySound Track(cursong(CurPlayer)) ' "bg_music1" 'PlayMusic track(1) ' Detroit Rock City
    else
      if NOT i44.state=LightStateOff then ' New Track
        debug.print "New Track"
        KissHurryUp.enabled=False  ' Need to stop the hurry up and the countdown graphics
        ArmyHurryUp.enabled=False
        DMDTextPause "Select","New Track",3000
        EndMusic
        ChooseSongMode=TRUE
        NewTrackTimer.interval=10000:NewTrackTimer.enabled=True  'auto plunge in NewTrack Mode
        i44.state=LightStateOff
        AddScore(10000)
        Exit Sub
      end if 
      if NOT i39.state=LightStateOff then ' Extra BallHit 
          i39.state=LightStateOff
          debug.print "Extra Ball"
          AwardExtraBall
          LightRockAgain.state=LightStateON ' Rock Again lit
      else ' check backstage pass
        if NOT i41.state=LightStateOff then
          debug.print "BackStage Pass (video)"
          UDMDTimer.enabled=False
          i41.state=LightStateOff:i42.state=LightStateOff
          AddScore(5000)
          BSP.interval=2000:BSP.enabled=True
          Exit Sub ' 
        Else
          debug.print "Scoop - nothing lit"
          AddScore(5000)
          ScoopDelay.Interval = 1500
        End If
      End If
    End if
  End If
  ScoopDelay.Enabled = True
  vpmtimer.addtimer 500, "FlashForMs FlasherExitHole, 1500, 30, 0 '"
  vpmtimer.addtimer 500, "FlashForMs SmallFlasher1, 1500, 30, 0 '"

End Sub

Sub BSP_Timer 
  BSP.enabled=False
  vpmtimer.addtimer 1500, "FlashForMs FlasherExitHole, 1000, 30, 0 '"
  vpmtimer.addtimer 1500, "FlashForMs SmallFlasher1, 1000, 30, 0 '"
  ScoopCB() ' After Backstage Pass video is shown
  DMDGif "scene38.gif", "", "", slen(38)
End Sub

Sub Resync_targets()
    ' resync target lights in case we may have chose Hotter Than Hell
    debug.print "resync_targets"
    if sw38.isdropped=True then i35.state=LightStateOn else i35.state=LightStateOff end if
    if sw39.isdropped=True then i36.state=LightStateOn else i36.state=LightStateOff end if
    if sw40.isdropped=True then i37.state=LightStateOn else i37.state=LightStateOff end if
    if sw41.isdropped=True then i38.state=LightStateOn else i38.state=LightStateOff end if
End Sub

Sub ScoopCB() ' Play after BSP Scene completes
dim rr
   debug.print "ScoopCB()"
   rr=Int(Rnd*6)+1
   if rr > 6 then rr=6
   debug.print "Random Choice of " & rr
   ' Check that we dont already have the random choice
   if rr=1 and i118.state=LightStateBlinking then 
     rr=2
   end if
   if rr=2 and i95.state=LightStateBlinking then 
      rr=3
   end if
   if rr=3 and i122.state=LightStateBlinking then 
      rr=4
   end if
   if rr=5 and i29.state=LightStateOn and i30.state=LightStateOn and i31.state=LightStateOn then 
     rr=6
   end if
   if rr=6 and i61.state=LightStateOn then 
     rr = 4
   end if
Select case rr
     		  Case 1 : DMDGif "scene40.gif", "", "", slen(40)
                            ScoopDelay.interval=4000:ScoopDelay.enabled=True
                            debug.print "Superramps"
                            SetLightColor i118, "white", 2   ' Super Ramps
                            RampCnt(CurPlayer)=0
	   	  Case 2 : DMDGif "scene42.gif", "", "", slen(42)
                           ScoopDelay.interval=4000:ScoopDelay.enabled=True
                           SetLightColor i95, "white", 2   '
                           debug.print "SuperTargets"
                           TargetCnt(CurPlayer)=0
		  Case 3 : DMDGif "scene43.gif", "", "", slen(43)
                           ScoopDelay.interval=4000:ScoopDelay.enabled=True
                           debug.print "Super Spinner"
                           SetLightColor i122, "white", 2  
                           SpinCnt(CurPlayer)=0
                  Case 4 : DMDGif "scene62.gif", "2 MILLION", "", slen(62)
                           ScoopDelay.interval=slen(62)+500:ScoopDelay.enabled=True
                           debug.print "2 Million"
                           AddScore(2000000)
                  Case 5 : if i29.state=LightStateOff then
                             DMDGif "scene62.gif", "2X", "BONUS", slen(62)
                             ScoopDelay.interval=slen(62)+500:ScoopDelay.enabled=True
                             debug.print "2X"
                             BonusMultiplier(CurPlayer)=2
                             i29.state=LightStateOn
                           else
                             if i30.state=LightStateOff then
                               DMDGif "scene62.gif", "3X", "BONUS", slen(62)
                               ScoopDelay.interval=slen(62)+500:ScoopDelay.enabled=True
                               debug.print "3X"
                               BonusMultiplier(CurPlayer)=3
                               i30.state=LightStateOn
                             else
                               DMDGif "scene62.gif", "COLOSSAL", "BONUS", slen(62)
                               ScoopDelay.interval=slen(62)+500:ScoopDelay.enabled=True
                               debug.print "Colossal"
                               i31.state=LightStateOn
                               BonusMultiplier(CurPlayer)=5
                             end if
                           end if
                    Case 6 : DMDGif "scene41.gif", "", "", slen(41)
                           SetLightColor i61, "white", 2  
                           BumperCnt(CurPlayer)=0
                           debug.print "Super Bumpers"                       
                           ScoopDelay.interval=3000:ScoopDelay.enabled=True
     End Select
End Sub

Sub ScoopDelay_Timer
  debug.print "ScoopDelay_Timer()"
  ScoopDelay.Enabled = False
  BallInHole = BallInHole - 1
  sw43.CreateSizedball BallSize / 2
  PlaySound "fx_popper", 0, 1, -0.1, 0.25
  sw43.Kick 175, 14, 1
  vpmtimer.addtimer 1000, "sw43HoleExit '" 'repeat until all the balls are kicked out
  InScoop=False
End Sub

Sub SongComplete()
  DMDTextPause "Song Complete","Total " & ModeScore,1700
  ModeInProgress=False
  i44.state=LightStateBlinking ' Next Track
  for each xx in ShotsColl
    SetLightColor xx, "white", 0
  Next
  Resync_targets
End Sub

Sub ShowShot(points)
  DMDTextPause Title(cursong(CurPlayer)),points,1200
  AddScore(points)
End Sub

' STAR Targets
Sub CheckInstrument1 ' Pauls Guitar
  debug.print "CheckInstrument1"
  if NOT i72.state=LightStateOff then ' Collect Instrument
    debug.print "If STAR then collect Instrument"
    if i64.state=1 and i65.state=1 and i66.state=1 and i67.state=1 then 'STAR
      debug.print "STAR: Play Instrument Video"
      DMDGif "scene55.gif","","",slen(55) 
      i72.state=LightStateOff
      i21.state=LightStateOn  ' pf instrument light 
      i97.state=LightStateBlinking  ' Light Instrument Light
      instruments(CurPlayer)=instruments(CurPlayer)+1
      CheckInstruments()
    end if
  end if	      
End Sub

Sub CheckInstruments
  debug.print "CheckInstruments"
   if i21.state=LightStateOn and i22.state=LightStateOn and i23.state=LightStateOn and i24.state=LightStateOn then
     debug.print "Instrument Cnt is " & instruments(CurPlayer)
     if instruments(CurPlayer)=4 then
'       TextLine1.text="Extra Ball Light"
'       textline2.text="Instrument BONUS"
       I39.state=LightStateBlinking ' Light Extra Ball
       DisplayI(25) ' Extra Ball Lit
     end if
     i21.state=LightStateBlinking:i22.state=LightStateBlinking:i23.state=LightStateBlinking:i24.state=LightStateBlinking
   end if
   if instruments(CurPlayer)=6 then
     DMDGif "scene49.gif","","",slen(49)
     I26.blinkInterval=100
     I26.state=LightStateBlinking ' Spaceman
   end if
   if instruments(CurPlayer)=12 then
     DMDGif "scene49.gif","","",slen(49) 
     I26.blinkInterval=100
     I26.state=LightStateOn ' Spaceman
   end if
   if instruments(CurPlayer)=48 then ' Extra Ball
'     TextLine1.text="Extra Ball Light"
'     textline2.text="Instrument BONUS"
     I39.state=LightStateOn ' Light Extra Ball
   end if
End Sub

Sub CheckLoveGun
   debug.print "CheckLoveGun"
   if i64.state=1 and i65.state=1 and i66.state=1 and i67.state=1 then ' not already LG Ready
     debug.print "Turn off STAR"
     i64.state=0:i65.state=0:i66.state=0:i67.state=0
     if NOT i68.state=LightStateOff then
       processSC()
     end if
     if NOT LoveGunMode then   ' Dont turn on LG Mode while in LG
       if F116.state=LightStateOff then
         debug.print "Play LG Ready"
         F116.state=1                   ' star flasher
         DMDGif "scene26.gif","","",slen(26) 
       End If
    Else
      debug.print "Already in LG Mode"
    End if
   end if
End Sub

Sub CheckBumpers  
  if i17.state=LightStateBlinking and i18.state=LightStateBlinking and i19.state=LightStateBlinking and i20.state=LightStateBlinking and i28.state = LightStateOff then
    debug.print "CatMAN"
    DMDGif "scene47.gif","","",slen(47) 
    i28.blinkinterval=100
    i28.state=LightStateBlinking
    PlaySound "audio377" ' crowd noise
    CheckKissArmy()
  end if
  if i17.state=LightStateOn and i18.state=LightStateOn and i19.state=LightStateOn and i20.state=LightStateOn and NOT i28.state=LightStateOn then
    debug.print "CatMAN"
    DMDGif "scene47.gif","","",slen(47)
    i28.state=LightStateOn
    PlaySound "audio377" ' crowd noise
    CheckRockCity()
  end if
End Sub