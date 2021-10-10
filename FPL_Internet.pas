unit FPL_Internet;

interface

uses
  System.Classes;

type
  IFPLHttp = interface
    function fetchURL(const aURL: string): string;
    function fetchURLToFile(const aURL, aFilePath: string): boolean;
    function fetchURLToStream(const aURL: string; const [ref] aStream: TStream): boolean;
    function login: string;
  end;

function FPLHttp: IFPLHttp;

implementation

uses
  idHTTP, idSSLOpenSSL, System.SysUtils, Spring, idAuthentication, idCookie, idUri, FMX.Dialogs;

type
  TFPLHttp = class(TInterfacedObject, IFPLHttp)
  strict private
    function fetchURL(const aURL: string): string;
    function fetchURLToFile(const aURL, aFilePath: string): boolean;
    function fetchURLToStream(const aURL: string; const [ref] aStream: TStream): boolean;
    function login: string;
  private
    procedure HTTPOnRedirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: TIdHTTPMethod);
  end;

function FPLHttp: IFPLHttp;
begin
  result := TFPLHttp.Create;
end;

{ TFPLHTTP }

function TFPLHttp.fetchURL(const aURL: string): string;
var
  http:       TIdHTTP;
  sslHandler: TIdSSLIOHandlerSocketOpenSSL;
  ss:         TStringStream;
begin
  guard.CheckTrue(trim(aURL) <> '', 'FPLHttp: no URL');

  http := TIdHTTP.Create(nil);
  http.Request.ContentEncoding := 'UTF-8';
  http.ProxyParams.ProxyPort := 8888;
  http.ProxyParams.ProxyServer := 'localhost';

  sslHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  sslHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  http.IOHandler := sslHandler;

  ss := TStringStream.Create('', TEncoding.UTF8);

  try
    http.get(aUrl, ss);
    result := ss.DataString;
  finally
    ss.Free;
    sslHandler.Free;
    http.Free;
  end;
end;

function TFPLHttp.fetchURLToStream(const aURL: string; const [ref] aStream: TStream): boolean;
var
  http:       TIdHTTP;
  sslHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  guard.CheckTrue(trim(aURL) <> '', 'FPLHttp: no URL');

  http := TIdHTTP.Create(nil);

  sslHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  sslHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  http.IOHandler := sslHandler;

  try
    http.Get(aURL, aStream);
  finally
    sslHandler.Free;
    http.Free;
  end;
end;


function TFPLHttp.fetchURLToFile(const aURL: string; const aFilePath: string): boolean;
begin
  var FS := TFileStream.Create(aFilePath, fmCreate);
  try
    try
      fetchURLToStream(aURL, FS);
    except
      DeleteFile(aFilePath);
    end;
  finally
    if FS.Size = 0 then begin
                          FS.Free;
                          DeleteFile(aFilePath);
                        end
    else
      FS.Free;
  end;
end;







//======= EXPERIMENTAL =======

procedure TFPLHttp.HTTPOnRedirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: TIdHTTPMethod);
begin
  Handled := TRUE;
end;

function TFPLHttp.login: string;
// couldn't get this to work
const
  URL_LOGIN       = 'https://users.premierleague.com/accounts/login/';
  URL_PUNTER      = 'https://fantasy.premierleague.com/api/my-team/4206643/'; // requires login
var
  http:       TIdHTTP;
  sslHandler: TIdSSLIOHandlerSocketOpenSSL;
  ss:         TStringStream;
  params:     TStringList;
  cookie:     TIdCookie;
  token:      AnsiString;
  content:    string;
  posCookie:  integer;
  myToken:    string;
  sPost:      string;
  mwCookie:   TIdCookie;
  uri:        TIdUri;
begin
  http := TIdHTTP.Create(nil);
  http.Request.ContentEncoding := 'UTF-8';

  params := TStringList.Create;
  params.Values['login']          := '';
  params.Values['password']       := '';
  params.Values['redirecct_uri']  := 'https://users.premierleague.com/';
//  params.Values['app']            := 'plfpl-web';
  params.Values['app']            := 'plusers';
//  params.Values['_fbp']           := 'fb.1.1619305060285.2130919484';
//  params.Values['DNT']            := '1';

  http.AllowCookies     := TRUE;
  http.HandleRedirects  := TRUE;
  http.RedirectMaximum  := 999;
  http.ProxyParams.ProxyPort := 8888;
  http.ProxyParams.ProxyServer := 'localhost';

//    HTTP.Request.Accept         := 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9';
//    HTTP.Request.AcceptCharSet  := 'iso-8859-1, utf-8, utf-16, *;q=0.1';
//    HTTP.Request.AcceptEncoding := 'gzip, deflate, br';
//    http.Request.AcceptLanguage := 'en-GB,en;q=0.9';
    HTTP.Request.Connection     := 'Keep-Alive';
//    HTTP.Request.ContentType    := 'application/x-www-form-urlencoded';
//    HTTP.Request.UserAgent      := 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36';
//    HTTP.Request.CharSet        := 'utf-8';

  HTTP.Request.Referer := 'https://users.premierleague.com/?state=fail&reason=credentials';

  sslHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  sslHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  http.IOHandler := sslHandler;

  ss := TStringStream.Create('', TEncoding.UTF8);

  try
    try
      content   := http.get(URL_LOGIN);
      result := content;
      posCookie := pos('csrfmiddlewaretoken" value="', content);
      myToken     := copy(content, posCookie + 28, 64);
      params.Values['csrfmiddlewaretoken'] := token;
      case http.CookieManager.CookieCollection.Count > 0 of
        FALSE:  begin ShowMessage('No cookie returned'); EXIT; end;
         TRUE:  begin
                  cookie := HTTP.CookieManager.CookieCollection.Cookie['csrftoken', 'users.premierleague.com'];
                  token := cookie.Value;
                  params.Values['csrtoken'] := token;
                  mwCookie := http.CookieManager.CookieCollection.Add;
                  mwCookie.Assign(cookie);
                  mwcookie.CookieName := 'csrfmiddlewaretoken';
                  mwCookie.Domain     := 'users.premierleague.com';
                  mwcookie.Value      := myToken;
//                  uri.URI := URL_LOGIN;

                  http.HandleRedirects := FALSE;
                  http.OnRedirect := HttpOnRedirect;

//                  http.Request.CustomHeaders.Add('Authorization: Token ' + token);
                  try
                    http.POST(URL_LOGIN, params, ss);
                    ShowMessage('Post: ' + ss.DataString);
                  except on E:Exception do
                    ShowMessage('postE: ' + E.Message);
                  end;
                  //ShowMessage('Post: ' + http.ResponseCode.ToString + ' (' + http.ResponseText + ')');
//                  HTTP.Request.CustomHeaders.Add('x-csrftoken:'+ token);
//                  HTTP.Request.CustomHeaders.Add('csrftoken:'+ token);
//                  HTTP.Request.CustomHeaders.Add('csrfmiddlewaretoken:'+ token);
//                  http.Request.CustomHeaders.Add('Authorization:' + token);
                  http.get(URL_PUNTER, ss);
                  //result := ss.DataString;
                end;
        end;
    except
      result := 'Post response: ' + sPost + #13#10 +
                'get my team: '   + http.ResponseText + #13#10 + ss.DataString + #13#10 +
                'My: '            + myToken + #13#10 +
                'CM: '            + http.CookieManager.CookieCollection.Cookie['csrftoken', 'users.premierleague.com'].Value + #13#10
                                  + result;
    end;
  finally
    params.Free;
    ss.Free;
    sslHandler.Free;
    http.Free;
  end;
end;

end.

