unit FPL_Static_Teams;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLStaticTeam = class
  private
    Fstrength_overall_home: integer;
    Fwin: integer;
    Fname: string;
    Fpulse_id: integer;
    Fshort_name: string;
    Fcode: integer;
    Fstrength: integer;
    Fstrength_attack_away: integer;
    Fstrength_overall_away: integer;
    Fdraw: integer;
    Fform: string;
    Fid: integer;
    Fplayed: integer;
    Fstrength_defence_home: integer;
    Fpoints: integer;
    Floss: integer;
    Funavailable: boolean;
    Fteam_division: string;
    Fposition: integer;
    Fstrength_defence_away: integer;
    Fstrength_attack_home: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property id:                    integer read Fid;
    property name:                  string  read Fname;
    property pulse_id:              integer read Fpulse_id;
    property win:                   integer read Fwin;
    property strength_attack_home:  integer read Fstrength_attack_home;
    property strength_attack_away:  integer read Fstrength_attack_away;
    property position:              integer read Fposition;
    property short_name:            string  read Fshort_name;
    property strength:              integer read Fstrength;
    property strength_overall_home: integer read Fstrength_overall_home;
    property strength_overall_away: integer read Fstrength_overall_away;
    property points:                integer read Fpoints;
    property team_division:         string  read Fteam_division;
    property strength_defence_home: integer read Fstrength_defence_home;
    property strength_defence_away: integer read Fstrength_defence_away;
    property played:                integer read Fplayed;
    property unavailable:           boolean read Funavailable;
    property loss:                  integer read Floss;
    property form:                  string  read Fform;
    property draw:                  integer read Fdraw;
    property code:                  integer read Fcode;
  end;

  IFPLStaticTeams = interface
    function build(aSO: ISuperObject):  boolean;
    function getStaticTeams:     IReadOnlyList<TFPLStaticTeam>;
    property Teams:              IReadOnlyList<TFPLStaticTeam> read getStaticTeams;
  end;

function FPLStaticTeams: IFPLStaticTeams;

implementation

uses
  System.SysUtils;

type
  TFPLStaticTeams = class(TInterfacedObject, IFPLStaticTeams)
  strict private
    FStaticTeams:                IList<TFPLStaticTeam>;
  private
    function getStaticTeams:     IReadOnlyList<TFPLStaticTeam>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property Teams:              IReadOnlyList<TFPLStaticTeam> read getStaticTeams;
  end;

var gInstance: IFPLStaticTeams;

function FPLStaticTeams: IFPLStaticTeams;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticTeams.Create; end;
  result := gInstance;
end;

{ TFPLStaticTeams }

function TFPLStaticTeams.build(aSO: ISuperObject): boolean;
var
  so:   ISuperObject;
  rec:  TFPLStaticTeam;
begin
  FStaticTeams.Clear;

  for so in aSO do begin
    rec := TFPLStaticTeam.Create('OK');

    rec.Fstrength_overall_home  := so.I['strength_overall_home'];
    rec.Fwin                    := so.I['win'];
    rec.Fname                   := so.S['name'];
    rec.Fpulse_id               := so.I['pulse_id'];
    rec.Fshort_name             := so.S['short_name'];
    rec.Fcode                   := so.I['code'];
    rec.Fstrength               := so.I['strength'];
    rec.Fstrength_attack_away   := so.I['strength_attack_away'];
    rec.Fstrength_overall_away  := so.I['strength_overall_away'];
    rec.Fdraw                   := so.I['draw'];
    rec.Fform                   := so.S['form'];
    rec.Fid                     := so.I['id'];
    rec.Fplayed                 := so.I['played'];
    rec.Fstrength_defence_home  := so.I['strength_defence_home'];
    rec.Fpoints                 := so.I['points'];
    rec.Floss                   := so.I['loss'];
    rec.Funavailable            := so.B['unavailable'];
    rec.Fteam_division          := so.S['team_division'];
    rec.Fposition               := so.I['position'];
    rec.Fstrength_defence_away  := so.I['strength_defence_away'];
    rec.Fstrength_attack_home   := so.I['strength_attack_home'];

    FStaticTeams.Add(rec);
  end;
end;

constructor TFPLStaticTeams.Create;
begin
  inherited;
  FStaticTeams := TCollections.CreateObjectList<TFPLStaticTeam>(TRUE);
end;

destructor TFPLStaticTeams.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLStaticTeams.getStaticTeams: IReadOnlyList<TFPLStaticTeam>;
begin
  result := FStaticTeams.AsReadOnlyList;
end;

{ TFPLStaticTeam }

constructor TFPLStaticTeam.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLStaticTeam.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
