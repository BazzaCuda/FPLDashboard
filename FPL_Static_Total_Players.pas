unit FPL_Static_Total_Players;

interface

uses
  SuperObject, Spring.Collections;

type
  TStaticTotalPlayer = class
  private
    Ftotal_players: integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property total_players: integer read Ftotal_players;
  end;

  IFPLStaticTotalPlayers = interface
    function build(aSO: ISuperObject):  boolean;
    function getStaticTotalPlayer:      TStaticTotalPlayer;
    property TotalPlayers:              TStaticTotalPlayer read getStaticTotalPlayer;
  end;

function FPLStaticTotalPlayers: IFPLStaticTotalPlayers;

implementation

uses
  System.SysUtils;

type
  TFPLStaticTotalPlayers = class(TInterfacedObject, IFPLStaticTotalPlayers)
  strict private
    FStaticTotalPlayer:                TStaticTotalPlayer;
  private
    function getStaticTotalPlayer:     TStaticTotalPlayer;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property TotalPlayers:              TStaticTotalPlayer read getStaticTotalPlayer;
  end;

var gInstance: IFPLStaticTotalPlayers;

function FPLStaticTotalPlayers: IFPLStaticTotalPlayers;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticTotalPlayers.Create; end;
  result := gInstance;
end;

{ TFPLStaticTotalPlayers }

function TFPLStaticTotalPlayers.build(aSO: ISuperObject): boolean;
var
  rec:  TStaticTotalPlayer;
begin
  rec := TStaticTotalPlayer.Create('OK');

  rec.Ftotal_players := aSO.AsInteger;

  FStaticTotalPlayer := rec;
end;

constructor TFPLStaticTotalPlayers.Create;
begin
  inherited;
end;

destructor TFPLStaticTotalPlayers.Destroy;
begin
  case FStaticTotalPlayer <> NIL of TRUE: FStaticTotalPlayer.Free; end;
  inherited;
end;

function TFPLStaticTotalPlayers.getStaticTotalPlayer: TStaticTotalPlayer;
begin
  result := FStaticTotalPlayer;
end;

{ TFPLStaticTotalPlayer }

constructor TStaticTotalPlayer.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TStaticTotalPlayer.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
