//***************************************************************************
//
//       名称：uIconToPng.pas
//       工具：RAD Studio XE6
//       日期：2015/12/23 21:41:49
//       作者：ying32
//       QQ  ：1444386932
//       E-mail：1444386932@.qq.com
//       版权所有 (C) 2015-2015 ying32 All Rights Reserved
//
//       原代码为c++代码，由ying32翻译至pascal
//       http://stackoverflow.com/questions/1818990/save-hicon-as-a-png 
//***************************************************************************
unit uIconToPng;

interface

uses
  Windows,
  GDIPAPI,
  GDIPOBJ,
  GDIPUTIL;

  procedure ConvertIconToPng(AhIcon: HICON; const AFileName: string);
implementation

var
  PngClsid: TGUID;

procedure ConvertIconToPng(AhIcon: HICON; const AFileName: string);
var
  iconInfo: TIconInfo;
  DC: HDC;
  bm: Windows.TBitmap;
  bmi: TBitmapInfo;
  nBits: Integer;
  colorBits, maskBits: array of Cardinal;
  hasAlpha: Boolean;
  I: Integer;
  LBitmap: TGPBitmap;
begin
  FillChar(iconInfo, SizeOf(TIConInfo), #0);;
  GetIconInfo(AhIcon, iconInfo);
  DC := GetDC(0);
  try
    FillChar(bm, SizeOf(bm), #0);
    GetObject(iconInfo.hbmColor, sizeof(BITMAP), @bm);

    FillChar(bmi, SizeOf(bmi), #0);
    bmi.bmiHeader.biSize := sizeof(TBitmapInfoHeader);
    bmi.bmiHeader.biWidth := bm.bmWidth;
    bmi.bmiHeader.biHeight := -bm.bmHeight;
    bmi.bmiHeader.biPlanes := 1;
    bmi.bmiHeader.biBitCount := 32;
    bmi.bmiHeader.biCompression := BI_RGB;

    nBits := bm.bmWidth * bm.bmHeight;
    SetLength(colorBits, nBits);
    GetDIBits(DC, iconInfo.hbmColor, 0, bm.bmHeight, colorBits, bmi, DIB_RGB_COLORS);
    hasAlpha := False;
    for I := 0 to nBits - 1 do
    begin
      if colorBits[I] and $FF000000 <> 0 then
      begin
        hasAlpha := True;
        Break;
      end;
    end;
    if not hasAlpha then
    begin
      SetLength(maskBits, nBits);
      GetDIBits(DC, iconInfo.hbmMask, 0, bm.bmHeight, maskBits, bmi, DIB_RGB_COLORS);
      for I := 0 to nBits - 1 do
      begin
        if maskBits[I] = 0 then
        colorBits[I] := colorBits[I] or $FF000000;
      end;
    end;
  finally
    ReleaseDC(0, DC);
  end;
  DeleteObject(iconInfo.hbmColor);
  DeleteObject(iconInfo.hbmMask);

  LBitmap := TGPBitmap.Create(bm.bmWidth, bm.bmHeight, bm.bmWidth * 4, PixelFormat32bppARGB, @colorBits[0]);
  try
    LBitmap.Save(AFileName, PngClsid);
  finally
    LBitmap.Free;
  end;
end;

initialization
  GetEncoderClsid('image/png', PngClsid);



end.
