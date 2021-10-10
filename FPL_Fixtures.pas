unit FPL_Fixtures;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLFixtureStat = class
  private
    FHomeAway: char;
    Felement: integer;
    Fvalue:   integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property HomeAway:    char    read FHomeAway;
    property element:     integer read Felement;
    property value:       integer read Fvalue;
  end;

  TFPLFixture = class
  private
    Fgoals_scored:      IList<TFPLFixtureStat>;
    Fassists:           IList<TFPLFixtureStat>;
    Fown_goals:         IList<TFPLFixtureStat>;
    Fpenalties_saved:   IList<TFPLFixtureStat>;
    Fpenalties_missed:  IList<TFPLFixtureStat>;
    Fyellow_cards:      IList<TFPLFixtureStat>;
    Fred_cards:         IList<TFPLFixtureStat>;
    Fsaves:             IList<TFPLFixtureStat>;
    Fbonus:             IList<TFPLFixtureStat>;
    Fbps:               IList<TFPLFixtureStat>;
  private
    Fid:                      integer;
    Fteam_h_difficulty:       integer;
    Fpulse_id:                integer;
    Ffinished:                boolean;
    Fcode:                    integer;
    Fkickoff_time:            TDateTime;
    Fminutes:                 integer;
    Fteam_h_score:            integer;
    Fteam_a_difficulty:       integer;
    Fstarted:                 boolean;
    Fprovisional_start_time:  boolean;
    Fteam_h:                  integer;
    Fteam_a_score:            integer;
    Fevent:                   integer;
    Fteam_a:                  integer;
    Ffinished_provisional:    boolean;
    function getGoalsScored:      IReadOnlyList<TFPLFixtureStat>;
    function getAssists:          IReadOnlyList<TFPLFixtureStat>;
    function getBonus:            IReadOnlyList<TFPLFixtureStat>;
    function getBPS:              IReadOnlyList<TFPLFixtureStat>;
    function getOwnGoals:         IReadOnlyList<TFPLFixtureStat>;
    function getPenaltiesMissed:  IReadOnlyList<TFPLFixtureStat>;
    function getPenaltiesSaved:   IReadOnlyList<TFPLFixtureStat>;
    function getRedCards:         IReadOnlyList<TFPLFixtureStat>;
    function getSaves:            IReadOnlyList<TFPLFixtureStat>;
    function getYellowCards:      IReadOnlyList<TFPLFixtureStat>;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';

    property id:                      integer   read Fid;
    property team_h_score:            integer   read Fteam_h_score;
    property pulse_id:                integer   read Fpulse_id;
    property minutes:                 integer   read Fminutes;
    property kickoff_time:            TDateTime read Fkickoff_time;
    property finished:                boolean   read Ffinished;
    property provisional_start_time:  boolean   read Fprovisional_start_time;
    property team_a_score:            integer   read Fteam_a_score;
    property event:                   integer   read Fevent;
    property started:                 boolean   read Fstarted;
    property team_a_difficulty:       integer   read Fteam_a_difficulty;
    property team_h_difficulty:       integer   read Fteam_h_difficulty;
    property code:                    integer   read Fcode;
    property team_h:                  integer   read Fteam_h;
    property team_a:                  integer   read Fteam_a;
    property finished_provisional:    boolean   read Ffinished_provisional;

    property goals_scored:      IReadOnlyList<TFPLFixtureStat> read getGoalsScored;
    property assists:           IReadOnlyList<TFPLFixtureStat> read getAssists;
    property own_goals:         IReadOnlyList<TFPLFixtureStat> read getOwnGoals;
    property penalties_saved:   IReadOnlyList<TFPLFixtureStat> read getPenaltiesSaved;
    property penalties_missed:  IReadOnlyList<TFPLFixtureStat> read getPenaltiesMissed;
    property yellow_cards:      IReadOnlyList<TFPLFixtureStat> read getYellowCards;
    property red_cards:         IReadOnlyList<TFPLFixtureStat> read getRedCards;
    property saves:             IReadOnlyList<TFPLFixtureStat> read getSaves;
    property bonus:             IReadOnlyList<TFPLFixtureStat> read getBonus;
    property bps:               IReadOnlyList<TFPLFixtureStat> read getBPS;
  end;

  IFPLFixtures = interface
    function build(aSO: ISuperObject):  boolean;
    function getFixtures:               IReadOnlyList<TFPLFixture>;
    property Fixtures:                  IReadOnlyList<TFPLFixture> read getFixtures;
  end;

function FPLFixtures: IFPLFixtures;

implementation

uses
  System.SysUtils, XSBuiltIns;

type
  TFPLFixtures = class(TInterfacedObject, IFPLFixtures)
  strict private
    FFixtures:                          IList<TFPLFixture>;
  private
    function getFixtures:               IReadOnlyList<TFPLFixture>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property Fixtures:                  IReadOnlyList<TFPLFixture> read getFixtures;
  end;

var gInstance: IFPLFixtures;

function FPLFixtures: IFPLFixtures;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLFixtures.Create; end;
  result := gInstance;
end;

{ TFPLFixtures }

function TFPLFixtures.build(aSO: ISuperObject): boolean;
var
  so:       ISuperObject;
  rec:      TFPLFixture;
  recStat:  TFPLFixtureStat;
  statIDs:  string;

  procedure buildStatIDs;
  // align IDs on 16-char boundaries
  begin
    statIDs := format('%15s%16s%16s%16s%16s%16s%16s%16s%16s%16s%16s',
                      [' ', 'goals_scored','assists','own_goals','penalties_saved','penalties_missed','yellow_cards','red_cards','saves','bonus','bps']);
  end;

  procedure processStat(const aIdentifier: string);
  // statNum := pos(aIdentifier, statIDs) div 16;
  begin
    case pos(aIdentifier, statIDs) = 0 of TRUE: raise EProgrammerNotFound.Create('Fixture processStat: stat id = ' + aIdentifier); end;
    case aIdentifier = 'goals_scored'     of TRUE: rec.Fgoals_scored.Add(recStat);      end;
    case aIdentifier = 'assists'          of TRUE: rec.Fassists.Add(recStat);           end;
    case aIdentifier = 'own_goals'        of TRUE: rec.Fown_goals.Add(recStat);         end;
    case aIdentifier = 'penalties_saved'  of TRUE: rec.Fpenalties_saved.Add(recStat);   end;
    case aIdentifier = 'penalties_missed' of TRUE: rec.Fpenalties_missed.Add(recStat);  end;
    case aIdentifier = 'yellow_cards'     of TRUE: rec.Fyellow_cards.Add(recStat);      end;
    case aIdentifier = 'red_cards'        of TRUE: rec.Fred_cards.Add(recStat);         end;
    case aIdentifier = 'saves'            of TRUE: rec.Fsaves.Add(recStat);             end;
    case aIdentifier = 'bonus'            of TRUE: rec.Fbonus.Add(recStat);             end;
    case aIdentifier = 'bps'              of TRUE: rec.Fbps.Add(recStat);               end;
  end;
begin
  FFixtures.Clear;
  buildStatIDs;

  for so in aSO do begin

    for var fixture in so do begin
      rec := TFPLFixture.Create('OK');

      rec.Fid                     := fixture.I['id'];
      rec.Fteam_h_difficulty      := fixture.I['team_h_difficulty'];
      rec.Fpulse_id               := fixture.I['pulse_id'];
      rec.Ffinished               := fixture.B['finished'];
      rec.Fcode                   := fixture.I['code'];
      rec.Fkickoff_time           := XMLTimeToDateTime(fixture.S['kickoff_time'], FALSE);
      rec.Fminutes                := fixture.I['minutes'];
      rec.Fteam_h_score           := fixture.I['team_h_score'];
      rec.Fteam_a_difficulty      := fixture.I['team_a_difficulty'];
      rec.Fstarted                := fixture.B['started'];
      rec.Fprovisional_start_time := fixture.B['provisional_start_time'];
      rec.Fteam_h                 := fixture.I['team_h'];
      rec.Fteam_a_score           := fixture.I['team_a_score'];
      rec.Fevent                  := fixture.I['event'];
      rec.Fteam_a                 := fixture.I['team_a'];
      rec.Ffinished_provisional   := fixture.B['finished_provisional'];

      for var vStat in fixture.O['stats'] do begin
        case trim(vstat.S['identifier']) = '' of TRUE: CONTINUE; end; // upcoming fixtures have a present but empty stats array
        for var vHome in vstat['h'] do begin
          recStat := TFPLFixtureStat.Create('OK');
          recStat.FHomeAway := 'H';
          recStat.Felement  := vHome.I['element'];
          recStat.Fvalue    := vHome.I['value'];
          processStat(vstat.S['identifier']);
        end;
        for var vAway in vStat['a'] do begin
          recStat := TFPLFixtureStat.Create('OK');
          recStat.FHomeAway := 'A';
          recStat.Felement  := vAway.I['element'];
          recStat.Fvalue    := vAway.I['value'];
          processStat(vstat.S['identifier']);
        end;
      end;

      FFixtures.Add(rec);
    end;

  end;
end;

constructor TFPLFixtures.Create;
begin
  inherited;
  FFixtures := TCollections.CreateObjectList<TFPLFixture>(TRUE);
end;

destructor TFPLFixtures.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLFixtures.getFixtures: IReadOnlyList<TFPLFixture>;
begin
  result := FFixtures.AsReadOnlyList;
end;

{ TFPLFixture }

constructor TFPLFixture.Create(const aOK: string);
begin
  inherited Create;
  Fgoals_scored     := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fassists          := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fown_goals        := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fpenalties_saved  := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fpenalties_missed := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fyellow_cards     := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fred_cards        := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fsaves            := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fbonus            := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
  Fbps              := TCollections.CreateObjectList<TFPLFixtureStat>(TRUE);
end;

constructor TFPLFixture.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

function TFPLFixture.getAssists: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fassists.AsReadOnlyList;
end;

function TFPLFixture.getBonus: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fbonus.AsReadOnlyList;
end;

function TFPLFixture.getBPS: IReadOnlyList<TFPLFixtureStat>;
begin
 result := Fbps.AsReadOnlyList;
end;

function TFPLFixture.getGoalsScored: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fgoals_scored.AsReadOnlyList;
end;

function TFPLFixture.getOwnGoals: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fown_goals.AsReadOnlyList;
end;

function TFPLFixture.getPenaltiesMissed: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fpenalties_missed.AsReadOnlyList;
end;

function TFPLFixture.getPenaltiesSaved: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fpenalties_saved.AsReadOnlyList;
end;

function TFPLFixture.getRedCards: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fred_cards.AsReadOnlyList;
end;

function TFPLFixture.getSaves: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fsaves.AsReadOnlyList;
end;

function TFPLFixture.getYellowCards: IReadOnlyList<TFPLFixtureStat>;
begin
  result := Fyellow_cards.AsReadOnlyList;
end;

{ TFPLFixtureStat }

constructor TFPLFixtureStat.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

constructor TFPLFixtureStat.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
