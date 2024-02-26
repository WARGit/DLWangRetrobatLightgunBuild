Public Class Surface
    'Public Texture As Drawing.Bitmap = Nothing
    Dim _Width As Integer
    Dim _Height As Integer
    Dim _Device As Device
    Dim _IsRGB As Boolean
    Dim _IsClearBackground As Boolean
    Public Structure RGB24
        Public R As Byte
        Public G As Byte
        Public B As Byte
    End Structure
    Friend Buffer8() As Byte
    Friend Buffer24() As Global.ARGB
    Public Sub New(Bitmap As Drawing.Bitmap, Device As XDMD.Device)

        InternalNew(Bitmap, Device)

    End Sub
    Public Sub New(Filename As String, Device As XDMD.Device)
        InternalNew(New Drawing.Bitmap(Filename), Device)
    End Sub
    Public Sub New(Width As Integer, Height As Integer, Device As XDMD.Device)
        'InternalNew(New Drawing.Bitmap(Width, Height), Device)
        _Width = Width
        _Height = Height
        _Device = Device
        If Device._RGB Then
            ReDim Buffer24(_Width * _Height)
            _Device.Native.Clear(Buffer24, UBound(Buffer24), Device.BlackARGB)
        Else
            ReDim Buffer8(_Width * _Height)
            _Device.Native.Clear(Buffer8, UBound(Buffer8), 16)
        End If

    End Sub
    Public Sub Dispose()
        'If Not Texture Is Nothing Then
        '    Texture.Dispose()
        '    Texture = Nothing
        'End If
        ReDim Buffer8(0)
        ReDim Buffer24(0)
    End Sub
    Private Sub InternalNew(Bitmap As Drawing.Bitmap, Device As XDMD.Device)
        'Texture = Bitmap
        _Width = Bitmap.Width
        _Height = Bitmap.Height
        _Device = Device
        _IsClearBackground = False
        If Device._RGB Then
            ReDim Buffer24(_Width * _Height)
            'MsgBox(Bitmap.PixelFormat.ToString)
            If InStr(Bitmap.PixelFormat.ToString, "32") > 0 Then
                _Device.Native.Converto24bitRGB(_Width, _Height, 4, Bitmap, Buffer24)
            Else
                'Dim tmpwidth As Integer = _Width
                'Do While CInt(tmpwidth / 4) <> tmpwidth / 4 And tmpwidth > 3
                '    tmpwidth -= 1
                'Loop
                _Device.Native.Converto24bitRGB(_Width, _Height, 3, Bitmap, Buffer24)
            End If

        Else
            ReDim Buffer8(_Width * _Height)
            'MsgBox(Bitmap.PixelFormat.ToString)
            If InStr(Bitmap.PixelFormat.ToString, "32") > 0 Then
                _Device.Native.Converto4bitGray(_Width, _Height, 4, Bitmap, Buffer8)
            Else
                'Dim tmpwidth As Integer = _Width
                'Do While CInt(tmpwidth / 4) <> tmpwidth / 4 And tmpwidth > 3
                '    tmpwidth -= 1
                'Loop
                _Device.Native.Converto4bitGray(_Width, _Height, 3, Bitmap, Buffer8)
            End If

        End If

        'For y As Integer = 0 To Bitmap.Height - 1
        '    For x As Integer = 0 To Bitmap.Width - 1
        '        Dim p As Drawing.Color = Bitmap.GetPixel(x, y)
        '        Dim i As Integer = 16
        '        If p.A > 0 Then
        '            If Not (p.R = 255 And p.G = 255 And p.B = 255) Then
        '                i = CInt((CInt(p.R) + CInt(p.G) + CInt(p.B)) / 48)
        '            End If

        '        End If
        '        Buffer(x + (Bitmap.Width * y)) = CByte(i)

        '    Next
        'Next

        Bitmap.Dispose()
        Bitmap = Nothing
    End Sub

    Public ReadOnly Property Width As Integer
        Get
            Return _Width
        End Get

    End Property


    Public ReadOnly Property Height As Integer
        Get
            Return _Height
        End Get

    End Property

    Public Property IsClearBackground As Boolean
        Get
            Return _IsClearBackground
        End Get
        Set(value As Boolean)
            _IsClearBackground = value
        End Set
    End Property

    Public Sub Clear()
        If _Device._RGB Then
            If _IsClearBackground Then
                _Device.Native.Clear(Buffer24, UBound(Buffer24), _Device.ALPHAARGB)
            Else
                _Device.Native.Clear(Buffer24, UBound(Buffer24), _Device.BlackARGB)
            End If
        Else
            _Device.Native.Clear(Buffer8, UBound(Buffer8), 16)
        End If

    End Sub

    Public Sub Clear8(Color As Integer)
        If Color < 0 Then
            Color = 0
        End If
        If Color > 16 Then
            Color = 16

        End If
        _Device.Native.Clear(Buffer8, UBound(Buffer8), Color)
    End Sub


    Public Sub Clear24(Color As Global.ARGB)

        _Device.Native.Clear(Buffer24, UBound(Buffer24), Color)
    End Sub








    Public Sub draw(Surface As Surface, x As Integer, y As Integer)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, x As Integer, y As Integer, Scale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, Scale)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, Scale)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, x As Integer, y As Integer, Brightness As Integer)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub

    Public Sub draw(Surface As Surface, x As Integer, y As Integer, Brightness As Integer, Scale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, Scale)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, Scale)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, x As Integer, y As Integer, Brightness As Integer, FlipX As Boolean, FlipY As Boolean)

        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, FlipX, FlipY, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, FlipX, FlipY, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, DesRect As Drawing.Rectangle)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, DesRect As Drawing.Rectangle, Scale As Double)

        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, Scale)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, Scale)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, DesRect As Drawing.Rectangle, SrcRect As Drawing.Rectangle)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, SrcRect, DesRect, 15, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, SrcRect, DesRect, 15, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub draw(Surface As Surface, DesRect As Drawing.Rectangle, SrcRect As Drawing.Rectangle, Brightness As Integer, FlipX As Boolean, FlipY As Boolean)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, SrcRect, DesRect, Brightness, FlipX, FlipY, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, SrcRect, DesRect, Brightness, FlipX, FlipY, 1, 1)
        End If

        _Device.HasStuffToDraw = True

    End Sub

    Public Sub draw(Surface As Surface, DesRect As Drawing.Rectangle, SrcRect As Drawing.Rectangle, Brightness As Integer, FlipX As Boolean, FlipY As Boolean, SrcRectScale As Double, DesRectScale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, Surface.Buffer24, _Width, _Height, Surface.Width, Surface.Height, SrcRect, DesRect, Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
        Else
            _Device.Native.Draw(Buffer8, Surface.Buffer8, _Width, _Height, Surface.Width, Surface.Height, SrcRect, DesRect, Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
        End If

        _Device.HasStuffToDraw = True
    End Sub














    Public Sub Draw(x As Integer, y As Integer)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(x As Integer, y As Integer, Scale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, Scale)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), 15, False, False, 1, Scale)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(x As Integer, y As Integer, Brightness As Integer)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub

    Public Sub Draw(x As Integer, y As Integer, Brightness As Integer, Scale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, Scale)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, False, False, 1, Scale)
        End If
        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(x As Integer, y As Integer, Brightness As Integer, FlipX As Boolean, FlipY As Boolean)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, FlipX, FlipY, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), New Drawing.Rectangle(x, y, _Width, _Height), Brightness, FlipX, FlipY, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(DesRect As Drawing.Rectangle)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(DesRect As Drawing.Rectangle, Scale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, Scale)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, New Drawing.Rectangle(0, 0, _Width, _Height), DesRect, 15, False, False, 1, Scale)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(DesRect As Drawing.Rectangle, SrcRect As Drawing.Rectangle)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, SrcRect, DesRect, 15, False, False, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, SrcRect, DesRect, 15, False, False, 1, 1)
        End If

        _Device.HasStuffToDraw = True
    End Sub
    Public Sub Draw(DesRect As Drawing.Rectangle, SrcRect As Drawing.Rectangle, Brightness As Integer, FlipX As Boolean, FlipY As Boolean)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, SrcRect, DesRect, Brightness, FlipX, FlipY, 1, 1)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, SrcRect, DesRect, Brightness, FlipX, FlipY, 1, 1)
        End If

        _Device.HasStuffToDraw = True

    End Sub

    Public Sub Draw(DesRect As Drawing.Rectangle, SrcRect As Drawing.Rectangle, Brightness As Integer, FlipX As Boolean, FlipY As Boolean, SrcRectScale As Double, DesRectScale As Double)
        If _Device._RGB Then
            _Device.Native.Draw(Buffer24, _Device.Buffer24, _Width, _Height, 128, 32, SrcRect, DesRect, Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
        Else
            _Device.Native.Draw(Buffer8, _Device.Buffer8, _Width, _Height, 128, 32, SrcRect, DesRect, Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
        End If

        _Device.HasStuffToDraw = True
    End Sub


End Class
