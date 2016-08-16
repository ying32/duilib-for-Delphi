object Form3: TForm3
  Left = 520
  Top = 356
  Width = 414
  Height = 492
  Caption = 'Form3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 136
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 0
    OnClick = btn1Click
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
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 40
    Top = 208
  end
end
