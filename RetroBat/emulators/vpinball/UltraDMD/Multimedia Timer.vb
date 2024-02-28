Imports System
Imports System.ComponentModel
Imports System.Diagnostics
Imports System.Runtime.InteropServices

'Namespace Multimedia
''' <summary>
''' Defines constants for the multimedia Timer's event types.
''' </summary>
Public Enum TimerMode
    ''' <summary>
    ''' Timer event occurs once.
    ''' </summary>
    OneShot

    ''' <summary>
    ''' Timer event occurs periodically.
    ''' </summary>
    Periodic
End Enum

''' <summary>
''' Represents information about the multimedia Timer's capabilities.
''' </summary>
<StructLayout(LayoutKind.Sequential)> _
Public Structure TimerCaps
    ''' <summary>
    ''' Minimum supported period in milliseconds.
    ''' </summary>
    Public periodMin As Integer

    ''' <summary>
    ''' Maximum supported period in milliseconds.
    ''' </summary>
    Public periodMax As Integer
End Structure

''' <summary>
''' Represents the Windows multimedia timer.
''' </summary>
Friend NotInheritable Class MultiMediaTimer
    Implements IComponent
    Private __site As ISite = Nothing
    Private _Device As Device

    Public Property Site() As ISite
        Get
            Return __site
        End Get
        Set(ByVal value As ISite)
            __site = value
        End Set
    End Property

    Public Sub Dispose()
        '			#Region "Guard"

        If _disposed Then
            Return
        End If

        '			#End Region               

        If IsRunning Then
            [Stop]()
        End If

        _disposed = True

        OnDisposed(EventArgs.Empty)
    End Sub
#Region "Timer Members"

#Region "Delegates"

    ' Represents the method that is called by Windows when a timer event occurs.
    Private Delegate Sub TimeProc(ByVal id As Integer, ByVal msg As Integer, ByVal user As Integer, ByVal param1 As Integer, ByVal param2 As Integer)

    ' Represents methods that raise events.
    Private Delegate Sub EventRaiser(ByVal e As EventArgs)

#End Region

#Region "Win32 Multimedia Timer Functions"

    ' Gets timer capabilities.
    <DllImport("winmm.dll")> _
    Private Shared Function timeGetDevCaps(ByRef caps As TimerCaps, ByVal sizeOfTimerCaps As Integer) As Integer
    End Function

    ' Creates and starts the timer.
    <DllImport("winmm.dll")> _
    Private Shared Function timeSetEvent(ByVal delay As Integer, ByVal resolution As Integer, ByVal proc As TimeProc, ByVal user As Integer, ByVal mode As Integer) As Integer
    End Function

    ' Stops and destroys the timer.
    <DllImport("winmm.dll")> _
    Private Shared Function timeKillEvent(ByVal id As Integer) As Integer
    End Function

    ' Indicates that the operation was successful.
    Private Const TIMERR_NOERROR As Integer = 0

#End Region

#Region "Fields"

    ' Timer identifier.
    Private timerID As Integer

    ' Timer mode.
    'INSTANT VB TODO TASK: There is no VB equivalent to 'volatile':
    'ORIGINAL LINE: private volatile TimerMode mode;
    Private _mode As TimerMode

    ' Period between timer events in milliseconds.
    'INSTANT VB TODO TASK: There is no VB equivalent to 'volatile':
    ''ORIGINAL LINE: private volatile int period;
    Private _period As Integer

    ' Timer resolution in milliseconds.
    'INSTANT VB TODO TASK: There is no VB equivalent to 'volatile':
    'ORIGINAL LINE: private volatile int resolution;
    Private _resolution As Integer

    ' Called by Windows when a timer periodic event occurs.
    Private timeProcPeriodic As TimeProc

    ' Called by Windows when a timer one shot event occurs.
    Private timeProcOneShot As TimeProc

    ' Represents the method that raises the Tick event.
    Private tickRaiser As EventRaiser

    ' Indicates whether or not the timer is running.
    Private running As Boolean = False

    ' Indicates whether or not the timer has been disposed.
    'INSTANT VB TODO TASK: There is no VB equivalent to 'volatile':
    'ORIGINAL LINE: private volatile bool disposed = False;
    Private _disposed As Boolean = False

    ' The ISynchronizeInvoke object to use for marshaling events.
    Private _synchronizingObject As ISynchronizeInvoke = Nothing

    ' For implementing IComponent.


    ' Multimedia timer capabilities.
    Private Shared caps As TimerCaps

#End Region

#Region "Events"

    ''' <summary>
    ''' Occurs when the Timer has started;
    ''' </summary>
    Public Event Started As EventHandler

    ''' <summary>
    ''' Occurs when the Timer has stopped;
    ''' </summary>
    Public Event Stopped As EventHandler

    ''' <summary>
    ''' Occurs when the time period has elapsed.
    ''' </summary>
    Public Event Tick As EventHandler

    ''' <summary>
    ''' Occurs when the time period has elapsed.
    ''' </summary>
    Public Event Disposed As EventHandler

#End Region

#Region "Construction"

    ''' <summary>
    ''' Initialize class.
    ''' </summary>
    Shared Sub New()
        ' Get multimedia timer capabilities.
        timeGetDevCaps(caps, Marshal.SizeOf(caps))
    End Sub

    ''' <summary>
    ''' Initializes a new instance of the Timer class with the specified IContainer.
    ''' </summary>
    ''' <param name="container">
    ''' The IContainer to which the Timer will add itself.
    ''' </param>
    Public Sub New(ByVal container As IContainer)
        '''
        ''' Required for Windows.Forms Class Composition Designer support
        '''
        container.Add(Me)

        Initialize()
    End Sub

    ''' <summary>
    ''' Initializes a new instance of the Timer class.
    ''' </summary>
    Public Sub New(Device As Device)
        _Device = Device
        Initialize()
    End Sub

    Protected Overrides Sub Finalize()
        If IsRunning Then
            ' Stop and destroy timer.
            timeKillEvent(timerID)
        End If
    End Sub

    ' Initialize timer with default values.
    Private Sub Initialize()
        Me.Mode = TimerMode.Periodic
        Me.Period = Capabilities.periodMin
        Me.Resolution = 1

        running = False

        timeProcPeriodic = New TimeProc(AddressOf TimerPeriodicEventCallback)
        timeProcOneShot = New TimeProc(AddressOf TimerOneShotEventCallback)
        tickRaiser = New EventRaiser(AddressOf OnTick)
    End Sub

#End Region

#Region "Methods"

    ''' <summary>
    ''' Starts the timer.
    ''' </summary>
    ''' <exception cref="ObjectDisposedException">
    ''' The timer has already been disposed.
    ''' </exception>
    ''' <exception cref="TimerStartException">
    ''' The timer failed to start.
    ''' </exception>
    Public Sub Start()
        '			#Region "Require"

        If _disposed Then
            Throw New ObjectDisposedException("Timer")
        End If

        '			#End Region

        '			#Region "Guard"

        If IsRunning Then
            Return
        End If

        '			#End Region

        ' If the periodic event callback should be used.
        If Mode = TimerMode.Periodic Then
            ' Create and start timer.
            timerID = timeSetEvent(Period, Resolution, timeProcPeriodic, 0, CInt(Math.Truncate(Mode)))
            ' Else the one shot event callback should be used.
        Else
            ' Create and start timer.
            timerID = timeSetEvent(Period, Resolution, timeProcOneShot, 0, CInt(Math.Truncate(Mode)))
        End If

        ' If the timer was created successfully.
        If timerID <> 0 Then
            running = True

            If SynchronizingObject IsNot Nothing AndAlso SynchronizingObject.InvokeRequired Then
                SynchronizingObject.BeginInvoke(New EventRaiser(AddressOf OnStarted), New Object() {EventArgs.Empty})
            Else
                OnStarted(EventArgs.Empty)
            End If
        Else
            Throw New TimerStartException("Unable to start multimedia Timer.")
        End If
    End Sub
    'Public Sub Dispose()
    '    			#Region "Guard"

    '    If _disposed Then
    '        Return
    '    End If

    '    			#End Region               

    '    If IsRunning Then
    '        [Stop]()
    '    End If

    '    _disposed = True

    '    OnDisposed(EventArgs.Empty)
    'End Sub
    ''' <summary>
    ''' Stops timer.
    ''' </summary>
    ''' <exception cref="ObjectDisposedException">
    ''' If the timer has already been disposed.
    ''' </exception>
    Public Sub [Stop]()
        '			#Region "Require"

        If _disposed Then
            Throw New ObjectDisposedException("Timer")
        End If

        '			#End Region

        '			#Region "Guard"

        If Not running Then
            Return
        End If

        '			#End Region

        ' Stop and destroy timer.
        Dim result As Integer = timeKillEvent(timerID)

        Debug.Assert(result = TIMERR_NOERROR)

        running = False

        If SynchronizingObject IsNot Nothing AndAlso SynchronizingObject.InvokeRequired Then
            SynchronizingObject.BeginInvoke(New EventRaiser(AddressOf OnStopped), New Object() {EventArgs.Empty})
        Else
            OnStopped(EventArgs.Empty)
        End If
    End Sub

#Region "Callbacks"

    ' Callback method called by the Win32 multimedia timer when a timer
    ' periodic event occurs.
    Private Sub TimerPeriodicEventCallback(ByVal id As Integer, ByVal msg As Integer, ByVal user As Integer, ByVal param1 As Integer, ByVal param2 As Integer)
        If SynchronizingObject IsNot Nothing Then
            SynchronizingObject.BeginInvoke(tickRaiser, New Object() {EventArgs.Empty})
        Else
            OnTick(EventArgs.Empty)
        End If
    End Sub



    ' Callback method called by the Win32 multimedia timer when a timer
    ' one shot event occurs.
    Private Sub TimerOneShotEventCallback(ByVal id As Integer, ByVal msg As Integer, ByVal user As Integer, ByVal param1 As Integer, ByVal param2 As Integer)
        If SynchronizingObject IsNot Nothing Then
            SynchronizingObject.BeginInvoke(tickRaiser, New Object() {EventArgs.Empty})
            [Stop]()
        Else
            OnTick(EventArgs.Empty)
            [Stop]()
        End If
    End Sub

#End Region

#Region "Event Raiser Methods"

    ' Raises the Disposed event.
    Private Sub OnDisposed(ByVal e As EventArgs)
        'Dim handler As EventHandler = disposed

        'If handler IsNot Nothing Then
        '    handler(Me, e)
        'End If
        RaiseEvent Disposed(Me, e)

    End Sub

    ' Raises the Started event.
    Private Sub OnStarted(ByVal e As EventArgs)
        'Dim handler As EventHandler = Started

        'If handler IsNot Nothing Then
        '    handler(Me, e)
        'End If
        RaiseEvent Started(Me, e)
    End Sub

    ' Raises the Stopped event.
    Private Sub OnStopped(ByVal e As EventArgs)
        RaiseEvent Stopped(Me, e)
    End Sub


	' Raises the Tick event.
	Private Sub OnTick(ByVal e As EventArgs)
        'Dim handler As EventHandler = Tick

        'If handler IsNot Nothing Then
        '    handler(Me, e)
        'End If
        'Try
        '_Device.LastTimerTick = Environment.TickCount

        If _Device.NeedToRender Then
            If Not _Device.VSyncFailed And _Device._Vsync Then

                _Device.InteralRender(True)
                'Beep()
                'If _Device.VSyncFailed Then Me.Period = 16

            Else
                'If _Device._Vsync AndAlso Me.Period <> 16 Then
                '    Me.Period = 16
                '    _Device._Vsync = False
                'End If

                _Device.InteralRender(False)
            End If


            _Device._HasRendered = True
            _Device.NeedToRender = False
        End If
        'If Not _Device.ThreadVideo Is Nothing Then
        '    If _Device.ThreadVideo.IsAlive Then
        '        If _Device.AutoRender Then
        '            _Device.DrawVideoFrame()
        '            _Device.NeedToRender = False
        '        End If
        '    End If
        'End If
        'If _Device.AutoRender And _Device.HasStuffToDraw Then
        '    _Device.NeedToRender = False
        'End If
        '_Device.ProcessTransitions()
        RaiseEvent Tick(Me, e)
        ''Catch
        ''End Try

    End Sub

#End Region

#End Region

#Region "Properties"

    ''' <summary>
    ''' Gets or sets the object used to marshal event-handler calls.
    ''' </summary>
    Public Property SynchronizingObject() As ISynchronizeInvoke
        Get
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            End If

            '				#End Region

            Return _synchronizingObject
        End Get
        Set(ByVal value As ISynchronizeInvoke)
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            End If

            '				#End Region

            _synchronizingObject = value
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the time between Tick events.
    ''' </summary>
    ''' <exception cref="ObjectDisposedException">
    ''' If the timer has already been disposed.
    ''' </exception>   
    Public Property Period() As Integer
        Get
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            End If

            '				#End Region

            Return _period
        End Get
        Set(ByVal value As Integer)
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            ElseIf value < Capabilities.periodMin OrElse value > Capabilities.periodMax Then
                Throw New ArgumentOutOfRangeException("Period", value, "Multimedia Timer period out of range.")
            End If

            '				#End Region

            _period = value

            If IsRunning Then
                [Stop]()
                Start()
            End If
        End Set
    End Property

    ''' <summary>
    ''' Gets or sets the timer resolution.
    ''' </summary>
    ''' <exception cref="ObjectDisposedException">
    ''' If the timer has already been disposed.
    ''' </exception>        
    ''' <remarks>
    ''' The resolution is in milliseconds. The resolution increases 
    ''' with smaller values; a resolution of 0 indicates periodic events 
    ''' should occur with the greatest possible accuracy. To reduce system 
    ''' overhead, however, you should use the maximum value appropriate 
    ''' for your application.
    ''' </remarks>
    Public Property Resolution() As Integer
        Get
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            End If

            '				#End Region

            Return _resolution
        End Get
        Set(ByVal value As Integer)
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            ElseIf value < 0 Then
                Throw New ArgumentOutOfRangeException("Resolution", value, "Multimedia timer resolution out of range.")
            End If

            '				#End Region

            _resolution = value

            If IsRunning Then
                [Stop]()
                Start()
            End If
        End Set
    End Property


    ''' <summary>
    ''' Gets the timer mode.
    ''' </summary>
    ''' <exception cref="ObjectDisposedException">
    ''' If the timer has already been disposed.
    ''' </exception>
    Public Property Mode() As TimerMode
        Get
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            End If

            '				#End Region

            Return _mode
        End Get
        Set(ByVal value As TimerMode)
            '				#Region "Require"

            If _disposed Then
                Throw New ObjectDisposedException("Timer")
            End If

            '				#End Region

            _mode = value

            If IsRunning Then
                [Stop]()
                Start()
            End If
        End Set
    End Property

    ''' <summary>
    ''' Gets a value indicating whether the Timer is running.
    ''' </summary>
    Public ReadOnly Property IsRunning() As Boolean
        Get
            Return running
        End Get
    End Property




    ''' <summary>
    ''' Gets the timer capabilities.
    ''' </summary>
    Public Shared ReadOnly Property Capabilities() As TimerCaps
        Get
            Return caps
        End Get
    End Property

#End Region

#End Region

#Region "IComponent Members"

    'Public Event Disposed As System.EventHandler



#End Region

    '#Region "IDisposable Members"

    ''' <summary>
    ''' Frees timer resources.
    ''' </summary>

    Public Event Disposed1(sender As Object, e As EventArgs) Implements IComponent.Disposed

    Public Property Site1 As ISite Implements IComponent.Site

    Public Sub Dispose1() Implements IDisposable.Dispose

    End Sub
End Class

'#End Region


''' <summary>
''' The exception that is thrown when a timer fails to start.
''' </summary>
Public Class TimerStartException
    Inherits ApplicationException

    ''' <summary>
    ''' Initializes a new instance of the TimerStartException class.
    ''' </summary>
    ''' <param name="message">
    ''' The error message that explains the reason for the exception. 
    ''' </param>
    Public Sub New(ByVal message As String)
        MyBase.New(message)
    End Sub
End Class


