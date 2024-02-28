Imports System.Windows.Forms
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Threading
Imports System.Runtime.InteropServices



Public Class Device

	Private LogFileSW As IO.StreamWriter

	Friend _RGB As Boolean
	Friend BlackARGB As Global.ARGB
	Friend WhiteARGB As Global.ARGB
	Friend ALPHAARGB As Global.ARGB
	Private Surface_Clear As Surface = Nothing
	Private _flipY As Boolean = False
	Private SurfaceTransitionCount As Integer = 0

	Private FlasBuffer8(1) As Byte
	Private FlasBuffer24(1) As Global.ARGB
	Private _FlashIsPlaying As Boolean = False
	Private _FlashWidth As Integer
	Private _FlashHeight As Integer
	Private FlashMoviePtr As IntPtr = IntPtr.Zero
	Private FlashFailed As Boolean
	Friend _Vsync As Boolean
	Private VideoLastStartTick As Integer = 0
	Dim hbmp As IntPtr
	Dim timer As MultiMediaTimer
	Private _ManualRender As Boolean
	Private RefreshRate As Integer
	Private ni As IntPtr = IntPtr.Zero
	Public TimeToDrawFrame As Integer
	Private VsyncTimerTick As Integer
	Dim deshdc As IntPtr
	Private RenderingTime As Integer = 0
	Friend LastTimerTick As Integer
	Friend VSyncFailed As Boolean
	Friend DMDForm As VirtualDMD = Nothing

	'Public ClassUsed As Boolean
	Private bmp As Bitmap = Nothing
	Friend Native As XDMDNative = Nothing
	'Friend Buffer(128 * 32) As Byte
	'Friend BufferSolid(128 * 32) As Byte
	'Friend BufferSolidVariable(128 * 32) As Byte
	'Friend FinalBuffer(128 * 32) As Byte
	'Friend FinalBuffer2(128 * 32) As Byte


	Private VideohasLooped As Boolean = False
	Private RestartVideoFlag As Boolean = False



	Friend Buffer8(128 * 32) As Byte
	Friend BufferSolid8(128 * 32) As Byte
	Friend BufferSolidVariable8(128 * 32) As Byte
	Friend FinalBuffer8(128 * 32) As Byte
	Friend FinalBuffer28(128 * 32) As Byte



	Friend Buffer24(128 * 32) As Global.ARGB
	Friend BufferSolid24(128 * 32) As Global.ARGB
	Friend BufferSolidVariable24(128 * 32) As Global.ARGB
	Friend FinalBuffer24(128 * 32) As Global.ARGB
	Friend FinalBuffer224(128 * 32) As Global.ARGB
	Friend RGB24Buffer(128 * 32) As Global.RGB24

	Private _color As Color = Drawing.Color.FromArgb(255, 255, 0, 0)
	Friend Vid As Video = Nothing
	Private Conv As Convert = Nothing
	Private DoExitThread As Boolean = False
	Friend ThreadVideo As Thread = Nothing
	Private ThreadAnimate As Thread = Nothing
	Private VideoDestRect As Rectangle
	Private VideoLoop As Boolean = False
	Private VideoMaintainAspect As Boolean = False
	' Private VideoAutomaticRender As Boolean = False
	Friend _State As PlayState
	Friend _SurfaceState As PlayState
	Friend _HasRendered As Boolean
	Friend _Transition As AnimationType
	Friend _TransitionOut As AnimationType
	Friend _TransmitionPosition As Double
	Friend _TransitionWait As Integer
	Friend _TransitionWaitPosition As Integer
	Friend _TransitionOutSpeed As Integer
	Friend _TransitionSpeed As Integer
	Friend _TransitionRunning As Boolean
	'Friend _TransitionAutoRender As Boolean
	Friend _Transition2 As AnimationType
	Friend _Transition2Out As AnimationType
	Friend _TransmitionPosition2 As Double
	'Friend _TransitionSpeed2 As Integer
	Friend _TransitionRunning2 As Boolean
	Friend _TransitionAutoRender2 As Boolean
	Friend SurfaceTransitions As New ArrayList
	Friend NeedToRender As Boolean = False
	Friend HasStuffToDraw As Boolean = False
	'Friend _HasRendered As Boolean = False
	Private PicG As Graphics = Nothing
	Private BmpG As Graphics = Nothing
	Private ScreenDC As IntPtr
	Dim srchdc As IntPtr
	Private UsingRealDMD As Boolean
	'Public AutoRender As Boolean

	Friend Structure SurfaceAnimation
		Dim TransitionID As Integer
		Dim TransitionType1 As AnimationType
		Dim TransitionType2 As AnimationType
		Dim TransitionType1Out As AnimationType
		Dim TransitionType2Out As AnimationType
		Dim TransitionPosition As Double
		Dim TransitionPosition2 As Double
		Dim TransitionSpeed As Integer
		Dim TransitionSpeedOut As Integer
		Dim TransitionWait As Integer
		Dim TransitionWaitPosition As Integer
		Dim text As String
		Dim CharWidth As Integer
		Dim CharHeight As Integer
		Dim DesRect As Rectangle
		Dim Surface As Surface
		Dim Font As XDMD.Font

	End Structure
	Public Enum PlayState
		Ready = 0
		Playing = 1
	End Enum
	Public Enum AnimationSpeed

		Speed_01 = 1
		Speed_02 = 2
		Speed_03 = 3
		Speed_04 = 4
		Speed_05 = 5
		Speed_06 = 6
		Speed_07 = 7
		Speed_08 = 8
		Speed_09 = 9
		Speed_10 = 10
		Speed_11 = 11
		Speed_12 = 12
		Speed_13 = 13
		Speed_14 = 14
		Speed_15 = 15
		Speed_16 = 16
		Speed_17 = 17
		Speed_18 = 18
		Speed_19 = 19
		Speed_20 = 20
		Speed_21 = 21
		Speed_22 = 22
		Speed_23 = 23
		Speed_24 = 24

		'Speed_30 = 19




	End Enum
	Public Enum AnimationType
		FadeIn = 0
		FadeOut = 1
		ZoomIn = 2
		ZoomOut = 3
		ScrollOffLeft = 4
		ScrollOffRight = 5
		ScrollOnLeft = 6
		ScrollOnRight = 7
		ScrollOffUp = 8
		ScrollOffDown = 9
		ScrollOnUp = 10
		ScrollOnDown = 11
		FillFadeIn = 12
		FillFadeOut = 13
		None = 14
	End Enum
	'Public Enum SurfaceAnimationType
	'    FadeIn = 0
	'    FadeOut = 1
	'    ZoomIn = 2
	'    ZoomOut = 3
	'    ScrollOffLeft = 4
	'    ScrollOffRight = 5
	'    ScrollOnLeft = 6
	'    ScrollOnRight = 7
	'    ScrollOffUp = 8
	'    ScrollOffDown = 9
	'    ScrollOnUp = 10
	'    ScrollOnDown = 11
	'    FillFadeIn = 12
	'    FillFadeOut = 13
	'    None = 14
	'End Enum
	Private Structure StructTransition

	End Structure
	<System.Runtime.InteropServices.DllImport("gdi32.dll")>
	Public Shared Function DeleteObject(ByVal hObject As IntPtr) As Boolean
	End Function

	<System.Runtime.InteropServices.DllImport("user32.dll")>
	Public Shared Function GetDC(ByVal hwnd As IntPtr) As IntPtr
	End Function

	<System.Runtime.InteropServices.DllImport("gdi32.dll")>
	Public Shared Function CreateCompatibleDC(ByVal hdc As IntPtr) As IntPtr
	End Function

	<System.Runtime.InteropServices.DllImport("user32.dll")>
	Public Shared Function ReleaseDC(ByVal hwnd As IntPtr, ByVal hdc As IntPtr) As Integer
	End Function

	<System.Runtime.InteropServices.DllImport("gdi32.dll")>
	Public Shared Function DeleteDC(ByVal hdc As IntPtr) As Integer
	End Function

	<System.Runtime.InteropServices.DllImport("gdi32.dll")>
	Public Shared Function SelectObject(ByVal hdc As IntPtr, ByVal hgdiobj As IntPtr) As IntPtr
	End Function


	<System.Runtime.InteropServices.DllImport("gdi32.dll")>
	Private Shared Function StretchBlt(hdcDest As IntPtr, nXOriginDest As Integer, nYOriginDest As Integer, nWidthDest As Integer, nHeightDest As Integer, hdcSrc As IntPtr, nXOriginSrc As Integer, nYOriginSrc As Integer, nWidthSrc As Integer, nHeightSrc As Integer, dwRop As Integer) As Boolean
	End Function

	Public Declare Function BitBlt Lib "gdi32.dll" Alias "BitBlt" (ByVal hdcDest As IntPtr, ByVal nXDest As Integer, ByVal nYDest As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hdcSrc As IntPtr, ByVal nXSrc As Integer, ByVal nYSrc As Integer, ByVal dwRop As System.Int32) As Long



	Const SRCCOPY As Integer = &HCC0020
	' Wraping things up
	Private Sub MyBitBlt(ByVal SourceGraphics As Graphics, ByVal TargetHDC As IntPtr, ByVal width As Integer, ByVal Height As Integer)
		' Creating a DeviceContext to capture from
		Dim SourceHDC As IntPtr = SourceGraphics.GetHdc
		' Blitting (Copying) the data
		BitBlt(TargetHDC, 0, 0, width, Height, SourceHDC, 0, 0, SRCCOPY)
		' Releasing the Device context used
		SourceGraphics.ReleaseHdc(SourceHDC)
	End Sub
	Private Sub MyBitBlt(ByVal SourceHDC As IntPtr, ByVal TargetHDC As IntPtr, ByVal width As Integer, ByVal Height As Integer, ByVal PosX As Integer, ByVal PosY As Integer)
		' Copying data to a specific position on the target Device Context
		BitBlt(TargetHDC, PosX, PosY, width, Height, SourceHDC, 0, 0, SRCCOPY)
	End Sub
	Public Sub TransitionDisplay(TransitionInType1 As AnimationType, TransitionInType2 As AnimationType, TransitionInspeed As AnimationSpeed, WaitFramesBeforeTransitionOut As Integer, TransitionOutType1 As AnimationType, TransitionOutType2 As AnimationType, TransitionOutSpeed As AnimationSpeed)
		If TransitionInType1 = AnimationType.None Then Return

		_TransitionRunning = True
		_TransmitionPosition = 0
		_TransmitionPosition2 = 0

		_Transition = TransitionInType1
		_Transition2 = TransitionInType2
		_TransitionOut = TransitionOutType1

		_Transition2 = TransitionInType2
		_Transition2Out = TransitionOutType2
		_TransitionSpeed = CInt(TransitionInspeed)
		_TransitionOutSpeed = CInt(TransitionOutSpeed)
		If TransitionOutType1 = AnimationType.None And TransitionOutType2 <> AnimationType.None Then
			_TransitionOut = TransitionOutType2
			_Transition2Out = AnimationType.None
		End If
		_TransitionWait = WaitFramesBeforeTransitionOut
		_TransitionWaitPosition = 0
		_State = PlayState.Playing
	End Sub

	'Public Sub TransitionSurface(Surface As Surface, x As Integer, y As Integer, TransitionType1 As AnimationType, TransitionType2 As AnimationType, speed As AnimationSpeed)
	'    TransitionSurface(Surface, New Rectangle(x, y, Surface.Width, Surface.Height), TransitionType1, TransitionType2, speed)

	'End Sub

	Public Function ModifyTransitionWaitTime(TransitionID As Integer, WaitTimeFromNow As Integer) As Boolean
		Dim iSA As Integer
		iSA = 0
		SyncLock SurfaceTransitions
			For Each sa As SurfaceAnimation In SurfaceTransitions
				If sa.TransitionID = TransitionID Then
					Dim saNew As New SurfaceAnimation
					saNew.TransitionID = sa.TransitionID
					saNew.DesRect = sa.DesRect
					saNew.Surface = sa.Surface
					saNew.TransitionPosition = sa.TransitionPosition
					saNew.TransitionPosition2 = sa.TransitionPosition2
					saNew.TransitionSpeed = sa.TransitionSpeed
					saNew.TransitionSpeedOut = sa.TransitionSpeedOut
					saNew.TransitionType1 = sa.TransitionType1
					saNew.TransitionType2 = sa.TransitionType2
					saNew.TransitionType1Out = sa.TransitionType1Out
					saNew.TransitionType2Out = sa.TransitionType2Out
					saNew.TransitionWait = sa.TransitionWaitPosition + WaitTimeFromNow
					saNew.TransitionWaitPosition = sa.TransitionWaitPosition
					Try
						SurfaceTransitions.Remove(sa)
						SurfaceTransitions.Insert(iSA, saNew)
					Catch ex As Exception

					End Try
					Return True
				End If
			Next
		End SyncLock
		Return False
	End Function

	Public Function TransitionIsPlaying(TransitionID As Integer) As Boolean
		SyncLock SurfaceTransitions
			For Each sa As SurfaceAnimation In SurfaceTransitions
				If sa.TransitionID = TransitionID Then
					Return True
				End If
			Next
		End SyncLock
		Return False
	End Function
	Public Function TransitionSurface(Surface As Surface, x As Integer, y As Integer, TransitionInType1 As AnimationType, TransitionInType2 As AnimationType, SpeedIn As AnimationSpeed, WaitFramesBetweenTransitions As Integer, TransitionOutType1 As AnimationType, TransitionOutType2 As AnimationType, SpeedOut As AnimationSpeed) As Integer
		Return TransitionSurface(Surface, New Rectangle(x, y, Surface.Width, Surface.Height), TransitionInType1, TransitionInType2, SpeedIn, WaitFramesBetweenTransitions, TransitionOutType1, TransitionOutType2, SpeedOut)
	End Function
	Public Function TransitionSurface(Surface As Surface, DesRect As Rectangle, TransitionInType1 As AnimationType, TransitionInType2 As AnimationType, SpeedIn As AnimationSpeed, WaitFramesBetweenTransitions As Integer, TransitionOutType1 As AnimationType, TransitionOutType2 As AnimationType, SpeedOut As AnimationSpeed) As Integer
		Dim sa As New SurfaceAnimation
		sa.DesRect = DesRect
		sa.Surface = Surface
		sa.TransitionPosition = 0
		sa.TransitionPosition2 = 0
		sa.TransitionSpeed = SpeedIn
		sa.TransitionSpeedOut = SpeedOut
		sa.TransitionType1 = TransitionInType1
		sa.TransitionType2 = TransitionInType2
		sa.TransitionType1Out = TransitionOutType1
		sa.TransitionType2Out = TransitionOutType2
		sa.TransitionWait = WaitFramesBetweenTransitions
		sa.TransitionWaitPosition = 0
		sa.Font = Nothing
		If sa.TransitionType1Out = AnimationType.None And sa.TransitionType2Out <> AnimationType.None Then
			sa.TransitionType1Out = sa.TransitionType2Out
			sa.TransitionType2Out = AnimationType.None

		End If
		SurfaceTransitionCount += 1
		If SurfaceTransitionCount > 900000 Then
			SurfaceTransitionCount = 1
		End If
		sa.TransitionID = SurfaceTransitionCount
		SyncLock SurfaceTransitions
			SurfaceTransitions.Add(sa)
		End SyncLock

		_SurfaceState = PlayState.Playing
		Return sa.TransitionID
	End Function
	Public Function TransitionFont(Font As XDMD.Font, Text As String, x As Integer, y As Integer, TransitionInType1 As AnimationType, TransitionInType2 As AnimationType, SpeedIn As AnimationSpeed, WaitFramesBetweenTransitions As Integer, TransitionOutType1 As AnimationType, TransitionOutType2 As AnimationType, SpeedOut As AnimationSpeed) As Integer
		Return TransitionFont(Font, Text, x, y, Font.CharacterWidth, Font.CharacterHeight, TransitionInType1, TransitionInType2, SpeedIn, WaitFramesBetweenTransitions, TransitionOutType1, TransitionOutType2, SpeedOut)
	End Function

	Public Function TransitionFont(Font As XDMD.Font, Text As String, x As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, TransitionInType1 As AnimationType, TransitionInType2 As AnimationType, SpeedIn As AnimationSpeed, WaitFramesBetweenTransitions As Integer, TransitionOutType1 As AnimationType, TransitionOutType2 As AnimationType, SpeedOut As AnimationSpeed) As Integer
		If TransitionInType1 = AnimationType.None Then Return -1

		Dim sa As New SurfaceAnimation
		Dim S As Size = Font.MeasureString(Text, CharWidth, CharHeight)
		sa.DesRect = New Rectangle(x, y, S.Width, S.Height)
		sa.Surface = New Surface(S.Width, S.Height, Me)
		sa.text = Text
		sa.CharWidth = CharWidth
		sa.CharHeight = CharHeight
		sa.TransitionPosition = 0
		sa.TransitionPosition2 = 0
		sa.TransitionSpeed = SpeedIn
		sa.TransitionSpeedOut = SpeedOut
		sa.TransitionType1 = TransitionInType1
		sa.TransitionType2 = TransitionInType2
		sa.TransitionType1Out = TransitionOutType1
		sa.TransitionType2Out = TransitionOutType2
		sa.TransitionWait = WaitFramesBetweenTransitions
		sa.TransitionWaitPosition = 0
		sa.Font = Font
		'If Not sa.Font Is Nothing Then
		If Me._RGB Then
			sa.Surface.Clear24(Me.ALPHAARGB)
		Else
			sa.Surface.Clear8(16)
		End If

		sa.Font.Draw(sa.Surface, 0, 0, sa.CharWidth, sa.CharHeight, 15, sa.text)
		'End If
		If sa.TransitionType1Out = AnimationType.None And sa.TransitionType2Out <> AnimationType.None Then
			sa.TransitionType1Out = sa.TransitionType2Out
			sa.TransitionType2Out = AnimationType.None

		End If
		SurfaceTransitionCount += 1
		If SurfaceTransitionCount > 900000 Then
			SurfaceTransitionCount = 1
		End If
		sa.TransitionID = SurfaceTransitionCount
		SyncLock SurfaceTransitions
			SurfaceTransitions.Add(sa)
		End SyncLock

		_SurfaceState = PlayState.Playing
		Return sa.TransitionID
	End Function

	Public ReadOnly Property DisplayTransitionState As PlayState
		Get
			Return _State

		End Get
	End Property
	Public ReadOnly Property SurfaceFontTransitionState As PlayState
		Get
			Return _SurfaceState

		End Get
	End Property
	Public Sub New(UseVirtualDMD As Boolean, VSync As Boolean, RGB As Boolean)
		_Vsync = VSync

		InternalNew(False, UseVirtualDMD, CInt(((Screen.PrimaryScreen.Bounds.Width / 2) - (768 / 2))), CInt(((Screen.PrimaryScreen.Bounds.Height / 2) - (192 / 2))), 768, 192, VSync, RGB, _color)

	End Sub
	Public Sub New(UseVirtualDMD As Boolean, VSync As Boolean, RGB As Boolean, Color As Color)
		_Vsync = VSync

		InternalNew(False, UseVirtualDMD, CInt(((Screen.PrimaryScreen.Bounds.Width / 2) - (768 / 2))), CInt(((Screen.PrimaryScreen.Bounds.Height / 2) - (192 / 2))), 768, 192, VSync, RGB, Color)

	End Sub
	Public Sub New(UseVirtualDMD As Boolean, VSync As Boolean)
		_Vsync = VSync

		InternalNew(False, UseVirtualDMD, CInt(((Screen.PrimaryScreen.Bounds.Width / 2) - (768 / 2))), CInt(((Screen.PrimaryScreen.Bounds.Height / 2) - (192 / 2))), 768, 192, VSync, False, _color)

	End Sub
	Public Sub New(VirtualDMDX As Integer, VirtualDMDY As Integer, Vsync As Boolean, RGB As Boolean)
		InternalNew(False, True, VirtualDMDX, VirtualDMDY, 768, 192, Vsync, RGB, _color)
	End Sub
	Public Sub New(VirtualDMDX As Integer, VirtualDMDY As Integer, Vsync As Boolean)
		InternalNew(False, True, VirtualDMDX, VirtualDMDY, 768, 192, Vsync, False, _color)
	End Sub

	Public Sub New(VirtualDMDX As Integer, VirtualDMDY As Integer, VirtualDMDWidth As Integer, VirtualDMDHeight As Integer, Vsync As Boolean, RGB As Boolean)
		InternalNew(False, True, VirtualDMDX, VirtualDMDY, VirtualDMDWidth, VirtualDMDHeight, Vsync, RGB, _color)
	End Sub
	Public Sub New(VirtualDMDX As Integer, VirtualDMDY As Integer, VirtualDMDWidth As Integer, VirtualDMDHeight As Integer, Vsync As Boolean)
		InternalNew(False, True, VirtualDMDX, VirtualDMDY, VirtualDMDWidth, VirtualDMDHeight, Vsync, False, _color)
	End Sub
	Public Sub Dispose()
		If Not ThreadVideo Is Nothing Then
			If ThreadVideo.IsAlive Then
				DoExitThread = True
				Dim i As Integer = 0
				For i = 0 To 2000
					If Not ThreadVideo.IsAlive Then
						Exit For
					End If
				Next

				Threading.Thread.Sleep(10)
				Application.DoEvents()
			End If
		End If
		If Not ThreadAnimate Is Nothing Then
			If ThreadAnimate.IsAlive Then
				DoExitThread = True
				Dim i As Integer = 0
				For i = 0 To 2000
					If Not ThreadAnimate.IsAlive Then
						Exit For
					End If
				Next

				Threading.Thread.Sleep(10)
				Application.DoEvents()
			End If
		End If
		If Not Vid Is Nothing Then
			Try
				Vid.StopVideo()
			Catch ex As Exception

			End Try
			Try
				Vid.Dispose(False)
			Catch ex As Exception

			End Try
			Try
				Vid.VideoEngine.ReleaseAllInterfacesFinal()
			Catch ex As Exception

			End Try
			Vid = Nothing
		End If
		If Not Conv Is Nothing Then
			Conv = Nothing

		End If

		If Not Native Is Nothing Then

			If UsingRealDMD Then
				UnInitPinDMD()
				UsingRealDMD = False
			End If

		End If
		If Not Surface_Clear Is Nothing Then
			Surface_Clear.Dispose()
			Surface_Clear = Nothing

		End If
		If Not Native Is Nothing Then
			Try
				Native.Dispose()
			Catch
			End Try
		End If

		Native = Nothing
		If Not timer Is Nothing Then
			Try
				timer.Stop()
			Catch ex As Exception

			End Try
			Try
				timer.Dispose()
			Catch ex As Exception

			End Try
			timer = Nothing
		End If
		If Not bmp Is Nothing Then
			bmp.Dispose()
			bmp = Nothing
		End If

		If Not DMDForm Is Nothing Then
			If 1 = 1 Then
				DMDForm.Close()
				DMDForm.Dispose()
				DMDForm = Nothing
			End If
		End If


	End Sub
	Public Function InitPinDMD() As Boolean
		If Not UsingRealDMD Then
			Dim Res As Integer = Native.InitRealDMD
			If Res > 0 Then
				UsingRealDMD = True
			End If
			If Res = 1 Then
				_RGB = False
			End If
		End If
		'MsgBox(UsingRealDMD.ToString)
		'End If
		Return UsingRealDMD
	End Function

	Public Sub renderRGB24Frame(ByRef currbuffer() As ARGB)
		Static LastTick As Integer
		If LastTick = 0 Then
			LastTick = Environment.TickCount - 60
		End If
		If Environment.TickCount - LastTick < 17 Then
			Return
		End If
		Native.ConvertoARGBtoRGB(UBound(currbuffer), currbuffer, RGB24Buffer)
		Native.renderDMDFrame(128, 32, RGB24Buffer)
		LastTick = Environment.TickCount
	End Sub


	Public Function UnInitPinDMD() As Boolean
		If UsingRealDMD Then
			_TransitionRunning = False


			Surface_Clear.Draw(New Rectangle(0, 0, 128, 32))
			'Sur.draw(New Rectangle(0, 0, 128, 32))
			Try
				_ManualRender = True
				RenderWait()

			Catch ex As Exception

			End Try


			UsingRealDMD = False
			Return Native.DisposeRealDMD()


			'MsgBox(UsingRealDMD.ToString)
		End If
		Return False

	End Function

	Public ReadOnly Property PinDMDInitialized As Boolean
		Get
			Return UsingRealDMD
		End Get
	End Property
	Private Sub InternalNew(UseRealDMD As Boolean, UseVirtualDMD As Boolean, VirtualDMDX As Integer, VirtualDMDY As Integer, VirtualDMDWidth As Integer, VirtualDMDHeight As Integer, Vsync As Boolean, UseRGB As Boolean, DMDColor As Color)

		If Not IO.Directory.Exists(Application.StartupPath + "\Log") Then
			IO.Directory.CreateDirectory(Application.StartupPath + "\Log")

		End If
		If IO.File.Exists(Application.StartupPath & "\LOG\" & "XDMDlog.txt") Then
			IO.File.Delete(Application.StartupPath & "\LOG\" & "XDMDlog.txt")
		End If

		'Log("Initialize XDMD")

		_RGB = UseRGB

		BlackARGB.R = 0
		BlackARGB.G = 0
		BlackARGB.B = 0
		BlackARGB.A = 255


		WhiteARGB.R = 255
		WhiteARGB.G = 255
		WhiteARGB.B = 255
		WhiteARGB.A = 255

		ALPHAARGB.R = 0
		ALPHAARGB.G = 0
		ALPHAARGB.B = 0
		ALPHAARGB.A = 0

		_Vsync = Vsync
		VSyncFailed = False

		RefreshRate = 0

		If Native Is Nothing Then
			Native = New XDMDNative

		End If

		'Native.
		''Native.
		If Not UsingRealDMD Then
			' Log("Initialize Real DMD")
			Dim res As Integer = Native.InitRealDMD
			If res > 0 Then
				UsingRealDMD = True
			End If
			If res = 1 Then
				_RGB = False
			End If
			'MsgBox(UsingRealDMD.ToString)
		End If


		If Surface_Clear Is Nothing Then
			Dim BMP As New Bitmap(128, 32)
			Dim G As Graphics = Graphics.FromImage(BMP)
			G.Clear(Drawing.Color.Black)
			Surface_Clear = New Surface(BMP, Me)
			G.Dispose()
			G = Nothing
			BMP.Dispose()
			BMP = Nothing


		End If

		If Vid Is Nothing Then
			Vid = New Video
		End If

		'If UseVirtualDMD Then
		If DMDForm Is Nothing Then
			DMDForm = New VirtualDMD
		End If
		NeedToRender = False
		SyncLock SurfaceTransitions
			SurfaceTransitions.Clear()
		End SyncLock

		Native.Clear(BufferSolid8, UBound(BufferSolid8), 15)
		Native.Clear(BufferSolidVariable8, UBound(BufferSolidVariable8), 15)


		Native.Clear(BufferSolid24, UBound(BufferSolid24), WhiteARGB)
		Native.Clear(BufferSolidVariable24, UBound(BufferSolidVariable24), WhiteARGB)
		Dim idc As IntPtr = GetDC(IntPtr.Zero)
		ScreenDC = CreateCompatibleDC(idc)
		DeleteDC(idc)
		If Not UseVirtualDMD Then
			'DMDForm.Visible = False
		Else
			DMDForm.Show()
			'Application.DoEvents()
			''If Not DMDForm.Focused Then
			'DMDForm.Select()
			'DMDForm.Focus()
			'DMDForm.BringToFront()

			'Application.DoEvents()
			'MsgBox("")
			'End If
		End If
		'Application.DoEvents()
		DMDForm.Left = VirtualDMDX
		DMDForm.Top = VirtualDMDY
		DMDForm.Width = VirtualDMDWidth
		DMDForm.Height = VirtualDMDHeight
		'If Not DMDForm.Pic.Image Is Nothing Then
		'    DMDForm.Pic.Image.Dispose()
		'    DMDForm.Pic.Image = Nothing
		'End If
		'DMDForm.Pic.Image = New Bitmap(768, 192)
		If _RGB Then
			bmp = New Bitmap(768, 192, PixelFormat.Format24bppRgb)
			Native.Clear(bmp, BlackARGB)
		Else

			bmp = New Bitmap(768, 192, PixelFormat.Format8bppIndexed)
			Native.Clear(bmp, 0)
		End If


		'ni = IntPtr.Zero
		'ni = CreateCompatibleDC(BmpG)
		'BmpG.Clear(Drawing.Color.Blue)

		'Dim palette As ColorPalette = bmp.Palette
		'For i As Integer = 0 To palette.Entries.Length - 1
		'    palette.Entries(i) = Color.FromArgb(255, i, i, i)
		'Next
		'bmp.Palette = palette

		Color = DMDColor
		'bmp = DMDForm.Pic.Image
		'DMDForm.Pic.Image = bmp
		'PicG = DMDForm.Pic.CreateGraphics
		'For i As Integer = 0 To UBound(Buffer) Step 2
		'    Buffer(i) = 15
		'Next
		'Dim c As New Convert
		'Dim bp As New Bitmap(Application.StartupPath + "\arcade.png")
		'Dim b() As Byte = c.GetBufferFromBitmap(bp)
		'Dim tickstart As Integer = Environment.TickCount
		'Do While Environment.TickCount - tickstart < 30000
		'    For i As Integer = 0 To 15
		'        Application.DoEvents()
		'        Threading.Thread.Sleep(60)
		'        Native.Clear(Buffer, UBound(Buffer), 0)
		'        c.Draw(b, Buffer, bp.Width, bp.Height, New Rectangle(0, 0, bp.Width, 32), New Rectangle(-2, 0, bp.Width, 32), i)
		'        Native.Render(bmp, Buffer)
		'        DMDForm.Pic.Invalidate()
		'    Next
		'    Application.DoEvents()
		'    Threading.Thread.Sleep(1000)
		'    For i As Integer = 15 To 0 Step -1
		'        Application.DoEvents()
		'        Threading.Thread.Sleep(60)
		'        Native.Clear(Buffer, UBound(Buffer), 0)
		'        c.Draw(b, Buffer, bp.Width, bp.Height, New Rectangle(0, 0, bp.Width, 32), New Rectangle(-2, 0, bp.Width, 32), i)
		'        Native.Render(bmp, Buffer)
		'        DMDForm.Pic.Invalidate()
		'    Next
		'Loop

		'c.Draw(b, Buffer, bp.Width, bp.Height, New Rectangle(0, 0, bp.Width, 32), New Rectangle(0, 0, bp.Width, 32), 7)
		'c.Draw(b, Buffer, bp.Width, bp.Height, New Rectangle(0, 0, bp.Width, 32), New Rectangle(-18, 10, bp.Width, 32), 8)
		'Native.Render(bmp, Buffer)

		''For y As Integer = 0 To bp.Height - 1
		''    For x As Integer = 0 To bp.Width - 1
		''        Dim pix As Integer = b(x + (y * bp.Width))
		''        pix = CInt(pix * 16)
		''        If pix > 255 Then
		''            pix = 255
		''        End If
		''        Dim col As Color = Color.FromArgb(255, pix, pix, pix)
		''        bp.SetPixel(x, y, col)
		''    Next
		''Next
		'Native.Clear(bmp, 13)
		'DMDForm.Pic.Invalidate()
		'Application.DoEvents()
		'Thread.Sleep(1000)
		DMDForm.PassDeviceRef(Me)

		'bp.Save(Application.StartupPath + "\ShouldBeBlack.png")
		'End If



		timer = New MultiMediaTimer(Me)
		If _Vsync Then
			timer.Period = 8
		Else
			timer.Period = 16
		End If

		'timer.Resolution=1
		timer.Start()
	End Sub
	'Sub ClearVirtualDMD(Colour As Integer)
	'    Dim data As BitmapData = bmp.LockBits(New Rectangle(System.Drawing.Point.Empty, bmp.Size), ImageLockMode.ReadWrite, System.Drawing.Imaging.PixelFormat.Format4bppIndexed)

	'End Sub
	Public Property RGB As Boolean
		Get
			Return _RGB
		End Get
		Set(value As Boolean)
			_RGB = value
		End Set
	End Property
	Public Property FlipY As Boolean
		Get
			Return _flipY
		End Get
		Set(value As Boolean)
			_flipY = value
		End Set
	End Property
	Public Property Visible As Boolean
		Get
			If Not DMDForm Is Nothing Then
				If 1 = 1 Then
					Return DMDForm.Visible
				End If
			End If
			Return False
		End Get
		Set(value As Boolean)
			If Not DMDForm Is Nothing Then
				If 1 = 1 Then
					DMDForm.Visible = value
				End If
			End If
		End Set
	End Property
	Public Property Color As Color
		Get
			Return _color
		End Get
		Set(value As Color)
			_color = value
			If Not DMDForm Is Nothing Then
				If Not _RGB Then

					Dim palette As ColorPalette = bmp.Palette
					Dim R As Double = 0
					Dim G As Double = 0
					Dim B As Double = 0
					If _color.R > 0 Then
						R = _color.R / 255
					End If
					If _color.G > 0 Then
						G = _color.G / 255
					End If
					If _color.B > 0 Then
						B = _color.B / 255
					End If
					For i As Integer = 0 To palette.Entries.Length - 1
						Dim _R As Integer = CInt(R * i)
						Dim _g As Integer = CInt(G * i)
						Dim _b As Integer = CInt(B * i)
						'MsgBox(_R)
						If _R > 255 Then _R = 255
						If _g > 255 Then _g = 255
						If _b > 255 Then _b = 255

						palette.Entries(i) = Color.FromArgb(255, _R, _g, _b)
					Next
					bmp.Palette = palette
					'DMDForm.Pic.Invalidate()
				End If
			End If
			If UsingRealDMD AndAlso Not _RGB Then
				Dim Col(15) As RGB24
				'Dim inc As Integer = 0

				'Dim palette As ColorPalette = bmp.Palette
				Dim R As Double = 0
				Dim G As Double = 0
				Dim B As Double = 0
				If _color.R > 0 Then
					R = _color.R / 255
				End If
				If _color.G > 0 Then
					G = _color.G / 255
				End If
				If _color.B > 0 Then
					B = _color.B / 255
				End If
				For i As Integer = 0 To 15
					Dim _R As Integer = CInt(R * (i * 17))
					Dim _g As Integer = CInt(G * (i * 17))
					Dim _b As Integer = CInt(B * (i * 17))
					'MsgBox(_R)
					If _R > 255 Then _R = 255
					If _g > 255 Then _g = 255
					If _b > 255 Then _b = 255
					Col(i).R = CByte(_R)
					Col(i).G = CByte(_g)
					Col(i).B = CByte(_b)

					'palette.Entries(i) = Color.FromArgb(255, _R, _g, _b)
				Next
				Native.SetRealDMDColor(Col)
				'bmp.Palette = palette
				'For i As Integer = 0 To 15

				'    Dim newcol As Color = Color.FromArgb(255, value.R, value.G, value.B)
				'    inc += 17

				'Next
			End If
		End Set
	End Property
	Public Sub _Log(ByVal logMessage As String)
		Try
			'If InStr(logMessage, vbNewLine) > 0 Then

			For Each st As String In Split(logMessage, vbNewLine)
				LogSingleLine(st)
			Next
			'Else
			'    LogSingleLine(logMessage)
			'End If
		Catch
		End Try

	End Sub
	Private Sub LogSingleLine(ByVal logMessage As String)
		' Static LogFileOpen As Boolean


		'Try
		'If Not LogCreated Then
		'    Try
		'        If File.Exists(Application.StartupPath & "\LOG\" & "log.txt") Then
		'            LogFileSW = File.AppendText(Application.StartupPath & "\LOG\" & "log.txt")
		'        Else
		'            LogFileSW = File.CreateText(Application.StartupPath & "\LOG\" & "log.txt")
		'        End If
		'        LogFileOpen = True
		'    Catch
		'        Return
		'    End Try

		'    LogCreated = True
		'Else
		'    If Not (LogFileOpen) Then
		LogFileSW = IO.File.AppendText(Application.StartupPath & "\LOG\" & "XDMDlog.txt")
		'        LogFileOpen = True
		'    End If

		'End If


		Dim cd As Date = DateTime.Now
		LogFileSW.WriteLine(Microsoft.VisualBasic.Right("0" & cd.Hour.ToString, 2) & ":" & Microsoft.VisualBasic.Right("0" & cd.Minute.ToString, 2) & ":" & Microsoft.VisualBasic.Right("0" & cd.Second.ToString, 2) & "." & Trim(CStr(Int((cd.Millisecond + 0.001) / 100))) & "  " & cd.ToShortDateString & ":" & "  " & logMessage)




		'If Not BatchLog Then
		LogFileSW.Close()
		'LogFileOpen = False
		'End If




		'Catch
		'End Try

	End Sub
	Public Sub Clear()
		If _RGB Then
			Native.Clear(Buffer24, UBound(Buffer24), BlackARGB)
		Else
			Native.Clear(Buffer8, UBound(Buffer8), 0)
		End If

		HasStuffToDraw = True
		Render()
	End Sub
	Public Sub Clear8(Color As Integer)
		If Color < 0 Then Color = 0
		If Color > 15 Then Color = 15
		Native.Clear(Buffer8, UBound(Buffer8), Color)
		HasStuffToDraw = True
	End Sub

	Public Sub Clear24(Color As Global.ARGB)

		Native.Clear(Buffer24, UBound(Buffer24), Color)
		HasStuffToDraw = True
	End Sub


	Friend Sub InteralRender(VSync As Boolean)
		'If Not HasStuffToDraw Then Return
		'HasStuffToDraw = False

		Static TimeToDoVsync As Integer
		'Static TimeToInvalidate As Integer

		'Static TimeToDoSleep As Integer
		If VSyncFailed Then VSync = False
		Static LocalTimeSlept As Integer




		If Not DMDForm Is Nothing Then


			If DMDForm.Visible Then
				'_HasRendered = True
				'MsgBox("")
				If _TransitionRunning Then
					If _RGB Then
						If _Transition2 <> AnimationType.None Then

							Native.Render(bmp, FinalBuffer224)
						Else
							'Native.FlipY(128, 32, FinalBuffer)
							Native.Render(bmp, FinalBuffer24)
						End If
					Else
						If _Transition2 <> AnimationType.None Then

							Native.Render(bmp, FinalBuffer28)
						Else
							'Native.FlipY(128, 32, FinalBuffer)
							Native.Render(bmp, FinalBuffer8)
						End If
					End If




				Else
					'Native.FlipY(128, 32, Buffer)
					If _RGB Then
						Native.Render(bmp, Buffer24)
					Else
						Native.Render(bmp, Buffer8)
					End If

					'Beep()
				End If
				'Dim nbmp As New Bitmap(768, 192, Imaging.PixelFormat.Format24bppRgb)
				'Dim g As Graphics = DMDForm.Pic.CreateGraphics
				If PicG Is Nothing Then
					PicG = DMDForm.CreateGraphics
					deshdc = PicG.GetHdc
				End If

				hbmp = bmp.GetHbitmap
				''Dim g As Graphics = Graphics.FromImage(nbmp)

				'Dim i As IntPtr = CreateCompatibleDC(idc)
				SelectObject(ScreenDC, hbmp)
				'BmpG = Graphics.FromImage(bmp)
				'BmpG.Clear(Drawing.Color.Tomato)
				'g.Clear(Drawing.Color.White)
				If _flipY Then
					StretchBlt(deshdc, 0, 0, DMDForm.Width, DMDForm.Height, ScreenDC, 0, bmp.Height - 1, bmp.Width, -bmp.Height, SRCCOPY)
				Else
					StretchBlt(deshdc, 0, 0, DMDForm.Width, DMDForm.Height, ScreenDC, 0, 0, bmp.Width, bmp.Height, SRCCOPY)
				End If
				'BitBlt(deshdc, 0, 0, DMDForm.Width, DMDForm.Height, ScreenDC, 0, 0, 13369376)
				'ReleaseDC(DMDForm.Handle, deshdc)
				'PicG.ReleaseHdc(deshdc)
				'DeleteDC(i)

				DeleteObject(hbmp)

				'BmpG.ReleaseHdc(srchdc)
				'MsgBox("")
				'DMDForm.Pic.Invalidate()
			End If

		End If

		'End If


		If UsingRealDMD Then
			'_HasRendered = True
			If _TransitionRunning Then
				If Not _RGB Then
					If _Transition2 <> AnimationType.None Then
						If _flipY Then Native.FlipY(128, 32, FinalBuffer28)
						Native.renderDMDFrame(128, 32, FinalBuffer28)
					Else
						If _flipY Then Native.FlipY(128, 32, FinalBuffer8)
						Native.renderDMDFrame(128, 32, FinalBuffer8)
					End If
				Else
					If _Transition2 <> AnimationType.None Then
						If _flipY Then Native.FlipY(128, 32, FinalBuffer224)
						renderRGB24Frame(FinalBuffer224)
					Else
						If _flipY Then Native.FlipY(128, 32, FinalBuffer24)
						renderRGB24Frame(FinalBuffer24)
					End If
				End If
			Else
				If Not _RGB Then
					If _flipY Then Native.FlipY(128, 32, Buffer8)
					Native.renderDMDFrame(128, 32, Buffer8)
					'Beep()
				Else
					If _flipY Then Native.FlipY(128, 32, Buffer24)
					renderRGB24Frame(Buffer24)
				End If
			End If
		End If

		If _RGB Then
			Native.Clear(Buffer24, UBound(Buffer24), BlackARGB)
		Else
			Native.Clear(Buffer8, UBound(Buffer8), 0)
		End If

		'ReDim Buffer(128 * 32)

		ProcessTransitions()


		RenderingTime = ((Environment.TickCount - VsyncTimerTick) - TimeToDoVsync) - LocalTimeSlept


		'If Not DMDForm Is Nothing Then

		'    'End
		'    If VSync And Not VSyncFailed Then

		'    End If
		'End If

		'Threading.Thread.Sleep(5

		TimeToDrawFrame = Environment.TickCount - VsyncTimerTick
		'DMDForm.Text = TimeSlept.ToString
		If VSync And Not VSyncFailed Then
			Dim tickDiff As Integer = (Environment.TickCount - (VsyncTimerTick))

			If tickDiff < RefreshRate Then
				'Threading.Thread.Sleep(5)
				'Threading.Thread.Sleep((RefreshRate) - tickDiff)
				'Threading.Thread.Sleep(3)
				'TimeSlept = ((RefreshRate - 5) - tickDiff)
				'TimeSlept = (RefreshRate - 1) - RenderingTime
				'Beep()
			Else
				'TimeSlept = 0
				'tickDiff = 0
				'Threading.Thread.Sleep(4)
			End If
			LocalTimeSlept = TimeToDrawFrame
		End If
		VsyncTimerTick = Environment.TickCount
		'LocalLastTimerTick = Environment.TickCount

	End Sub
	Public ReadOnly Property HasRendered As Boolean
		Get
			Return _HasRendered
		End Get
	End Property
	Public Sub Render()
		If _ManualRender Then
			InteralRender(_Vsync)
			Return
		End If
		'If UsingRealDMD Then
		'    NeedToRender = True
		'End If
		'If Not DMDForm Is Nothing Then
		'    If 1 = 1 Then
		'        NeedToRender = True
		'    End If
		'End If
		'If NeedToRender Then
		'    
		'End If
		_HasRendered = False
		NeedToRender = True
		'If Not AutoRender Then
		'    InteralRender(False)
		'End If

	End Sub
	'Public Sub Render()
	'    Render(False)
	'End Sub

	Public Sub RenderWait()
		If _ManualRender Then
			InteralRender(_Vsync)
			Return
		End If
		'If UsingRealDMD Then
		'    NeedToRender = True
		'    _HasRendered = False
		'End If
		'If Not DMDForm Is Nothing Then
		'    If 1 = 1 Then
		'        NeedToRender = True
		'        _HasRendered = False
		'    End If
		'End If

		'If NeedToRender Then
		'    Dim TickDiff As Integer = Environment.TickCount - LastTimerTick
		'    LastTimerTick = Environment.TickCount
		'    If AutoRender Then
		'        If TickDiff < 13 Then
		'            Threading.Thread.Sleep(16 - TickDiff)

		'        End If
		'        Application.DoEvents()
		'        Dim cnt As Integer = 0

		'        Do While Not _HasRendered
		'            Threading.Thread.Sleep(1)
		'            Application.DoEvents()
		'            cnt += 1
		'            If cnt > 300 Then
		'                Exit Do
		'            End If
		'        Loop
		'    Else
		'        If Vsync AndAlso Not VSyncFailed Then

		'        Else
		'            If TickDiff < 16 Then
		'                Threading.Thread.Sleep(16 - TickDiff)

		'            End If
		'        End If

		'        InteralRender(Vsync)
		'    End If

		'End If
		_HasRendered = False
		NeedToRender = True
		Do While NeedToRender
			Threading.Thread.Sleep(2)
		Loop
	End Sub
	Public Sub [Stop]()
		If Not ThreadVideo Is Nothing Then
			If ThreadVideo.IsAlive Then
				DoExitThread = True
				Dim i As Integer = 0
				For i = 0 To 2000
					If Not ThreadVideo.IsAlive Then
						Exit For
					End If
					Threading.Thread.Sleep(10)
				Next

				'                Threading.Thread.Sleep(10)
				'                Application.DoEvents()
			End If
		End If
		If Not ThreadAnimate Is Nothing Then
			If ThreadAnimate.IsAlive Then
				DoExitThread = True
				Dim i As Integer = 0
				For i = 0 To 2000
					If Not ThreadAnimate.IsAlive Then
						Exit For
					End If
					Threading.Thread.Sleep(10)
				Next


				'                Application.DoEvents()
			End If
		End If
		If Not Vid Is Nothing Then
			If Not Vid.VideoEngine Is Nothing Then
				Try
					Vid.VideoEngine.StopWait()
				Catch ex As Exception

				End Try
			End If

			'Vid.StopVideo()

		End If
		If Not Native Is Nothing Then
			Try
				'Native.ReleaseAllInterfacesFinal()
			Catch ex As Exception

			End Try
			If UsingRealDMD Then
				UnInitPinDMD()
				UsingRealDMD = False
			End If
		End If
	End Sub
	Public Sub StopVideo()
		'Static LastStartTick As Integer
		If Vid Is Nothing Then Return
		If Vid.VideoEngine Is Nothing Then Return

		If Not ThreadVideo Is Nothing And VideoLastStartTick <> 0 And Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then

			If Environment.TickCount - VideoLastStartTick < 16 Then
				For i As Integer = 1 To 8
					If ThreadVideo.IsAlive Then
						Exit For
					End If
					Threading.Thread.Sleep(2)

				Next
			End If
			DoExitThread = True
			If ThreadVideo.IsAlive Then

				For i As Integer = 0 To 10000
					Threading.Thread.Sleep(1)
					If Not ThreadVideo.IsAlive Then
						Exit For
					End If

				Next

			End If
			Try
				Vid.StopVideo()
			Catch ex As Exception

			End Try
		End If

		'If Vid Is Nothing Then Return


		Return

	End Sub
	Public Function VideoIsComplete() As Boolean


		'If Vid Is Nothing Then Return True
		'If Vid.VideoEngine Is Nothing Then
		'	Return True

		'End If
		If ThreadVideo Is Nothing Then
			Return True
		Else
			If Not ThreadVideo.IsAlive Then
				Return True

			End If
		End If

		'If VideoEngine Is Nothing Then
		'	Return False

		'End If
		'If Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Graph_Stopped1 Or Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Graph_Stopped2 Then
		'	Return False

		'End If
		If VideohasLooped Then
			VideohasLooped = False
			Return True
		End If

		Return False


	End Function
	Public Function PlayVideo(Filename As String, Audio As Boolean, LoopVideo As Boolean, DestRect As Rectangle, MaintainAspect As Boolean) As Boolean
		'Static LastStartTick As Integer
		If Vid Is Nothing Then Return False
		If Not Vid.VideoEngine Is Nothing Then
			'If Not ThreadVideo Is Nothing And VideoLastStartTick <> 0 And Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then
			If Not ThreadVideo Is Nothing Then

				If Environment.TickCount - VideoLastStartTick < 16 Then
					For i As Integer = 1 To 8
						If ThreadVideo.IsAlive Then
							Exit For
						End If
						Threading.Thread.Sleep(2)

					Next
				End If
				DoExitThread = True
				If ThreadVideo.IsAlive Then

					For i As Integer = 0 To 10000
						Threading.Thread.Sleep(2)
						If Not ThreadVideo.IsAlive Then
							Exit For
						End If

					Next

				End If
			End If
		End If

		If Not ThreadVideo Is Nothing Then
			If ThreadVideo.IsAlive Then
				Return False
			End If
		End If


		'If Vid.VideoEngine Is Nothing Then
		'	Vid.VideoComplete = New 

		'End If

		VideoLastStartTick = 0

		Dim res As Boolean = Vid.OpenVideo(Filename, Audio)
		If Not res Then Return False
		If Not Vid.StartVideo Then
			Try
				Vid.Dispose(True)
			Catch ex As Exception

			End Try
			Return False
		End If
		DoExitThread = False
		VideohasLooped = False
		RestartVideoFlag = False
		VideoLoop = LoopVideo
		VideoDestRect = DestRect
		VideoMaintainAspect = MaintainAspect
		'VideoAutomaticRender = AutomaticRender
		'Do While Not DoExitThread
		'    Dim tstart As Integer = Environment.TickCount
		'    Vid.RenderFrame()
		'    Native.Clear(Buffer, UBound(Buffer), 0)
		'    'MsgBox(Vid.VidSize.width.ToString)
		'    Conv.Draw(Vid.Buffer, Buffer, Vid.VidSize.width, Vid.VidSize.height, New Rectangle(-300, -200, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), 12)
		'    InteralRender()

		'    Dim tdif As Integer = Environment.TickCount - tstart
		'    If tdif < 14 Then
		'        Thread.Sleep(15 - tdif)
		'    End If
		'    Application.DoEvents()
		'Loop

		ThreadVideo = New Thread(AddressOf Thread_Video)
		ThreadVideo.IsBackground = True
		ThreadVideo.Priority = ThreadPriority.Lowest
		ThreadVideo.Start()


		VideoLastStartTick = Environment.TickCount

		Return True

	End Function
	Public Function RePlayVideo() As Boolean
		If Vid Is Nothing Then Return False
		'If Not Vid.VideoEngine Is Nothing Then
		'If Not ThreadVideo Is Nothing Then
		'	If ThreadVideo.IsAlive Then
		'		Return False

		'	End If
		'End If

		'DoExitThread = False
		VideohasLooped = False
		RestartVideoFlag = True
		'If Not Vid.StartVideo() Then Return False

		'ThreadVideo = New Thread(AddressOf Thread_Video)
		'ThreadVideo.IsBackground = True
		'ThreadVideo.Priority = ThreadPriority.Lowest
		'ThreadVideo.Start()


		'VideoLastStartTick = Environment.TickCount
		'Threading.Thread.Sleep(3)
		Return True
		'ThreadVideo = New Thread(AddressOf Thread_Video)
		'ThreadVideo.IsBackground = True
		'ThreadVideo.Priority = ThreadPriority.Lowest
		'ThreadVideo.Start()
		'Threading.Thread.Sleep(5)

		'End If
	End Function




	Public Sub DrawVideoFrame()
		If Not Vid Is Nothing Then
			If Not Vid.Buffer Is Nothing Then
				If UBound(Vid.Buffer) > 2 Then
					If Not Vid.VideoEngine Is Nothing Then
						If Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then

							Dim DesWidth As Integer = VideoDestRect.Width
							Dim DesHeight As Integer = VideoDestRect.Height
							'If Vid.VidSize.height > Vid.VidSize.width Then
							If VideoMaintainAspect Then
								If CInt(Vid.VidSize.height * (DesWidth / Vid.VidSize.width)) >= DesHeight Then
									DesHeight = CInt(Vid.VidSize.height * (DesWidth / Vid.VidSize.width))
								Else
									DesWidth = CInt(Vid.VidSize.width * (DesHeight / Vid.VidSize.height))
								End If
							End If
							Vid.GrabFrame()

							'End If
							If _RGB Then
								Native.DrawVideo(Vid.Buffer24Bit, Buffer24, Vid.VidSize.width, Vid.VidSize.height, 128, 32, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, True, 1, 1)
							Else
								Native.DrawVideo(Vid.Buffer24Bit, Buffer8, Vid.VidSize.width, Vid.VidSize.height, 128, 32, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, True, 1, 1)
							End If

							'Native.Draw(Vid.Buffer, Buffer, Vid.VidSize.width, Vid.VidSize.height, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, False, 1, 1)

						End If

					End If

				End If
			End If
		End If
	End Sub
	Public ReadOnly Property VideoWidth As Integer
		Get
			If Not Vid Is Nothing Then
				If Not Vid.VideoEngine Is Nothing Then
					Return Vid.VidSize.width
				End If
			End If
			Return 0

		End Get
	End Property

	Public ReadOnly Property VideoHeight As Integer
		Get
			If Not Vid Is Nothing Then
				If Not Vid.VideoEngine Is Nothing Then
					Return Vid.VidSize.height
				End If
			End If
			Return 0

		End Get
	End Property

	Public Sub DrawVideoFrame(VideoDestRect As Rectangle)
		If Not Vid Is Nothing Then
			If Not Vid.Buffer Is Nothing Then
				If UBound(Vid.Buffer) > 2 Then
					If Not Vid.VideoEngine Is Nothing Then
						If Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then

							Dim DesWidth As Integer = VideoDestRect.Width
							Dim DesHeight As Integer = VideoDestRect.Height
							'If Vid.VidSize.height > Vid.VidSize.width Then
							If VideoMaintainAspect Then
								If CInt(Vid.VidSize.height * (DesWidth / Vid.VidSize.width)) >= DesHeight Then
									DesHeight = CInt(Vid.VidSize.height * (DesWidth / Vid.VidSize.width))
								Else
									DesWidth = CInt(Vid.VidSize.width * (DesHeight / Vid.VidSize.height))
								End If
							End If
							Vid.GrabFrame()

							'End If
							If _RGB Then
								Native.DrawVideo(Vid.Buffer24Bit, Buffer24, Vid.VidSize.width, Vid.VidSize.height, 128, 32, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, True, 1, 1)
							Else
								Native.DrawVideo(Vid.Buffer24Bit, Buffer8, Vid.VidSize.width, Vid.VidSize.height, 128, 32, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, True, 1, 1)
							End If

							'Native.Draw(Vid.Buffer, Buffer, Vid.VidSize.width, Vid.VidSize.height, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, False, 1, 1)

						End If

					End If

				End If
			End If
		End If
	End Sub



	Public Sub DrawVideoFrame(Surface As Surface, VideoDestRect As Rectangle)
		If Not Vid Is Nothing Then
			If Not Vid.Buffer Is Nothing Then
				If UBound(Vid.Buffer) > 2 Then
					If Not Vid.VideoEngine Is Nothing Then
						If Vid.VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then

							Dim DesWidth As Integer = VideoDestRect.Width
							Dim DesHeight As Integer = VideoDestRect.Height
							'If Vid.VidSize.height > Vid.VidSize.width Then
							If VideoMaintainAspect Then
								If CInt(Vid.VidSize.height * (DesWidth / Vid.VidSize.width)) >= DesHeight Then
									DesHeight = CInt(Vid.VidSize.height * (DesWidth / Vid.VidSize.width))
								Else
									DesWidth = CInt(Vid.VidSize.width * (DesHeight / Vid.VidSize.height))
								End If
							End If
							Vid.GrabFrame()

							'End If
							If _RGB Then
								Native.DrawVideo(Vid.Buffer24Bit, Surface.Buffer24, Vid.VidSize.width, Vid.VidSize.height, Surface.Width, Surface.Height, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, True, 1, 1)
							Else
								Native.DrawVideo(Vid.Buffer24Bit, Surface.Buffer8, Vid.VidSize.width, Vid.VidSize.height, Surface.Width, Surface.Height, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, True, 1, 1)
							End If

							'Native.Draw(Vid.Buffer, Buffer, Vid.VidSize.width, Vid.VidSize.height, New Rectangle(0, 0, Vid.VidSize.width, Vid.VidSize.height), New Rectangle(VideoDestRect.X, VideoDestRect.Y, DesWidth, DesHeight), 15, False, False, 1, 1)

						End If

					End If

				End If
			End If
		End If
	End Sub





	Private Sub Thread_Video()

		Do While Not DoExitThread


			If Not VideoLoop And VideohasLooped Then
				If RestartVideoFlag Then
					RestartVideoFlag = False
					VideohasLooped = False
					If Not Vid.StartVideo() Then Return
				End If
			Else
				If RestartVideoFlag Then
					RestartVideoFlag = False
					VideohasLooped = False
					If Not Vid.StartVideo() Then Return
				Else
					If Vid.VideoComplete Then
						If Not VideoLoop Then
							'Vid.Dispose(True)
							'Return
							If RestartVideoFlag Then
								RestartVideoFlag = False
								VideohasLooped = False
								If Not Vid.StartVideo() Then Return
							Else
								VideohasLooped = True
							End If

						Else
							If Not Vid.StartVideo() Then Return
							VideohasLooped = True

						End If

					End If
				End If
			End If
			For i As Integer = 0 To 34 Step 2
				Threading.Thread.Sleep(2)
				If DoExitThread Then Return
			Next



		Loop
	End Sub

	Friend Sub ProcessTransitions()
		Dim Ratio As Double = 1
		If _TransitionRunning Then
			Dim RatioInUse1 As Double = 0
			Dim RatioInUse2 As Double = 0

			Dim Diver As Double = 0

			Select Case _Transition

				Case AnimationType.ScrollOffLeft, AnimationType.ScrollOnRight, AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft
					RatioInUse1 = 128
					Diver = 128 * 2
				Case AnimationType.ScrollOffUp, AnimationType.ScrollOnDown, AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
					Diver = 32 * 2
					RatioInUse1 = 32
			End Select
			Dim Diver2 As Double = 0
			Select Case _Transition2

				Case AnimationType.ScrollOffLeft, AnimationType.ScrollOnRight, AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft
					Diver2 = 128 * 2
					RatioInUse2 = 128
				Case AnimationType.ScrollOffUp, AnimationType.ScrollOnDown, AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
					Diver2 = 32 * 2
					RatioInUse2 = 32
			End Select
			If Diver2 > Diver Then
				Diver = Diver2
			End If
			If Diver = 0 Then
				Diver = 256
			End If

			If _TransitionWaitPosition = 0 OrElse _TransitionWaitPosition = -255 Then
				Select Case _Transition
					Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
						_TransmitionPosition += ((15 / 24) * (_TransitionSpeed)) * ((24 / Diver))
					Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
						_TransmitionPosition += ((1 / 24) * (_TransitionSpeed)) * ((24 / Diver))
					Case Else
						_TransmitionPosition += _TransitionSpeed / 2
				End Select
				Select Case _Transition2
					Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
						_TransmitionPosition2 += ((15 / 24) * (_TransitionSpeed)) * ((24 / Diver))
					Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
						_TransmitionPosition2 += ((1 / 24) * (_TransitionSpeed)) * ((24 / Diver))
					Case Is = Device.AnimationType.None
					Case Else
						Ratio = 1
						If RatioInUse1 <> 0 Then
							Ratio = RatioInUse2 / RatioInUse1
						End If
						_TransmitionPosition2 += (_TransitionSpeed / 2) * Ratio
				End Select


			End If



		End If

		'Dim DoLoop As Boolean = True
		'Dim ItemsToRemove As New ArrayList
		Dim ItemsToAdd As New ArrayList

		'Do While DoLoop


		For i As Integer = 0 To SurfaceTransitions.Count - 1

			Dim sa As Device.SurfaceAnimation = Nothing
			SyncLock SurfaceTransitions
				sa = CType(SurfaceTransitions(i), Device.SurfaceAnimation)
			End SyncLock

			Dim w As Integer = sa.DesRect.Width + sa.DesRect.X
			If w < 128 Then
				w = 128
			End If
			Dim h As Integer = sa.DesRect.Height + sa.DesRect.Y
			If h < 32 Then
				h = 32
			End If

			Select Case sa.TransitionType1
				Case Is = Device.AnimationType.ScrollOffLeft, Device.AnimationType.ScrollOnRight
					Ratio = 128 / w
				Case Is = Device.AnimationType.ScrollOnDown, Device.AnimationType.ScrollOffUp
					Ratio = 32 / h
				Case AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft

					w = 128
					If sa.DesRect.X < 0 Then
						'Beep()
						w += Math.Abs(sa.DesRect.X)
					End If
				Case Is = AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
					h = 32
					If sa.DesRect.Y < 0 Then
						h += Math.Abs(sa.DesRect.Y)
					End If
			End Select

			Select Case sa.TransitionType2
				Case Is = Device.AnimationType.ScrollOffLeft, Device.AnimationType.ScrollOnRight
					Ratio = 128 / w
				Case Is = Device.AnimationType.ScrollOnDown, Device.AnimationType.ScrollOffUp
					Ratio = 32 / h
				Case AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft

					w = 128
					If sa.DesRect.X < 0 Then
						w += Math.Abs(sa.DesRect.X)
					End If
				Case Is = AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
					h = 32
					If sa.DesRect.Y < 0 Then
						h += Math.Abs(sa.DesRect.Y)
					End If
			End Select

			Ratio = 1
			Dim Diver As Double = 0
			Dim RatioInUse1 As Integer = 0
			Dim RatioInUse2 As Integer = 0
			Select Case sa.TransitionType1

				Case AnimationType.ScrollOffLeft, AnimationType.ScrollOnRight, AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft
					Diver = w * 2
					RatioInUse1 = w
				Case AnimationType.ScrollOffUp, AnimationType.ScrollOnDown, AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
					RatioInUse1 = h
					Diver = h * 2

			End Select
			Dim Diver2 As Double = 0
			Select Case sa.TransitionType2

				Case AnimationType.ScrollOffLeft, AnimationType.ScrollOnRight, AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft
					Diver2 = w * 2
					RatioInUse2 = w
				Case AnimationType.ScrollOffUp, AnimationType.ScrollOnDown, AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
					RatioInUse2 = h
					Diver2 = h * 2
			End Select
			If Diver2 > Diver Then
				Diver = Diver2
			End If
			If Diver = 0 Then
				Diver = 256
			End If
			'MsgBox(Diver.ToString)
			If sa.TransitionWaitPosition = 0 OrElse sa.TransitionWaitPosition = -255 Then
				Select Case sa.TransitionType1
					Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
						sa.TransitionPosition += ((15 / 24) * (sa.TransitionSpeed)) * ((24 / Diver))
					Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
						sa.TransitionPosition += ((1 / 24) * (sa.TransitionSpeed)) * ((24 / Diver))
					Case Else
						sa.TransitionPosition += sa.TransitionSpeed / 2
				End Select
				Select Case sa.TransitionType2
					Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
						sa.TransitionPosition2 += ((15 / 24) * (sa.TransitionSpeed)) * ((24 / Diver))
					Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
						sa.TransitionPosition2 += ((1 / 24) * (sa.TransitionSpeed)) * ((24 / Diver))
					Case Is = Device.AnimationType.None

					Case Else
						Ratio = 1
						If RatioInUse1 <> 0 Then
							Ratio = RatioInUse2 / RatioInUse1
						End If

						sa.TransitionPosition2 += (sa.TransitionSpeed / 2) * Ratio
				End Select
			End If
			Dim pos As Double = sa.TransitionPosition
			Dim Removed As Boolean = False
			Select Case sa.TransitionType1
				Case Is = Device.AnimationType.None
					If pos >= CInt(1) Then
						sa.TransitionPosition = 1
						Removed = True
					End If
				Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
					If pos >= CInt(15) Then
						sa.TransitionPosition = 15
						'ItemsToRemove.Add(i)
						Removed = True

					End If

				Case Is = Device.AnimationType.ScrollOffLeft, Device.AnimationType.ScrollOnRight
					If pos >= w Then
						'ItemsToRemove.Add(i)
						sa.TransitionPosition = w
						Removed = True

					End If



				Case Is = Device.AnimationType.ScrollOnLeft, Device.AnimationType.ScrollOffRight
					If pos >= w Then
						sa.TransitionPosition = w
						'ItemsToRemove.Add(i)
						Removed = True

					End If
				Case Is = Device.AnimationType.ScrollOffDown, Device.AnimationType.ScrollOnUp
					If pos >= h Then
						sa.TransitionPosition = h
						'ItemsToRemove.Add(i)
						Removed = True

					End If

				Case Is = Device.AnimationType.ScrollOnDown, Device.AnimationType.ScrollOffUp
					If pos >= h Then
						sa.TransitionPosition = h
						'ItemsToRemove.Add(i)
						Removed = True

					End If


				Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
					If pos >= 1 Then
						'ItemsToRemove.Add(i)
						sa.TransitionPosition = 1
						Removed = True

					End If

			End Select
			pos = sa.TransitionPosition2

			Select Case sa.TransitionType2


				'Case Is = Device.AnimationType.None
				'    If pos >= CInt(2) Then
				'        sa.TransitionPosition2 = 2
				'        Removed = True
				'End If

				Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
					If pos > CInt(15) Then
						sa.TransitionPosition2 = 15
						'MsgBox("")

						'ItemsToRemove.Add(i)
						Removed = True

					End If

				Case Is = Device.AnimationType.ScrollOffLeft, Device.AnimationType.ScrollOnRight
					If pos >= w Then
						sa.TransitionPosition2 = w
						'ItemsToRemove.Add(i)
						Removed = True

					End If



				Case Is = Device.AnimationType.ScrollOnLeft, Device.AnimationType.ScrollOffRight
					If pos >= w Then
						sa.TransitionPosition2 = w
						'ItemsToRemove.Add(i)
						Removed = True

					End If
				Case Is = Device.AnimationType.ScrollOffDown, Device.AnimationType.ScrollOnUp
					If pos >= h Then
						sa.TransitionPosition2 = h
						'ItemsToRemove.Add(i)
						Removed = True

					End If

				Case Is = Device.AnimationType.ScrollOnDown, Device.AnimationType.ScrollOffUp
					If pos >= h Then
						sa.TransitionPosition2 = h
						'ItemsToRemove.Add(i)
						Removed = True

					End If

				Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
					If pos > 1 Then
						sa.TransitionPosition2 = 1
						'ItemsToRemove.Add(i)
						Removed = True

					End If

			End Select
			If Removed Then
				If sa.TransitionWaitPosition <= sa.TransitionWait AndAlso sa.TransitionWaitPosition <> -255 Then
					Removed = False
					sa.TransitionWaitPosition += 1
					If sa.TransitionWaitPosition > sa.TransitionWait Then
						sa.TransitionWaitPosition = -255
						sa.TransitionSpeed = sa.TransitionSpeedOut
						sa.TransitionPosition = 0
						sa.TransitionPosition2 = 0
						sa.TransitionType1 = sa.TransitionType1Out
						sa.TransitionType2 = sa.TransitionType2Out
					End If
				End If
			End If
			If Removed Then
				If Not sa.Font Is Nothing Or sa.text <> "" Then
					sa.Surface.Dispose()
					sa.Surface = Nothing

				End If
			End If
			If Not Removed Then ItemsToAdd.Add(sa)

		Next
		'If ItemsToRemove.Count > 0 Then

		'    Dim RArr As New ArrayList
		'    For Each i As Integer In ItemsToRemove
		'        Dim Found As Boolean = False
		'        For Each i2 As Integer In RArr
		'            If i2 = i Then
		'                Found = True
		'                Exit For
		'            End If
		'        Next
		'        If Not Found Then
		'            RArr.Add(Microsoft.VisualBasic.Right("0000000000000000" + i.ToString, 8))
		'        End If
		'    Next
		'    RArr.Sort()
		'    Dim remcount As Integer = 0
		'    For Each s2 As String In RArr
		'        Dim i As Integer = CInt(s2)
		'        SurfaceTransitions.RemoveAt(i - remcount)
		'        remcount += 1
		'    Next
		'End If
		'Loop
		SyncLock SurfaceTransitions
			SurfaceTransitions.Clear()
			For Each sa As SurfaceAnimation In ItemsToAdd
				SurfaceTransitions.Add(sa)
			Next
		End SyncLock

		If _TransitionRunning Then
			Select Case _Transition
				Case Is = Device.AnimationType.None
					If _TransmitionPosition > CInt(1) Then
						_TransmitionPosition = CInt(1)
						_TransitionRunning = False
					End If
				Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
					If _TransmitionPosition > CInt(15) Then
						_TransmitionPosition = CInt(15)
						_TransitionRunning = False


					End If



				Case Is = Device.AnimationType.ScrollOnLeft, Device.AnimationType.ScrollOnRight, Device.AnimationType.ScrollOffLeft, Device.AnimationType.ScrollOffRight
					If _TransmitionPosition >= 128 Then
						_TransmitionPosition = 128
						_TransitionRunning = False


					End If
				Case Is = Device.AnimationType.ScrollOffUp, Device.AnimationType.ScrollOffDown, Device.AnimationType.ScrollOnUp, Device.AnimationType.ScrollOnDown
					If _TransmitionPosition >= 32 Then
						_TransmitionPosition = 32
						_TransitionRunning = False


					End If
				Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
					If _TransmitionPosition > 1 Then
						_TransmitionPosition = 1
						_TransitionRunning = False


					End If

			End Select

			Select Case _Transition2
				'Case Is = Device.AnimationType.None
				'    If _TransmitionPosition2 > CInt(2) Then
				'        _TransmitionPosition2 = 2
				'        _TransitionRunning = False
				'End If
				Case Is = Device.AnimationType.FadeIn, Device.AnimationType.FadeOut, AnimationType.FillFadeIn, AnimationType.FillFadeOut
					If _TransmitionPosition2 > CInt(15) Then
						_TransmitionPosition2 = 15
						_TransitionRunning = False
					End If
				Case Is = Device.AnimationType.ScrollOnLeft, Device.AnimationType.ScrollOnRight, Device.AnimationType.ScrollOffLeft, Device.AnimationType.ScrollOffRight
					If _TransmitionPosition2 >= 128 Then
						_TransmitionPosition2 = 128
						_TransitionRunning = False


					End If
				Case Is = Device.AnimationType.ScrollOffUp, Device.AnimationType.ScrollOffDown, Device.AnimationType.ScrollOnUp, Device.AnimationType.ScrollOnDown
					If _TransmitionPosition2 >= 32 Then
						_TransmitionPosition2 = 32
						_TransitionRunning = False


					End If
				Case Is = Device.AnimationType.ZoomIn, Device.AnimationType.ZoomOut
					If _TransmitionPosition2 > 1 Then
						_TransmitionPosition2 = 1
						_TransitionRunning = False


					End If

			End Select


			If Not _TransitionRunning Then
				If _TransitionWaitPosition <= _TransitionWait AndAlso _TransitionWaitPosition <> -255 Then
					_TransitionRunning = True
					_TransitionWaitPosition += 1
					If _TransitionWaitPosition > _TransitionWait Then
						If _TransitionOut <> AnimationType.None Then
							_TransitionWaitPosition = -255
							_Transition = _TransitionOut
							'MsgBox(_Transition.ToString)
							_TransmitionPosition = 0
							_TransmitionPosition2 = 0
							_Transition2 = _Transition2Out
							_TransitionSpeed = _TransitionOutSpeed
						Else
							_TransitionRunning = False
						End If
					End If
				Else
				End If
			End If
		End If
		If SurfaceTransitions.Count < 1 Then
			_SurfaceState = PlayState.Ready
		End If
		If Not _TransitionRunning Then
			_State = Device.PlayState.Ready
		Else
			_State = Device.PlayState.Playing
			'If AutoRender Then
			'    NeedToRender = True
			'End If
			'HasStuffToDraw = True
		End If

		'Beep()
		SyncLock SurfaceTransitions
			For Each sa As SurfaceAnimation In SurfaceTransitions

				Dim r As Rectangle = sa.DesRect
				Dim w As Integer = sa.DesRect.Width + sa.DesRect.X
				If w < 128 Then
					w = 128
				End If
				Dim h As Integer = sa.DesRect.Height + sa.DesRect.Y
				If h < 32 Then
					h = 32
				End If
				Dim PlusNegY As Integer = 0
				If r.Y < 0 Then
					PlusNegY = Math.Abs(r.Y)
				End If
				Dim PlusNegx As Integer = 0
				If r.X < 0 Then
					PlusNegx = Math.Abs(r.X)
				End If
				'Dim w2 As Integer = sa.Surface.Width - 128
				'If w2 < 128 Then
				'    w2 = 0
				'End If
				'Dim h2 As Integer = sa.Surface.Height - 32
				'If h2 < 32 Then
				'    h2 = 0
				'End If

				Select Case sa.TransitionType1
					Case Is = AnimationType.ScrollOffDown, AnimationType.ScrollOnUp
						h = 32
					Case Is = AnimationType.ScrollOffRight, AnimationType.ScrollOnLeft
						w = 32
				End Select
				'pos = sa.TransitionPosition2
				Dim Brightness As Integer = 15
				Dim Scale As Double = 1
				Dim pos As Double = sa.TransitionPosition2
				If Not sa.TransitionType2 = AnimationType.None Then
					Select Case sa.TransitionType2
						Case Is = AnimationType.FadeIn, AnimationType.FillFadeIn
							Brightness = CInt(pos)
						Case Is = AnimationType.FadeOut, AnimationType.FillFadeOut
							Brightness = 15 - CInt(pos)
						Case Is = AnimationType.ScrollOffLeft
							r = New Rectangle((r.X) - CInt(pos), r.Y, r.Width, r.Height)
						Case Is = AnimationType.ScrollOffRight
							r = New Rectangle(r.X + CInt(pos), r.Y, r.Width, r.Height)
						Case Is = AnimationType.ScrollOnLeft
							r = New Rectangle((r.X + (128 + PlusNegx)) - CInt(pos), r.Y, r.Width, r.Height)
						Case Is = AnimationType.ScrollOnRight
							r = New Rectangle((r.X - w) + CInt(pos), r.Y, r.Width, r.Height)
						Case Is = AnimationType.ScrollOffUp
							r = New Rectangle(r.X, (r.Y) - CInt(pos), r.Width, r.Height)
						Case Is = AnimationType.ScrollOffDown
							r = New Rectangle(r.X, r.Y + CInt(pos), r.Width, r.Height)
						Case Is = AnimationType.ScrollOnUp
							r = New Rectangle(r.X, (r.Y + (32 + PlusNegY)) - CInt(pos), r.Width, r.Height)
						Case Is = AnimationType.ScrollOnDown
							r = New Rectangle(r.X, (r.Y - h) + CInt(pos), r.Width, r.Height)
						Case Is = AnimationType.ZoomIn
							Scale = pos
						Case Is = AnimationType.ZoomOut
							Scale = 1 + pos
					End Select
				End If
				pos = sa.TransitionPosition

				If _RGB Then





					Select Case sa.TransitionType1
						Case Is = AnimationType.None
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.FadeIn
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.FillFadeIn
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
							If r.Width * r.Height > UBound(BufferSolidVariable24) Then
								ReDim BufferSolidVariable24(r.Width * r.Height)
								Native.Clear(BufferSolidVariable24, UBound(BufferSolidVariable24), WhiteARGB)
							End If

							Native.Draw(BufferSolidVariable24, Buffer24, r.Width, r.Height, New Rectangle(0, 0, r.Width, r.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.FadeOut
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), 15 - CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.FillFadeOut
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
							If r.Width * r.Height > UBound(BufferSolidVariable24) Then
								ReDim BufferSolidVariable24(r.Width * r.Height)
								Native.Clear(BufferSolidVariable24, UBound(BufferSolidVariable24), WhiteARGB)
							End If

							Native.Draw(BufferSolidVariable24, Buffer24, r.Width, r.Height, New Rectangle(0, 0, r.Width, r.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), 15 - CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffLeft
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle((r.X) - CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffRight
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X + CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnLeft
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle((r.X + (128 + PlusNegx)) - CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnRight
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle((r.X - w) + CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffUp
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, (r.Y) - CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffDown
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y + CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnUp
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, (r.Y + (32 + PlusNegY)) - CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnDown
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, (r.Y - h) + CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ZoomIn
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, pos)
						Case Is = AnimationType.ZoomOut
							Native.Draw(sa.Surface.Buffer24, Buffer24, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, 1 + pos)
					End Select



				Else
					Select Case sa.TransitionType1
						Case Is = AnimationType.None
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.FadeIn
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.FillFadeIn
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
							If r.Width * r.Height > UBound(BufferSolidVariable8) Then
								ReDim BufferSolidVariable8(r.Width * r.Height)
								Native.Clear(BufferSolidVariable8, UBound(BufferSolidVariable8), 15)
							End If

							Native.Draw(BufferSolidVariable8, Buffer8, r.Width, r.Height, New Rectangle(0, 0, r.Width, r.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.FadeOut
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), 15 - CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.FillFadeOut
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
							If r.Width * r.Height > UBound(BufferSolidVariable8) Then
								ReDim BufferSolidVariable8(r.Width * r.Height)
								Native.Clear(BufferSolidVariable8, UBound(BufferSolidVariable8), 15)
							End If

							Native.Draw(BufferSolidVariable8, Buffer8, r.Width, r.Height, New Rectangle(0, 0, r.Width, r.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), 15 - CInt(pos), False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffLeft
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle((r.X) - CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffRight
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X + CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnLeft
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle((r.X + (128 + PlusNegx)) - CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnRight
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle((r.X - w) + CInt(pos), r.Y, r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffUp
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, (r.Y) - CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOffDown
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y + CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnUp
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, (r.Y + (32 + PlusNegY)) - CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ScrollOnDown
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, (r.Y - h) + CInt(pos), r.Width, r.Height), Brightness, False, False, 1, Scale)
						Case Is = AnimationType.ZoomIn
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, pos)
						Case Is = AnimationType.ZoomOut
							Native.Draw(sa.Surface.Buffer8, Buffer8, sa.Surface.Width, sa.Surface.Height, New Rectangle(0, 0, sa.Surface.Width, sa.Surface.Height), New Rectangle(r.X, r.Y, r.Width, r.Height), Brightness, False, False, 1, 1 + pos)
					End Select
				End If


			Next
		End SyncLock


		If _TransitionRunning Then

			If _RGB Then







				Native.Clear(FinalBuffer24, UBound(FinalBuffer24), BlackARGB)
				Select Case _Transition
					Case Is = AnimationType.None
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.FadeIn
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.FillFadeIn
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
						Native.Draw(BufferSolid24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.FillFadeOut
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
						Native.Draw(BufferSolid24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.FadeOut
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.ScrollOffLeft
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0 - CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOffRight
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnLeft
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(128 - CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnRight
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(-128 + CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOffUp
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0 - CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOffDown
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnUp
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 32 - CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnDown
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, -32 + CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ZoomIn
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, _TransmitionPosition)
					Case Is = AnimationType.ZoomOut
						Native.Draw(Buffer24, FinalBuffer24, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1 + _TransmitionPosition)
				End Select
				If _Transition2 <> AnimationType.None Then
					Native.Clear(FinalBuffer224, UBound(FinalBuffer224), BlackARGB)
					Select Case _Transition2
						Case Is = AnimationType.None
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.FadeIn
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition2), False, False, 1, 1)
						Case Is = AnimationType.FadeOut
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition2), False, False, 1, 1)
						Case Is = AnimationType.FillFadeIn
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
							Native.Draw(BufferSolid24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition), False, False, 1, 1)
						Case Is = AnimationType.FillFadeOut
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
							Native.Draw(BufferSolid24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition), False, False, 1, 1)
						Case Is = AnimationType.ScrollOffLeft
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0 - CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOffRight
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnLeft
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(128 - CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnRight
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(-128 + CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOffUp
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0 - CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOffDown
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnUp
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 32 - CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnDown
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, -32 + CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ZoomIn
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, _TransmitionPosition2)
						Case Is = AnimationType.ZoomOut
							Native.Draw(FinalBuffer24, FinalBuffer224, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1 + _TransmitionPosition2)
					End Select
					'   Native.Render(bmp, FinalBuffer2)
				Else
					'    Native.Render(bmp, FinalBuffer)
				End If




			Else


				Native.Clear(FinalBuffer8, UBound(FinalBuffer8), 0)
				Select Case _Transition
					Case Is = AnimationType.None
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.FadeIn
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.FillFadeIn
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
						Native.Draw(BufferSolid8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.FillFadeOut
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
						Native.Draw(BufferSolid8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.FadeOut
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition), False, False, 1, 1)
					Case Is = AnimationType.ScrollOffLeft
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0 - CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOffRight
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnLeft
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(128 - CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnRight
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(-128 + CInt(_TransmitionPosition), 0, 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOffUp
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0 - CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOffDown
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnUp
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 32 - CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ScrollOnDown
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, -32 + CInt(_TransmitionPosition), 128, 32), 15, False, False, 1, 1)
					Case Is = AnimationType.ZoomIn
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, _TransmitionPosition)
					Case Is = AnimationType.ZoomOut
						Native.Draw(Buffer8, FinalBuffer8, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1 + _TransmitionPosition)
				End Select
				If _Transition2 <> AnimationType.None Then
					Native.Clear(FinalBuffer28, UBound(FinalBuffer28), 0)
					Select Case _Transition2
						Case Is = AnimationType.None
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.FadeIn
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition2), False, False, 1, 1)
						Case Is = AnimationType.FadeOut
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition2), False, False, 1, 1)
						Case Is = AnimationType.FillFadeIn
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
							Native.Draw(BufferSolid8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), CInt(_TransmitionPosition), False, False, 1, 1)
						Case Is = AnimationType.FillFadeOut
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
							Native.Draw(BufferSolid8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15 - CInt(_TransmitionPosition), False, False, 1, 1)
						Case Is = AnimationType.ScrollOffLeft
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0 - CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOffRight
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnLeft
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(128 - CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnRight
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(-128 + CInt(_TransmitionPosition2), 0, 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOffUp
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0 - CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOffDown
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnUp
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 32 - CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ScrollOnDown
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, -32 + CInt(_TransmitionPosition2), 128, 32), 15, False, False, 1, 1)
						Case Is = AnimationType.ZoomIn
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, _TransmitionPosition2)
						Case Is = AnimationType.ZoomOut
							Native.Draw(FinalBuffer8, FinalBuffer28, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1 + _TransmitionPosition2)
					End Select
					'   Native.Render(bmp, FinalBuffer2)
				Else
					'    Native.Render(bmp, FinalBuffer)
				End If


			End If


		Else

			'    Native.Render(bmp, Buffer)
		End If


	End Sub

	Public Property ManualRender As Boolean
		Get
			Return _ManualRender
		End Get
		Set(value As Boolean)
			_ManualRender = value
			If Not timer Is Nothing Then
				If Not value Then
					If Not timer.IsRunning Then

						timer.Start()
					End If
				Else
					If timer.IsRunning Then
						timer.Stop()
					End If
				End If
			End If
		End Set
	End Property




End Class
