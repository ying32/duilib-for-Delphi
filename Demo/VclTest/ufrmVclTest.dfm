object Form1: TForm1
  Left = 526
  Top = 74
  Width = 389
  Height = 480
  Caption = 'Form1'
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
    Left = 128
    Top = 152
    Width = 75
    Height = 25
    Caption = 'QQ'#32842#22825#30028#38754
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 128
    Top = 192
    Width = 75
    Height = 25
    Caption = 'QQ'#20027#30028#38754
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 128
    Top = 232
    Width = 75
    Height = 25
    Caption = #27983#35272#22120
    TabOrder = 2
    OnClick = btn3Click
  end
  object DDuiApp1: TDDuiApp
    Left = 72
    Top = 216
  end
end
