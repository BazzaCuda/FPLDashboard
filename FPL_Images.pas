unit FPL_Images;

interface

uses
  FMX.Graphics;

type
  IFPLImages = interface
    function fetch25x25Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch40x40Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch50x50Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch110x140Photo(const aPID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch250x250Photo(const aPID: integer; const [ref] aBitmap: TBitmap): boolean;
  end;

function FPLImages: IFPLImages;

implementation

uses
  FPL_Internet, System.Classes, System.IOUtils, System.SysUtils, bzFMXUtils;

const
  URL_25x25 = 'https://resources.premierleague.com/premierleague/badges/25/tBID.png';
  URL_50x50 = 'https://resources.premierleague.com/premierleague/badges/50/tBID.png';
  URL_40x40 = 'https://fantasy.premierleague.com/dist/img/badges/badge_BID_40.png';

  URL_PHOTO_110x140 = 'https://resources.premierleague.com/premierleague/photos/players/110x140/pPID.png';
  URL_PHOTO_250x250 = 'https://resources.premierleague.com/premierleague/photos/players/250x250/pPID.png';


  FOLDER_25x25_BADGES    = 'badges25x25/';
  FOLDER_40x40_BADGES    = 'badges40x40/';
  FOLDER_50x50_BADGES    = 'badges50x50/';
  FOLDER_110x140_PHOTOS  = 'photos110x140/';
  FOLDER_250x250_PHOTOS  = 'photos250x250/';

type
  TFPLImages = class(TInterfacedObject, IFPLImages)
  strict private
    function assignBitmapFromFile(const [ref] aBitmap: TBitmap; const aFilePath: string): boolean;

    function fetch25x25BadgeToFile(const aBID: integer): boolean;
    function fetch40x40BadgeToFile(const aBID: integer): boolean;
    function fetch50x50BadgeToFile(const aBID: integer): boolean;
    function fetch110x140PhotoToFile(const aPID: integer): boolean;
    function fetch250x250PhotoToFile(const aPID: integer): boolean;

    function filePath25x25Badge(const aBID: integer): string;
    function filePath40x40Badge(const aBID: integer): string;
    function filePath50x50Badge(const aBID: integer): string;
    function filePath110x140Photo(const aPID: integer): string;
    function filePath250x250Photo(const aPID: integer): string;

    function URL25x25Badge(const aBID: integer): string;
    function URL40x40Badge(const aBID: integer): string;
    function URL50x50Badge(const aBID: integer): string;
    function URL110x140Photo(const aPID: integer): string;
    function URL250x250Photo(const aPID: integer): string;
  private
    function fetch25x25Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch40x40Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch50x50Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch110x140Photo(const aPID: integer; const [ref] aBitmap: TBitmap): boolean;
    function fetch250x250Photo(const aPID: integer; const [ref] aBitmap: TBitmap): boolean;
  end;

function FPLImages: IFPLImages;
begin
  result := TFPLImages.Create;
end;

{ TFPLImages }

function TFPLImages.assignBitmapFromFile(const [ref] aBitmap: TBitmap; const aFilePath: string): boolean;
begin
  var vBitmap := TBitmap.CreateFromFile(aFilePath);
  try
    aBitmap.Assign(vBitmap);
  finally
    vBitmap.Free;
  end;
end;

function TFPLImages.filePath110x140Photo(const aPID: integer): string;
begin
  result := getExePath + FOLDER_110x140_PHOTOS + 'p' + aPID.ToString + '.png';
end;

function TFPLImages.filePath250x250Photo(const aPID: integer): string;
begin
  result :=getExePath + FOLDER_250x250_PHOTOS + 'p' + aPID.ToString + '.png';
end;

function TFPLImages.filePath25x25Badge(const aBID: integer): string;
begin
  result := getExePath + FOLDER_25x25_BADGES + 't' + aBID.ToString + '.png';
end;

function TFPLImages.filePath40x40Badge(const aBID: integer): string;
begin
  result := getExePath + FOLDER_40x40_BADGES + 'badge_' + aBID.ToString + '_40.png';
end;

function TFPLImages.filePath50x50Badge(const aBID: integer): string;
begin
  result := getExePath + FOLDER_50x50_BADGES + 't' + aBID.ToString + '.png';
end;

function TFPLImages.URL110x140Photo(const aPID: integer): string;
begin
  result := URL_PHOTO_110x140.Replace('PID', aPID.ToString);
end;

function TFPLImages.URL250x250Photo(const aPID: integer): string;
begin
  result := URL_PHOTO_250x250.Replace('PID', aPID.ToString);
end;

function TFPLImages.URL25x25Badge(const aBID: integer): string;
begin
  result := URL_25x25.Replace('BID', aBID.ToString);
end;

function TFPLImages.URL40x40Badge(const aBID: integer): string;
begin
  result := URL_40x40.Replace('BID', aBID.ToString);
end;

function TFPLImages.URL50x50Badge(const aBID: integer): string;
begin
  result := URL_25x25.Replace('BID', aBID.ToString);
end;

function TFPLImages.fetch110x140Photo(const aPID: integer; const [ref] aBitmap: TBitmap): boolean;
begin
  fetch110x140PhotoToFile(aPID);
  assignBitmapFromFile(aBitmap, filePath110x140Photo(aPID));
end;

function TFPLImages.fetch110x140PhotoToFile(const aPID: integer): boolean;
begin
  case FileExists(filePath110x140Photo(aPID)) of TRUE: EXIT; end;
  FPLHttp.fetchURLToFile(URL110x140Photo(aPID), filePath110x140Photo(aPID));
end;

function TFPLImages.fetch250x250Photo(const aPID: integer; const [ref] aBitmap: TBitmap): boolean;
begin
  fetch250x250PhotoToFile(aPID);
  assignBitmapFromFile(aBitmap, filePath250x250Photo(aPID));
end;

function TFPLImages.fetch250x250PhotoToFile(const aPID: integer): boolean;
begin
  case FileExists(filePath250x250Photo(aPID)) of TRUE: EXIT; end;
  FPLHttp.fetchURLToFile(URL250x250Photo(aPID), filePath250x250Photo(aPID));
end;

function TFPLImages.fetch25x25Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
begin
  fetch25x25BadgeToFile(aBID);
  assignBitmapFromFile(aBitmap, filePath25x25Badge(aBID));
end;

function TFPLImages.fetch25x25BadgeToFile(const aBID: integer): boolean;
begin
  case FileExists(filePath25x25Badge(aBID)) of TRUE: EXIT; end;
  FPLHttp.fetchURLToFile(URL25x25Badge(aBID), filePath25x25Badge(aBID));
end;

function TFPLImages.fetch40x40Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
begin
  fetch40x40BadgeToFile(aBID);
  assignBitmapFromFile(aBitmap, filePath40x40Badge(aBID));
end;

function TFPLImages.fetch40x40BadgeToFile(const aBID: integer): boolean;
begin
  case FileExists(filePath40x40Badge(aBID)) of TRUE: EXIT; end;
  FPLHttp.fetchURLToFile(URL40x40Badge(aBID), filePath40x40Badge(aBID));
end;

function TFPLImages.fetch50x50Badge(const aBID: integer; const [ref] aBitmap: TBitmap): boolean;
begin
  fetch50x50BadgeToFile(aBID);
  assignBitmapFromFile(aBitmap, filePath50x50Badge(aBID));
end;

function TFPLImages.fetch50x50BadgeToFile(const aBID: integer): boolean;
begin
  case FileExists(filePath50x50Badge(aBID)) of TRUE: EXIT; end;
  FPLHttp.fetchURLToFile(URL50x50Badge(aBID), filePath50x50Badge(aBID));
end;

end.
