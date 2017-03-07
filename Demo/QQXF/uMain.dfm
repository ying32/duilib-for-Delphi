object frmQQXF: TfrmQQXF
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'QQ'#26059#39118#19979#36733
  ClientHeight = 565
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DDuiForm1: TDDuiForm
    SkinFolder = '\skin\XFSKin\'
    SkinXmlFile = 'MainWindow.xml'
    SkinResName = 'DefaultSkin'
    SkinKind = skFile
    OnInitWindow = DDuiForm1InitWindow
    Left = 48
    Top = 208
  end
end
