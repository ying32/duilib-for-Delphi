object Form1: TForm1
  Left = 526
  Top = 74
  Caption = 'Form1'
  ClientHeight = 449
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 136
    Top = 40
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    Visible = False
    OnClick = btn1Click
    OnMouseDown = btn1MouseDown
    OnMouseMove = btn1MouseMove
    OnMouseUp = btn1MouseUp
  end
  object DDuiForm1: TDDuiForm
    SkinFolder = '\skin\QQRes\'
    SkinXml = 'main_frame.xml'
    SkinResName = 'DefaultSkin'
    OnInitWindow = DDuiForm1InitWindow
    OnClick = DDuiForm1Click
    Left = 32
    Top = 80
  end
  object DDuiApp1: TDDuiApp
    Left = 32
    Top = 136
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 144
    Top = 152
  end
end
