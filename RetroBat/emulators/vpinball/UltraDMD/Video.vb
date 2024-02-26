''A wrapper class containing functions for the rendering of a MultiMedia stream (AVI's, MNG's, MPEG's...etc) to a DirectDraw Surface
'Author: Clinton Mclean 15/12/2004

'Option Explicit On 
'Option Strict Off

'Imports System
'Imports System.Object
'Imports System.Security
Imports System.Runtime.InteropServices
Friend Class Video
    Public Enum _LastFileOpened
        None = 0
        Mng = 1
        Other = 2

    End Enum

    Public Buffer24Bit() As Byte
    Public Buffer() As Byte
    Friend VideoEngine As XDMDNative
    Dim pinnedArray As GCHandle
    Dim pointer As IntPtr
    Private CatchCount As Integer
    Private LastFileOpened As _LastFileOpened
    Private LastFilename As String
    Private LastSound As Boolean
    ' public  ThisHDC As IntPtr
    '  public  GrabImage As System.Drawing.Image = Nothing
    Public Structure RECT
        Dim x As Integer
        Dim y As Integer
        Dim width As Integer
        Dim height As Integer
    End Structure

    ' public  LastFileOpenedNotMNG As Boolean
    Public VidSize As RECT
    Public Pitch As Integer














































































    Public Function VideoComplete() As Boolean

        '()
        ' Return 0
        Static LastWasComplete As Boolean
		Static StaticLastFile As String
		If VideoEngine Is Nothing Then
			Return False

		End If
		If VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Graph_Stopped1 Or VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Graph_Stopped2 Then
			Return False

		End If
		Try


            If VideoEngine.GetCurrentPosition >= VideoEngine.GetDuration - 2 Then

                VideoEngine.Stop()

                LastWasComplete = True
                StaticLastFile = LastFilename

                Return True


            Else
                If VideoEngine.GetCurrentPosition <> 0 Then
                    LastWasComplete = False
                End If


            End If
        Catch
            LastWasComplete = False

        End Try
        If StaticLastFile <> LastFilename Then
            LastWasComplete = False
        End If
        StaticLastFile = LastFilename
        Return False

    End Function


    Public Function Seek(ByVal time As Long) As Integer

        VideoEngine.Seek(time)
        '("SEEK")
    End Function

    Public Function OpenVideo(ByVal fileName As String, ByVal sound As Boolean) As Boolean

        Try
            If Not pointer = IntPtr.Zero Then
                pinnedArray.Free()
                pointer = IntPtr.Zero
            End If
            'CatchCount += 1
            'If CatchCount = 10 Then
            '    CatchCount = 0
            'If Not md.VideoEngine Is Nothing Then
            '    'Try
            '    '   VideoEngine.Stop()
            '    'Catch

            '    ''End Try
            '    'Try
            '    VideoEngine.InternalCleanup()
            '    ' Catch

            '    'End Try
            '    'Try
            '    System.Runtime.InteropServices.Marshal.FinalReleaseComObject(VideoEngine)
            '    'Catch

            '    'End Try
            '    '("")
            '    md.VideoEngine = Nothing
            'End If

            If VideoEngine Is Nothing Then
                VideoEngine = New XDMDNative

                'VideoEngine.UseFfdshow = 0
                ' ''  VideoEngine.Parent = PicHandle.ToInt32
                'VideoEngine.UseSampleGrabber = 1
                'VideoEngine.UseNullRenderer = 1
                ' Else
                'VideoEngine.Stop()
                'VideoEngine.InternalCleanup()

                '  Return 0
            End If
            'If Not md.VideoEngine Is Nothing Then
            '    'Try
            '    VideoEngine.Stop()
            '    'Catch

            '    ''End Try
            '    'Try
            '    VideoEngine.InternalCleanup()
            '    ' Catch

            '    'End Try
            '    'Try
            '    System.Runtime.InteropServices.Marshal.ReleaseComObject(VideoEngine)
            '    'Catch

            '    'End Try
            '    md.VideoEngine = Nothing
            'End If
            '    End If
            Dim AudioOn As Boolean
            If sound Then
                'VideoEngine.AudioOn = 1
                AudioOn = True
            Else
                AudioOn = False
                'VideoEngine.AudioOn = 0
            End If
            If LCase(Microsoft.VisualBasic.Right(fileName, 3)) = "vob" Then
                '    VideoEngine.AudioOn = 0
                AudioOn = False
            End If
            'If Not GrabImage Is Nothing Then
            '    GrabImage.Dispose()
            'End If
            '(fileName)
            ' if microsoft.VisualBasic.Right(
            '("a1")
            Dim res As Boolean = False
            Select Case Microsoft.VisualBasic.Right(LCase(fileName), 3)
                Case Is = "wmv"
                    res = VideoEngine.Open24bit(fileName, True, AudioOn)


                Case Else
                    res = VideoEngine.Open24bit(fileName, False, AudioOn)
            End Select


            If Not res Then

                Dispose(True)
                LastFileOpened = _LastFileOpened.None
                Return False
            End If

            If InStr(LCase(fileName), "http:/") = 1 Then
                VideoEngine.Play()
                Threading.Thread.Sleep(15000)
            End If

            '("2")
            '  VideoEngine.Play()
            ' System.Threading.Thread.Sleep(6000)
            'VideoEngine.GrabSample()
            '("1")
            ' GrabImage = System.Drawing.Image.FromHbitmap(New IntPtr(VideoEngine.HBitmap))

            'Try
            'VideoEngine.PlayWait()
            VideoEngine.GrabSample()
            'Catch
            '    ' Sleep(200)
            '    VideoEngine.GrabSample()
            'End Try

            '("2")
            'Pitch = VideoEngine.VideoPitch

            VidSize.x = 0
            VidSize.y = 0
            VidSize.width = VideoEngine.VideoWidth
            VidSize.height = VideoEngine.VideoHeight
            'GrabImage.Dispose()
            'GrabImage = Nothing
            '("")

            If VidSize.width < 1 OrElse VidSize.height < 1 Then

                Dispose(True)

                Return False
            End If
            LastFilename = fileName
            '(VideoEngine.VideoWidth.ToString)
            LastFileOpened = _LastFileOpened.Other
            ReDim Buffer24Bit((VidSize.width * 3) * (VidSize.height))
            ReDim Buffer(VidSize.width * VidSize.height)
            pinnedArray = GCHandle.Alloc(Buffer24Bit, GCHandleType.Pinned)

            pointer = pinnedArray.AddrOfPinnedObject()
            'Functions.PlayVideo()
            'System.Threading.Thread.Sleep(100)
            'CatchCount += 1
            'If CatchCount < 1500 Then
            '    Functions.OpenVideo(fileName, hdc, sound)

            'End If
            Return True
        Catch ex As Exception
excp:
            'msg(ex.Message)
            '     CatchCount += 1

            Dispose(True)
            'If CatchCount < 3 Then Return OpenVideo(fileName, hdc, sound)
        End Try
        LastFileOpened = _LastFileOpened.None
        Return False
    End Function
    Public Sub Dispose(ByVal Recreate As Boolean)
        LastFilename = ""
        If Not VideoEngine Is Nothing Then
            Try
                VideoEngine.Stop()
            Catch

            End Try
            Try
                VideoEngine.InternalCleanup()
            Catch

            End Try
            Try
                VideoEngine.Dispose()
            Catch

            End Try
            Try
                pinnedArray.Free()
            Catch ex As Exception

            End Try
            'Try
            '    System.Runtime.InteropServices.Marshal.ReleaseComObject(VideoEngine)
            'Catch

            'End Try
            '(fileName)
            VideoEngine = Nothing
        End If
        If Recreate Then
            VideoEngine = New XDMDNative
            'VideoEngine.UseFfdshow = 0
            ' ''  VideoEngine.Parent = PicHandle.ToInt32
            'VideoEngine.UseSampleGrabber = 1
            'VideoEngine.UseNullRenderer = 1
        End If

    End Sub
    'public  Sub DisposeWithoutStop_()
    '    If Not VideoEngine Is Nothing Then

    '        Try
    '            VideoEngine.InternalCleanup()
    '        Catch

    '        End Try
    '        'Try
    '        '    System.Runtime.InteropServices.Marshal.ReleaseComObject(VideoEngine)
    '        'Catch

    '        'End Try
    '        '(fileName)
    '        'VideoEngine = Nothing
    '    End If
    '    'VideoEngine = New NetVideoPlayer.CaptureVideoPlayer
    '    'VideoEngine.UseFfdshow = 0
    '    ' ''  VideoEngine.Parent = PicHandle.ToInt32
    '    'VideoEngine.UseSampleGrabber = 1
    '    'VideoEngine.UseNullRenderer = 1

    'End Sub
    Public Function GetVideoDuration() As Long

        '(VideoEngine.GetDuration.ToString)
        Return VideoEngine.GetDuration
        '("DUR")
    End Function
    Public Function GetVideoPosition() As Long

        '(VideoEngine.GetDuration.ToString)
        Return VideoEngine.GetCurrentPosition
        '("DUR")
    End Function

    Public Function GetVideoSize() As Drawing.Size
        Return New Drawing.Size(VideoEngine.VideoWidth, VideoEngine.VideoHeight)
        
        ' Return R

    End Function

    Public Function StartVideo() As Boolean

        Try
            VideoEngine.Play()
            '("a")
            Return True
        Catch
            Return False
        End Try

    End Function

    'public  Function StartVideoWait() As Integer
    '    If LastFileOpened = _LastFileOpened.Mng Then
    '        MngStarted = True
    '        Return Functions_.StartVideo
    '    End If
    '    Try
    '        'VideoEngine.Engine.PlayWait()
    '        '("a")
    '        Return 1
    '    Catch
    '        Return 0
    '    End Try

    'End Function




    Public Function IsPlaying() As Boolean

        If VideoEngine Is Nothing Then Return False
        Try
            If VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then
                Return True
            End If
        Catch
        End Try
        Return False
    End Function

    Public Function StopVideo() As Boolean


        Try
            If Not VideoEngine Is Nothing Then
                If VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then
                    VideoEngine.Stop()
                    'VideoEngine.InternalCleanup()
                    'VideoEngine = Nothing
                    ' GC.Collect()
                End If

                Return True
            End If
            '     Return 0
        Catch ex As Exception

            Return False
        End Try

        Return False
    End Function
    Public Function GrabFrame() As Boolean
        Static tstart As Integer
        If tstart = 0 Then tstart = Environment.TickCount
        If Environment.TickCount - tstart < 8 Then
            Return False
        End If
        'Dim h As Integer = (VidSize.height + 32) - (DesRect.Height)
        'If DesRect.Y < 0 Then
        '    h += Math.Abs(DesRect.Y)
        'End If
        'If h > VidSize.height Then
        '    h = VidSize.height
        'End If
        'MsgBox(h.ToString)
        'tstart = Environment.TickCount
        Try
            If Not VideoEngine Is Nothing Then
                If VideoEngine.State = PLAYER_STATE.PLAYER_STATE_Playing Then

                    'MsgBox(H.ToString)
                    VideoEngine.GrabSampleToMemory(pointer.ToInt32, UBound(Buffer24Bit) + 1)
                    'VideoEngine.Converto4bitGrayFlipY(VidSize.width, VidSize.height, 3, Buffer24Bit, Buffer)
                    Return True
                    'do your stuff
                    'pinnedArray.Free()
                    'MsgBox("")

                    'Marshal.UnsafeAddrOfPinnedArrayElement(Buffer24Bit, 0)
                End If
            End If
        Catch
            'MsgBox("")

        End Try


        Return False
    End Function


    Public Sub New()

    End Sub
End Class
