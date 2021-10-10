unit FPL_JSON;

interface

uses
  SuperObject;

type
  IFPLJson = interface
    // generic
    function fetchFPLJsonFromFile(const aFilePath: string): ISuperObject;

    // specific
    function fetchFPLElementSummary(const aEID: integer): ISuperObject;
    function fetchFPLElementSummaryToFile(const aEDI: integer; const aPath: string): boolean;
    function fetchFPLFixtures(const aGW: integer = 0): ISuperObject;
    function fetchFPLFixturesToFile(aPath: string; const aGW: integer = 0): boolean;
    function fetchFPLGameweek(const aGW: integer): ISuperObject;
    function fetchFPLGameweekToFile(const aGW: integer; aPath: string): boolean;
    function fetchFPLHistory(const aTID: integer): ISuperObject;
    function fetchFPLHistoryToFile(const aTID: integer; const aPath: string): boolean;
    function fetchFPLLeague(const aLID: integer): ISuperObject;
    function fetchFPLLeagueToFile(const aLID: integer; const aPath: string): boolean;
    function fetchFPLMyTeam(const aTID: integer): ISuperObject;
    function fetchFPLMyTeamToFile(const aTID: integer; const aPath: string): boolean;
    function fetchFPLPicks(const aTID: integer; const aGW: integer): ISuperObject;
    function fetchFPLPicksToFile(const aTID: integer; const aGW: integer; const aPath: string): ISuperObject;
    function fetchFPLStatic: ISuperObject;
    function fetchFPLStaticToFile(const aPath: string): boolean;
    function fetchFPLTIDEntry(const aTID: integer): ISuperObject;
    function fetchFPLTIDEntryToFile(const aTID: integer; const aPath: string): boolean;
    function fetchFPLTransfers(const aTID: integer): ISuperObject;
    function fetchFPLTransfersToFile(const aTID: integer; const aPath: string): boolean;


    function FPLStaticElements(const aSO: ISuperObject): ISuperObject;
    function FPLStaticElementTypes(const aSO: ISuperObject): ISuperObject;
    function FPLStaticEvents(const aSO: ISuperObject): ISuperObject;
    function FPLStaticGameSettings(const aSO: ISuperObject): ISuperObject;
    function FPLStaticPhases(const aSO: ISuperObject): ISuperObject;
    function FPLStaticTeams(const aSO: ISuperObject): ISuperObject;
    function FPLStaticTotalPlayers(const aSO: ISuperObject): ISuperObject;
  end;

function FPLJson: IFPLJson;

implementation

uses
  System.Classes, supertypes, bzFMXUtils, FPL_Internet, System.SysUtils, System.IOUtils;

const
  URL_FPL_STATIC  = 'https://fantasy.premierleague.com/api/bootstrap-static/';          // Main URL for all player IDs, team IDs, team strength, gameweek deadlines
  URL_TID_ENTRY   = 'https://fantasy.premierleague.com/api/entry/TID/';                 // General info about the punter and their FPL squad
  URL_GAMEWEEK    = 'https://fantasy.premierleague.com/api/event/GW/live/';             // Live results of given GW
  URL_FIXTURES    = 'https://fantasy.premierleague.com/api/fixtures/';                  // The entire season's fixtures
  URL_FIXTURESGW  = 'https://fantasy.premierleague.com/api/fixtures/?event=GW';         // All fixtures for a given gameweek
  URL_HISTORY     = 'https://fantasy.premierleague.com/api/entry/TID/history/';         // This season and previous seasons performance
  URL_TRANSFERS   = 'https://fantasy.premierleague.com/api/entry/TID/transfers/';       // all transfers made throughout the season
  URL_PICKS       = 'https://fantasy.premierleague.com/api/entry/TID/event/GW/picks/';  // selected players for a given gameweek

  URL_LEAGUE      = 'https://fantasy.premierleague.com/api/leagues-classic/LID/standings/'; // League info
  URL_LEAGUE_Page = 'https://fantasy.premierleague.com/api/leagues-classic/LID/standings/?page_standings=PG'; // paged League info for leagues with > 50 teams
  URL_PLAYER      = 'https://fantasy.premierleague.com/api/element-summary/EID/';       // player info eg fixtures with FDR, current season details, previous summary
  URL_PUNTER      = 'https://fantasy.premierleague.com/api/my-team/TID/';               // requires login

type
  TFPLJson = class(TInterfacedObject, IFPLJson)
  strict private
    // generic
    function fetchFPLJsonAsSuperObject(const aURL: string; aPrefix: string = ''; aSuffix: string = ''): ISuperObject;
    function fetchFPLJsonAsString(const aURL: string; const aPrefix: string = ''; const aSuffix: string = ''): string;
    function fetchFPLJsonToFile(const aFilePath, aURL: string; const aPrefix: String = ''; const aSuffix: String = ''): boolean;
    function fetchFPLJsonFromFile(const aFilePath: string): ISuperObject;
    function WriteToFile(const aString: string; const aFilePath: string): boolean;

    // specific
    function fetchFPLElementSummary(const aEID: integer): ISuperObject;
    function fetchFPLElementSummaryToFile(const aEID: integer; const aPath: string): boolean;
    function fetchFPLFixtures(const aGW: integer = 0): ISuperObject;
    function fetchFPLFixturesToFile(aPath: string; const aGW: integer = 0): boolean;
    function fetchFPLGameweek(const aGW: integer): ISuperObject;
    function fetchFPLGameweekToFile(const aGW: integer; aPath: string): boolean;
    function fetchFPLHistory(const aTID: integer): ISuperObject;
    function fetchFPLHistoryToFile(const aTID: integer; const aPath: string): boolean;
    function fetchFPLLeague(const aLID: integer): ISuperObject;
    function fetchFPLLeagueToFile(const aLID: integer; const aPath: string): boolean;
    function fetchFPLMyTeam(const aTID: integer): ISuperObject;
    function fetchFPLMyTeamToFile(const aTID: integer; const aPath: string): boolean;
    function fetchFPLPicks(const aTID: integer; const aGW: integer): ISuperObject;
    function fetchFPLPicksToFile(const aTID: integer; const aGW: integer; const aPath: string): ISuperObject;
    function fetchFPLStatic: ISuperObject;
    function fetchFPLStaticToFile(const aPath: string): boolean;
    function fetchFPLTIDEntry(const aTID: integer): ISuperObject;
    function fetchFPLTIDEntryToFile(const aTID: integer; const aPath: string): boolean;
    function fetchFPLTransfers(const aTID: integer): ISuperObject;
    function fetchFPLTransfersToFile(const aTID: integer; const aPath: string): boolean;

    function FPLStaticElements(const aSO: ISuperObject): ISuperObject;
    function FPLStaticElementTypes(const aSO: ISuperObject): ISuperObject;
    function FPLStaticEvents(const aSO: ISuperObject): ISuperObject;
    function FPLStaticGameSettings(const aSO: ISuperObject): ISuperObject;
    function FPLStaticPhases(const aSO: ISuperObject): ISuperObject;
    function FPLStaticTeams(const aSO: ISuperObject): ISuperObject;
    function FPLStaticTotalPlayers(const aSO: ISuperObject): ISuperObject;
  private
  end;

function FPLJson: IFPLJson;
begin
  result := TFPLJson.Create;
end;

{ TFPLJson }

function TFPLJson.fetchFPLElementSummary(const aEID: integer): ISuperObject;
begin
  var vURL  := URL_PLAYER.Replace('EID', aEID.ToString);
  result    := fetchFPLJsonAsSuperObject(vURL);
end;

function TFPLJson.fetchFPLElementSummaryToFile(const aEID: integer; const aPath: string): boolean;
begin
  var vURL      := URL_PLAYER.Replace('EID', aEID.ToString);
  var vFilePath := ITBS(aPath) + 'FPLElementSummary-EID.json'.Replace('EID', aEID.ToString);
  result        := WriteToFile(fetchFPLJsonAsString(vURL), vFilePath);
end;

function TFPLJson.fetchFPLFixtures(const aGW: integer = 0): ISuperObject;
var vURL, vString: string;
begin
  case aGW of
    0:  vURL := URL_FIXTURES;
  else
        VURL := URL_FIXTURESGW.Replace('GW', aGW.ToString);
  end;
  vString := fetchFPLJsonAsString(vURL, '{"fixtures":', '}');
  result  := TSuperObject.ParseString(pSOchar(vString), TRUE);
end;

function TFPLJson.fetchFPLFixturesToFile(aPath: string; const aGW: integer = 0): boolean;
var vURL, vFilePath: string;
begin
  case aGW of
    0:  vURL := URL_FIXTURES;
  else
        VURL := URL_FIXTURESGW.Replace('GW', aGW.ToString);
  end;

  case aGW of
    0:  vFilePath := ITBS(aPath) + 'FPLFixtures.json';
  else
        vFilePath := ITBS(aPath) + 'FPLFixtures-GameweekGW.json'.Replace('GW', aGW.ToString);
  end;

  var vString: string := fetchFPLJsonAsString(vURL, '{"fixtures":', '}');
  result := WriteToFile(vString, vFilePath);
end;

function TFPLJson.fetchFPLGameweek(const aGW: integer): ISuperObject;
begin
  var vURL  := URL_GAMEWEEK.Replace('GW', aGW.ToString);
  result    := fetchFPLJsonAsSuperObject(vURL);
end;

function TFPLJson.fetchFPLGameweekToFile(const aGW: integer; aPath: string): boolean;
begin
  var vURL      := URL_GAMEWEEK.Replace('GW', aGW.ToString);
  var vFilePath := ITBS(aPath) + 'FPLGameweekGW.json'.Replace('GW', aGW.ToString);
  result        := WriteToFile(fetchFPLJsonAsString(vURL), vFilePath);
end;

function TFPLJson.fetchFPLHistory(const aTID: integer): ISuperObject;
begin
  var vURL  := URL_HISTORY.Replace('TID', aTID.ToString);
  result    := fetchFPLJsonAsSuperObject(vURL);
end;

function TFPLJson.fetchFPLHistoryToFile(const aTID: integer; const aPath: string): boolean;
begin
  var vURL      := URL_HISTORY.Replace('TID', aTID.ToString);
  var vFilePath := ITBS(aPath) + 'FPLHistory-TID.json'.Replace('TID', aTID.ToString);
  result        := WriteToFile(fetchFPLJsonAsString(vURL), vFilePath);
end;

function TFPLJson.fetchFPLLeague(const aLID: integer): ISuperObject;
begin
  var vURL      := URL_LEAGUE.Replace('LID', aLID.ToString);
  var vString   := fetchFPLJsonAsString(vURL);
  result        := TSuperObject.ParseString(pSOchar(vString), TRUE);
end;

function TFPLJson.fetchFPLLeagueToFile(const aLID: integer; const aPath: string): boolean;
begin
  var vURL      := URL_LEAGUE.Replace('LID', aLID.ToString);
  var vFilePath := ITBS(aPath) + 'FPLLeague-LID.json'.Replace('LID', aLID.ToString);
  var vString   := fetchFPLJsonAsString(vURL);
  WriteToFile(vString, vFilePath);
end;

function TFPLJson.fetchFPLMyTeam(const aTID: integer): ISuperObject;
begin
  var vURL      := URL_PUNTER.Replace('TID', aTID.ToString);
  var vString   := fetchFPLJsonAsString(vURL);
  result        := TSuperObject.ParseString(pSOchar(vString), TRUE);
end;

function TFPLJson.fetchFPLMyTeamToFile(const aTID: integer; const aPath: string): boolean;
begin
  var vURL      := URL_PUNTER.Replace('TID', aTID.ToString);
  var vFilePath := ITBS(aPath) + 'FPLMyTeam-TID.json'.Replace('TID', aTID.ToString);
  var vString   := fetchFPLJsonAsString(vURL);
  WriteToFile(vString, vFilePath);
end;

function TFPLJson.fetchFPLJsonAsSuperObject(const aURL: string; aPrefix: string = ''; aSuffix: string = ''): ISuperObject;
begin
  result := TSuperObject.ParseString(pSOchar(fetchFPLJsonAsString(aURL, aPrefix, aSuffix)), TRUE);
end;

function TFPLJson.fetchFPLJsonAsString(const aURL: string; const aPrefix: string; const aSuffix: string): string;
begin
  result := aPrefix + FPLHttp.fetchURL(aURL) + aSuffix;
end;

function TFPLJson.fetchFPLJsonToFile(const aFilePath, aURL: string; const aPrefix: String = ''; const aSuffix: String = ''): boolean;
begin
  result := FALSE;

  WriteToFile(fetchFPLJsonAsString(aURL, aPrefix, aSuffix), aFilePath);

  result := TRUE;
end;

function TFPLJson.fetchFPLPicks(const aTID, aGW: integer): ISuperObject;
begin
  var vURL      := URL_PICKS.Replace('TID', aTID.ToString).Replace('GW', aGW.ToString);
  var vString   := fetchFPLJsonAsString(vURL); // ,'{"piks":[', ']}');
  result        := TSuperObject.ParseString(pSOchar(vString), TRUE);
end;

function TFPLJson.fetchFPLPicksToFile(const aTID, aGW: integer; const aPath: string): ISuperObject;
begin
  var vURL      := URL_PICKS.Replace('TID', aTID.ToString).Replace('GW', aGW.ToString);
  var vFilePath := ITBS(aPath) + 'FPLPicks-TID-GW.json'.Replace('TID', aTID.ToString).Replace('GW', aGW.ToString);
  var vString   := fetchFPLJsonAsString(vURL); // '{"piks":[', ']}');
  WriteToFile(vString, vFilePath);
end;

function TFPLJson.fetchFPLJsonFromFile(const aFilePath: string): ISuperObject;
begin
  result := TSuperObject.ParseFile(aFilePath, TRUE);
end;

function TFPLJson.fetchFPLStatic: ISuperObject;
begin
  result := TSuperObject.ParseString(pSOchar(fetchFPLJsonAsString(URL_FPL_STATIC)), TRUE);
end;

  function fixKitData(const aString: string): string;
  var
    posKitStart: integer;
    posKitEnd: integer;
    kitData: AnsiString;
    i: integer;
  begin
    posKitstart := pos('"kit":', aString) + 6;
    posKitEnd   := pos(',"last_deadline_bank":', aString) - 1;
    kitData     := copy(aString, PosKitStart, posKitEnd - posKitStart + 1);
    delete(kitData, 1, 1);
    delete(kitData, length(kitData), 1);
    for i := length(kitData) downto 1 do
      if kitData[i] = '\' then delete(kitData, i, 1);

    result := aString;
    delete(result, posKitStart, posKitEnd - posKitStart + 1);
    result.Insert(posKitStart - 1, KitData);
//    WriteToFile(kitData, 'B:\Win64_Dev\Programs\FPL\kitData.txt');
  end;

function TFPLJson.fetchFPLTIDEntryToFile(const aTID: integer; const aPath: string): boolean;
begin
  var vURL      := URL_TID_ENTRY.Replace('TID', aTID.ToString);
  var vFilePath := ITBS(aPath) + 'FPLEntryTID.json'.Replace('TID', aTID.ToString);
  var vTIDEntry := fixKitData(fetchFPLJsonAsString(vURL,'{"entry":[', ']}'));
  WriteToFile(vTIDEntry, vFilePath);
end;

function TFPLJson.fetchFPLTransfers(const aTID: integer): ISuperObject;
begin
  var vURL      := URL_TRANSFERS.Replace('TID', aTID.ToString);
  var vString   := fetchFPLJsonAsString(vURL,'{"transfers":', '}');
  result        := TSuperObject.ParseString(pSOchar(vString), TRUE);
end;

function TFPLJson.fetchFPLTransfersToFile(const aTID: integer; const aPath: string): boolean;
begin
  var vURL      := URL_TRANSFERS.Replace('TID', aTID.ToString);
  var vFilePath := ITBS(aPath) + 'FPLTransfers-TID.json'.Replace('TID', aTID.ToString);
  var vString   := fetchFPLJsonAsString(vURL,'{"transfers":', '}');
  WriteToFile(vString, vFilePath);
end;

function TFPLJson.fetchFPLTIDEntry(const aTID: integer): ISuperObject;
begin
  var vURL      := URL_TID_ENTRY.Replace('TID', aTID.ToString);
  var vTIDEntry := fixKitData(fetchFPLJsonAsString(vURL,'{"entry":[', ']}'));
  result        := TSuperObject.ParseString(pSOchar(vTIDEntry), TRUE);
end;

function TFPLJson.fetchFPLStaticToFile(const aPath: string): boolean;
// UTF-8 BOM = EF BB BF
begin
  result :=  fetchFPLJsonToFile(ITBS(aPath) + 'FPLStatic.json', URL_FPL_STATIC);
end;

function TFPLJson.FPLStaticElements(const aSO: ISuperObject): ISuperObject;
begin
  result := aSO.O['elements'];
end;

function TFPLJson.FPLStaticElementTypes(const aSO: ISuperObject): ISuperObject;
begin
  result := aSO.O['element_types'];
end;

function TFPLJson.FPLStaticEvents(const aSO: ISuperObject): ISuperObject;
begin
  result := aSO.O['events'];
end;

function TFPLJson.FPLStaticGameSettings(const aSO: ISuperObject): ISuperObject;
begin
  result := aSO.O['game_settings'];
end;

function TFPLJson.FPLStaticPhases(const aSO: ISuperObject): ISuperObject;
begin
  result := aSO.O['phases'];
end;

function TFPLJson.FPLStaticTeams(const aSO: ISuperObject): ISuperObject;
begin
  result := aSO.O['teams'];
end;

function TFPLJson.FPLStaticTotalPlayers(const aSO: ISuperObject): ISuperObject;
begin
  result := asO.O['total_players'];
end;

function TFPLJson.WriteToFile(const aString, aFilePath: string): boolean;
begin
  TFile.WriteAllText(aFilePath, aString);
end;

end.
