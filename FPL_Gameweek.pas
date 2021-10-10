unit FPL_Gameweek;

interface

uses
  SuperObject, Spring.Collections;

type

  TFPLGameweekStat = class          { TODO : Each stat type needs to be an individual IReadOnlyList, like with TFPLFixture }
  private
    Ffixture: integer;      // for double-gameweeks
    Fidentifier: string;    // explains the breakdown of total_points
    Fvalue: integer;
    Fpoints: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property fixture:     integer read Ffixture;
    property identifier:  string  read Fidentifier;
    property points:      integer read Fpoints;
    property value:       integer read Fvalue;
  end;

  TFPLGameweekElement = class
  private
    FGameweekStats:     IList<TFPLGameweekStat>;
    FSassists:          IList<TFPLGameweekStat>;
    FSbonus:            IList<TFPLGameweekStat>;
    FSclean_sheets:     IList<TFPLGameweekStat>;
    FSgoals_conceded:   IList<TFPLGameweekStat>;
    FSgoals_scored:     IList<TFPLGameweekStat>;
    FSminutes:          IList<TFPLGameweekStat>;
    FSown_goals:        IList<TFPLGameweekStat>;
    FSred_cards:        IList<TFPLGameweekStat>;
    FSsaves:            IList<TFPLGameweekStat>;
    FSyellow_cards:     IList<TFPLGameweekStat>;
    FSpenalties_saved:  IList<TFPLGameweekStat>;
    FSpenalties_missed: IList<TFPLGameweekStat>;
  private
    Fgoals_scored: integer;
    Fcreativity: double;
    Fsaves: integer;
    Fbonus: integer;
    Fpenalties_missed: integer;
    Fclean_sheets: integer;
    Fassists: integer;
    Fthreat: double;
    Fpenalties_saved: integer;
    Fyellow_cards: integer;
    Fict_index: double;
    Fminutes: integer;
    Fown_goals: integer;
    Fid: integer;
    Fred_cards: integer;
    Fin_dreamteam: boolean;
    Ftotal_points: integer;
    Fbps: integer;
    Fgoals_conceded: integer;
    Finfluence: double;
    function getGameweekStats: IReadOnlyList<TFPLGameweekStat>;
    function getSassists: IReadOnlyList<TFPLGameweekStat>;
    function getSbonus: IReadOnlyList<TFPLGameweekStat>;
    function getSclean_sheets: IReadOnlyList<TFPLGameweekStat>;
    function getSgoals_conceded: IReadOnlyList<TFPLGameweekStat>;
    function getSgoals_scored: IReadOnlyList<TFPLGameweekStat>;
    function getSminutes: IReadOnlyList<TFPLGameweekStat>;
    function getSred_cards: IReadOnlyList<TFPLGameweekStat>;
    function getSsaves: IReadOnlyList<TFPLGameweekStat>;
    function getSyellow_cards: IReadOnlyList<TFPLGameweekStat>;
    function getSown_goals: IReadOnlyList<TFPLGameweekStat>;
    function getSpenalties_saved: IReadOnlyList<TFPLGameweekStat>;
    function getSpenalties_missed: IReadOnlyList<TFPLGameweekStat>;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property id:                integer read Fid;
    property goals_conceded:    integer read Fgoals_conceded;
    property bps:               integer read Fbps;
    property minutes:           integer read Fminutes;
    property ict_index:         double  read Fict_index;
    property in_dreamteam:      boolean read Fin_dreamteam;
    property penalties_saved:   integer read Fpenalties_saved;
    property total_points:      integer read Ftotal_points;
    property creativity:        double  read Fcreativity;
    property yellow_cards:      integer read Fyellow_cards;
    property influence:         double  read Finfluence;
    property own_goals:         integer read Fown_goals;
    property clean_sheets:      integer read Fclean_sheets;
    property threat:            double  read Fthreat;
    property red_cards:         integer read Fred_cards;
    property saves:             integer read Fsaves;
    property goals_scored:      integer read Fgoals_scored;
    property penalties_missed:  integer read Fpenalties_missed;
    property bonus:             integer read Fbonus;
    property assists:           integer read Fassists;

    property GameweekStats:       IReadOnlyList<TFPLGameweekStat> read getGameweekStats;
    property Sassists:            IReadOnlyList<TFPLGameweekStat> read getSassists;
    property Sbonus:              IReadOnlyList<TFPLGameweekStat> read getSbonus;
    property Sclean_sheets:       IReadOnlyList<TFPLGameweekStat> read getSclean_sheets;
    property Sgoals_conceded:     IReadOnlyList<TFPLGameweekStat> read getSgoals_conceded;
    property Sgoals_scored:       IReadOnlyList<TFPLGameweekStat> read getSgoals_scored;
    property Sminutes:            IReadOnlyList<TFPLGameweekStat> read getSminutes;
    property Sown_goals:          IReadOnlyList<TFPLGameweekStat> read getSown_goals;
    property Sred_cards:          IReadOnlyList<TFPLGameweekStat> read getSred_cards;
    property Ssaves:              IReadOnlyList<TFPLGameweekStat> read getSsaves;
    property Syellow_cards:       IReadOnlyList<TFPLGameweekStat> read getSyellow_cards;
    property Spenalties_saved:    IReadOnlyList<TFPLGameweekStat> read getSpenalties_saved;
    property Spenalties_missed:   IReadOnlyList<TFPLGameweekStat> read getSpenalties_missed;
  end;

  IFPLGameweekElements = interface
    function build(aSO: ISuperObject):  boolean;
    function getGameweekElements:       IReadOnlyList<TFPLGameweekElement>;
    property Elements:                  IReadOnlyList<TFPLGameweekElement> read getGameweekElements;
  end;

function FPLGameweek: IFPLGameweekElements;

implementation

uses
  System.SysUtils;

type
  TFPLGameweekElements = class(TInterfacedObject, IFPLGameweekElements)
  strict private
    FGameweekElements:                  IList<TFPLGameweekElement>;
  private
    function getGameweekElements:       IReadOnlyList<TFPLGameweekElement>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property Elements:                  IReadOnlyList<TFPLGameweekElement> read getGameweekElements;
  end;

var gInstance: IFPLGameweekElements;

function FPLGameweek: IFPLGameweekElements;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLGameweekElements.Create; end;
  result := gInstance;
end;

{ TFPLGameweekElements }

function TFPLGameweekElements.build(aSO: ISuperObject): boolean;
var
  so:       ISuperObject;
  rec:      TFPLGameweekElement;
  recStat:  TFPLGameweekStat;
  statIDs:  string;

  procedure buildStatIDs;
  // align IDs on 16-char boundaries
  begin
    statIDs := format('%15s%16s%16s%16s%16s%16s%16s%16s%16s%16s%16s%16s%16s',
                      [' ', 'assists', 'bonus', 'clean_sheets', 'goals_conceded', 'goals_scored', 'minutes',
                            'own_goals', 'red_cards', 'saves', 'yellow_cards', 'penalties_saved', 'penalties_missed']);
  end;

  procedure processStat(const aIdentifier: string);
  // statNum := pos(aIdentifier, statIDs) div 16;
  begin
    case pos(aIdentifier, statIDs) = 0 of TRUE: raise EProgrammerNotFound.Create('Gameweek processStat: stat id = ' + aIdentifier); end;
    case aIdentifier = 'assists'          of TRUE: rec.FSassists.Add(recStat);           end;
    case aIdentifier = 'bonus'            of TRUE: rec.FSbonus.Add(recStat);             end;
    case aIdentifier = 'clean_sheets'     of TRUE: rec.FSclean_sheets.Add(recStat);      end;
    case aIdentifier = 'goals_conceded'   of TRUE: rec.FSgoals_conceded.Add(recStat);    end;
    case aIdentifier = 'goals_scored'     of TRUE: rec.FSgoals_scored.Add(recStat);      end;
    case aIdentifier = 'minutes'          of TRUE: rec.FSminutes.Add(recStat);           end;
    case aIdentifier = 'own_goals'        of TRUE: rec.FSown_goals.Add(recStat);         end;
    case aIdentifier = 'red_cards'        of TRUE: rec.FSred_cards.Add(recStat);         end;
    case aIdentifier = 'saves'            of TRUE: rec.FSsaves.Add(recStat);             end;
    case aIdentifier = 'yellow_cards'     of TRUE: rec.FSyellow_cards.Add(recStat);      end;
    case aIdentifier = 'penalties_saved'  of TRUE: rec.FSpenalties_saved.Add(recStat);   end;
    case aIdentifier = 'penalties_missed' of TRUE: rec.FSpenalties_missed.Add(recStat);  end;
  end;

begin
  FGameweekElements.Clear;
  buildStatIDs;

  for so in aSO do begin

    for var element in so do begin
      rec := TFPLGameweekElement.Create('OK');

      rec.Fid := element.I['id'];

      var stats := element['stats'];
      rec.Fgoals_conceded :=    stats.I['goals_conceded'];
      rec.Fbps :=               stats.I['bps'];
      rec.Fminutes :=           stats.I['minutes'];
      rec.Fict_index :=         stats.D['ict_index'];
      rec.Fin_dreamteam :=      stats.B['in_dreamteam'];
      rec.Fpenalties_saved :=   stats.I['penalties_saved'];
      rec.Ftotal_points :=      stats.I['total_points'];
      rec.Fcreativity :=        stats.D['creativity'];
      rec.Fyellow_cards :=      stats.I['yellow_cards'];
      rec.Finfluence :=         stats.D['influence'];
      rec.Fown_goals :=         stats.I['own_goals'];
      rec.Fclean_sheets :=      stats.I['clean_sheets'];
      rec.Fthreat :=            stats.D['threat'];
      rec.Fred_cards :=         stats.I['red_cards'];
      rec.Fsaves :=             stats.I['saves'];
      rec.Fgoals_scored :=      stats.I['goals_scored'];
      rec.Fpenalties_missed :=  stats.I['penalties_missed'];
      rec.Fbonus :=             stats.I['bonus'];
      rec.Fassists :=           stats.I['assists'];

      for var explain in element['explain'] do begin

        for var stat in explain['stats'] do begin
          recStat := TFPLGameweekStat.Create('OK');

          recStat.Ffixture := explain.I['fixture']; // for double-gameweeks

          recStat.Fidentifier := stat.S['identifier'];
          recStat.Fpoints     := stat.I['points'];
          recStat.Fvalue      := stat.I['value'];
          rec.FGameweekStats.Add(recStat);
          processStat(stat.S['identifier']);
        end;
      end;

      FGameweekElements.Add(rec);
    end;

  end;
end;

constructor TFPLGameweekElements.Create;
begin
  inherited;
  FGameweekElements := TCollections.CreateObjectList<TFPLGameweekElement>(TRUE);
end;

destructor TFPLGameweekElements.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLGameweekElements.getGameweekElements: IReadOnlyList<TFPLGameweekElement>;
begin
  result := FGameweekElements.AsReadOnlyList;
end;

{ TFPLGameweekElement }

constructor TFPLGameweekElement.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
  FGameweekStats      := TCollections.CreateObjectList<TFPLGameweekStat>(FALSE);
  FSassists           := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSbonus             := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSclean_sheets      := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSgoals_conceded    := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSgoals_scored      := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSminutes           := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSown_goals         := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSred_cards         := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSsaves             := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSyellow_cards      := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSpenalties_saved   := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
  FSpenalties_missed  := TCollections.CreateObjectList<TFPLGameweekStat>(TRUE);
end;

constructor TFPLGameweekElement.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

function TFPLGameweekElement.getGameweekStats: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FGameweekStats.AsReadOnlyList;
end;

function TFPLGameweekElement.getSassists: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSassists.AsReadOnlyList;
end;

function TFPLGameweekElement.getSbonus: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSbonus.AsReadOnlyList;
end;

function TFPLGameweekElement.getSclean_sheets: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSclean_sheets.AsReadOnlyList;
end;

function TFPLGameweekElement.getSgoals_conceded: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSgoals_conceded.AsReadOnlyList;
end;

function TFPLGameweekElement.getSgoals_scored: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSgoals_scored.AsReadOnlyList;
end;

function TFPLGameweekElement.getSminutes: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSminutes.AsReadOnlyList;
end;

function TFPLGameweekElement.getSown_goals: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSown_goals.AsReadOnlyList;
end;

function TFPLGameweekElement.getSpenalties_missed: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSpenalties_missed.AsReadOnlyList;
end;

function TFPLGameweekElement.getSpenalties_saved: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSpenalties_saved.AsReadOnlyList;
end;

function TFPLGameweekElement.getSred_cards: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSred_cards.AsReadOnlyList;
end;

function TFPLGameweekElement.getSsaves: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSsaves.AsReadOnlyList;
end;

function TFPLGameweekElement.getSyellow_cards: IReadOnlyList<TFPLGameweekStat>;
begin
  result := FSyellow_cards.AsReadOnlyList;
end;

{ TFPLGameweekStat }

constructor TFPLGameweekStat.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLGameweekStat.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
