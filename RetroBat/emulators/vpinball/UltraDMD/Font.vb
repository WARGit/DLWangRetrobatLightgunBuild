Imports System.Drawing
Imports System.Drawing.Imaging
Public Class Font
    Private _Device As Device
    'Private _Texture As Bitmap
    Private _Font As StructFont
    Public Structure RGB24
        Public R As Byte
        Public G As Byte
        Public B As Byte
    End Structure
    'Friend Buffer(128 * 32) As Byte
    Friend Structure StructFont
        Dim CharWidth As Integer
        Dim CharHeight As Integer
        Dim CharRectangles() As Rectangle
        Dim Buffer8() As Byte
        Dim Buffer24() As Global.ARGB
        Dim Width As Integer
        Dim Height As Integer
    End Structure
    Private Structure StructChar
        Dim Buffer() As Byte
    End Structure
    Public Sub New(Filename As String, Device As Device)
        Dim _Texture As New Bitmap(Filename)
        NewFont(_Texture, Device)
    End Sub

    Public Sub New(_Texture As Bitmap, Device As Device)
        NewFont(_Texture, Device)
    End Sub
    Private Sub NewFont(_Texture As Bitmap, Device As Device)
        'Dim _Texture As Bitmap = Nothing
        _Device = Device
        '_Texture = New Bitmap(Filename)
        ReDim _Font.CharRectangles(255)
        _Font.CharHeight = _Texture.Height
        _Font.Width = _Texture.Width
        _Font.Height = _Texture.Height

        _Font.CharWidth = CInt(_Texture.Width / 58)
        For i As Integer = 0 To 255
            _Font.CharRectangles(i) = New Rectangle(0, 0, _Font.CharWidth, _Font.CharHeight)
        Next

        If Device._RGB Then
            ReDim _Font.Buffer24(_Texture.Width * _Texture.Height)
        Else
            ReDim _Font.Buffer8(_Texture.Width * _Texture.Height)

        End If



        Dim c As Integer = 0
        For i As Integer = 32 To 90
            _Font.CharRectangles(i) = New Rectangle(_Font.CharWidth * c, 0, _Font.CharWidth, _Font.CharHeight)
            c += 1
        Next
        Dim FirstPixCol As Color = _Texture.GetPixel(0, 0)
        'MsgBox(FirstPixCol.R.ToString)
        For y As Integer = 0 To _Texture.Height - 1
            For x As Integer = 0 To _Texture.Width - 1
                Dim p As Color = _Texture.GetPixel(x, y)
                Dim i As Integer = 16


                If Device._RGB Then
                    'MsgBox(p.A.ToString)
                    If p.A > 0 Then
                        If (FirstPixCol.R = 255 And FirstPixCol.G = 255 And FirstPixCol.B = 255) Then

                            If Not (p.R = 255 And p.G = 255 And p.B = 255) Then
                                _Font.Buffer24(x + (_Texture.Width * y)).A = 255
                                _Font.Buffer24(x + (_Texture.Width * y)).R = 255
                                _Font.Buffer24(x + (_Texture.Width * y)).G = 255
                                _Font.Buffer24(x + (_Texture.Width * y)).B = 255
                                'MsgBox("HERE")
                            End If



                        Else
                            _Font.Buffer24(x + (_Texture.Width * y)).A = p.A
                            _Font.Buffer24(x + (_Texture.Width * y)).R = p.R
                            _Font.Buffer24(x + (_Texture.Width * y)).G = p.G
                            _Font.Buffer24(x + (_Texture.Width * y)).B = p.B
                        End If

                    Else
                        'MsgBox("HERE2")
                        _Font.Buffer24(x + (_Texture.Width * y)).a = 0
                    End If

                Else
                    If p.A > 0 Then
                        If Not (p.R = 255 And p.G = 255 And p.B = 255) Then
                            i = 15
                        End If

                    End If
                    _Font.Buffer8(x + (_Texture.Width * y)) = CByte(i)
                End If


            Next
        Next
        _Texture.Dispose()
        _Texture = Nothing
    End Sub

    Public ReadOnly Property CharacterWidth As Integer
        Get
            Return _Font.CharWidth
        End Get
    End Property

    Public ReadOnly Property CharacterHeight As Integer
        Get
            Return _Font.CharHeight
        End Get
    End Property


    Public Function MeasureString(Text As String) As Drawing.Size
        Return MeasureString(Text, _Font.CharWidth, _Font.CharHeight)

    End Function

    Public Function MeasureString(Text As String, CharWidth As Integer, CharHeight As Integer) As Drawing.Size
        If Len(Text) < 1 Then
            Return New Size(0, 0)
        End If
        Dim AddX As Integer = CInt(1 * (CharWidth / _Font.CharWidth))
        If AddX <= 0 Then AddX = 1

        Return New Size((Len(Text) * CharWidth) + (AddX * (Len(Text) - 1)), CharHeight)

    End Function
    Friend Sub DrawInternal(X As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, Text As String, Brightness As Integer, FlipX As Boolean, FlipY As Boolean, SrcRectScale As Double, DesRectScale As Double, Color As Color)
        If Text = "" Then Return
        If X > 128 Then Return
        If y > 32 Then Return
        Text = UCase(Text)
        Dim AddX As Integer = CInt(1 * (CharWidth / _Font.CharWidth))
        If AddX <= 0 Then AddX = 1
        '_Device.Native.Clear(Buffer, UBound(Buffer), 16)
        For i As Integer = 1 To Len(Text)
            If _Device._RGB Then
                If Not Color = Nothing Then
                    _Device.Native.Draw(_Font.Buffer24, _Device.Buffer24, _Font.Width, _Font.Height, 128, 32, _Font.CharRectangles(Asc(Mid(Text, i, 1))), New Rectangle(X, y, CharWidth, CharHeight), Brightness, FlipX, FlipY, SrcRectScale, DesRectScale, Color)
                Else
                    _Device.Native.Draw(_Font.Buffer24, _Device.Buffer24, _Font.Width, _Font.Height, 128, 32, _Font.CharRectangles(Asc(Mid(Text, i, 1))), New Rectangle(X, y, CharWidth, CharHeight), Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
                End If

            Else
                _Device.Native.Draw(_Font.Buffer8, _Device.Buffer8, _Font.Width, _Font.Height, 128, 32, _Font.CharRectangles(Asc(Mid(Text, i, 1))), New Rectangle(X, y, CharWidth, CharHeight), Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
            End If


            X += CharWidth + AddX
            If X > 128 Then
                Return
            End If


        Next

    End Sub
    Friend Sub DrawInternal(Surface As Surface, X As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, Text As String, Brightness As Integer, FlipX As Boolean, FlipY As Boolean, SrcRectScale As Double, DesRectScale As Double, Color As Color)
        If Text = "" Then Return
        If X > Surface.Width Then Return
        If y > Surface.Height Then Return
        Text = UCase(Text)
        Dim AddX As Integer = CInt(1 * (CharWidth / _Font.CharWidth))
        If AddX <= 0 Then AddX = 1
        '_Device.Native.Clear(Buffer, UBound(Buffer), 16)
        For i As Integer = 1 To Len(Text)
            If _Device._RGB Then
                If Not Color = Nothing Then
                    _Device.Native.Draw(_Font.Buffer24, Surface.Buffer24, _Font.Width, _Font.Height, Surface.Width, Surface.Height, _Font.CharRectangles(Asc(Mid(Text, i, 1))), New Rectangle(X, y, CharWidth, CharHeight), Brightness, FlipX, FlipY, SrcRectScale, DesRectScale, Color)
                Else
                    _Device.Native.Draw(_Font.Buffer24, Surface.Buffer24, _Font.Width, _Font.Height, Surface.Width, Surface.Height, _Font.CharRectangles(Asc(Mid(Text, i, 1))), New Rectangle(X, y, CharWidth, CharHeight), Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
                End If

            Else
                _Device.Native.Draw(_Font.Buffer8, Surface.Buffer8, _Font.Width, _Font.Height, Surface.Width, Surface.Height, _Font.CharRectangles(Asc(Mid(Text, i, 1))), New Rectangle(X, y, CharWidth, CharHeight), Brightness, FlipX, FlipY, SrcRectScale, DesRectScale)
            End If


            X += CharWidth + AddX
            If X > Surface.Width Then
                Return
            End If


        Next

    End Sub
    Public Sub Draw(x As Integer, y As Integer, Brightness As Integer, Text As String)
        DrawInternal(x, y, _Font.CharWidth, _Font.CharHeight, Text, Brightness, False, False, 1, 1, Nothing)
        '_Device.Native.Draw(Buffer, _Device.Buffer, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub

    Public Sub Draw(Surface As Surface, x As Integer, y As Integer, Brightness As Integer, Text As String)
        DrawInternal(Surface, x, y, _Font.CharWidth, _Font.CharHeight, Text, Brightness, False, False, 1, 1, Nothing)
        '_Device.Native.Draw(Buffer, Surface.Buffer, 128, 32, Surface.Width, Surface.Height, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub


    Public Sub Draw(x As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, Brightness As Integer, Text As String)
        DrawInternal(x, y, CharWidth, CharHeight, Text, Brightness, False, False, 1, 1, Nothing)
        '_Device.Native.Draw(Buffer, _Device.Buffer, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub

    Public Sub Draw(Surface As Surface, x As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, Brightness As Integer, Text As String)
        DrawInternal(Surface, x, y, CharWidth, CharHeight, Text, Brightness, False, False, 1, 1, Nothing)
        '_Device.Native.Draw(Buffer, Surface.Buffer, 128, 32, Surface.Width, Surface.Height, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub







    Public Sub Draw(x As Integer, y As Integer, Brightness As Integer, Text As String, Color As Color)
        DrawInternal(x, y, _Font.CharWidth, _Font.CharHeight, Text, Brightness, False, False, 1, 1, Color)
        '_Device.Native.Draw(Buffer, _Device.Buffer, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub

    Public Sub Draw(Surface As Surface, x As Integer, y As Integer, Brightness As Integer, Text As String, Color As Color)
        DrawInternal(Surface, x, y, _Font.CharWidth, _Font.CharHeight, Text, Brightness, False, False, 1, 1, Color)
        '_Device.Native.Draw(Buffer, Surface.Buffer, 128, 32, Surface.Width, Surface.Height, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub


    Public Sub Draw(x As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, Brightness As Integer, Text As String, color As Color)
        DrawInternal(x, y, CharWidth, CharHeight, Text, Brightness, False, False, 1, 1, color)
        '_Device.Native.Draw(Buffer, _Device.Buffer, 128, 32, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub

    Public Sub Draw(Surface As Surface, x As Integer, y As Integer, CharWidth As Integer, CharHeight As Integer, Brightness As Integer, Text As String, Color As Color)
        DrawInternal(Surface, x, y, CharWidth, CharHeight, Text, Brightness, False, False, 1, 1, Color)
        '_Device.Native.Draw(Buffer, Surface.Buffer, 128, 32, Surface.Width, Surface.Height, New Rectangle(0, 0, 128, 32), New Rectangle(0, 0, 128, 32), 15, False, False, 1, 1)
        _Device.HasStuffToDraw = True


    End Sub



    Public Sub Dispose()

        ReDim _Font.Buffer8(-1)
        ReDim _Font.Buffer24(-1)
        ReDim _Font.CharRectangles(-1)

    End Sub
End Class
