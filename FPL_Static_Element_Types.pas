unit FPL_Static_Element_Types;

interface

uses
  SuperObject, Spring.Collections;

type
  TFPLStaticElementType = class
  private
    Fid: integer;
    Fsingular_name:        string;
    Fsingular_name_short:  string;
    Fplural_name:          string;
    Fplural_name_short:    string;
    Fsquad_select:         integer;
    Fsquad_min_play:       integer;
    Fsquad_max_play:       integer;
    Fui_shirt_specific:    boolean;
    Fsub_positions_locked: string;
    Felement_count:        integer;
  protected
    // This overloaded constructor only allows this class to be instantiated from within this unit
    constructor Create(const aOK: string = 'OK'); overload;
  public
    // This class cannot be instantiated from outside of this unit
    constructor Create; overload; deprecated 'DO NOT USE!';
    property id:                    integer read Fid;
    property singular_name:         string  read Fsingular_name;
    property singular_name_short:   string  read Fsingular_name_short;
    property plural_name:           string  read Fplural_name;
    property plural_name_short:     string  read Fplural_name_short;
    property squad_select:          integer read Fsquad_select;
    property squad_min_play:        integer read Fsquad_min_play;
    property squad_max_play:        integer read Fsquad_max_play;
    property ui_shirt_specific:     boolean read Fui_shirt_specific;
    property sub_positions_locked:  string  read Fsub_positions_locked;
    property element_count:         integer read Felement_count;
  end;

  IFPLStaticElementTypes = interface
    function build(aSO: ISuperObject):  boolean;
    function getStaticElementTypes:     IReadOnlyList<TFPLStaticElementType>;
    property ElementTypes:              IReadOnlyList<TFPLStaticElementType> read getStaticElementTypes;
  end;

function FPLStaticElementTypes: IFPLStaticElementTypes;

implementation

uses
  System.SysUtils;

type
  TFPLStaticElementTypes = class(TInterfacedObject, IFPLStaticElementTypes)
  strict private
    FStaticElementTypes:                IList<TFPLStaticElementType>;
  private
    function getStaticElementTypes:     IReadOnlyList<TFPLStaticElementType>;
  public
    constructor Create;
    destructor  Destroy; override;
    function build(aSO: ISuperObject):  boolean;
    property ElementTypes:              IReadOnlyList<TFPLStaticElementType> read getStaticElementTypes;
  end;

var gInstance: IFPLStaticElementTypes;

function FPLStaticElementTypes: IFPLStaticElementTypes;
begin
  case gInstance = NIL of TRUE: gInstance := TFPLStaticElementTypes.Create; end;
  result := gInstance;
end;

{ TFPLStaticElementTypes }

function TFPLStaticElementTypes.build(aSO: ISuperObject): boolean;
var
  so:   ISuperObject;
  rec:  TFPLStaticElementType;
begin
  FStaticElementTypes.Clear;

  for so in aSO do begin
    rec := TFPLStaticElementType.Create('OK');

    rec.FID                    := so.I['id'];
    rec.Fsingular_name         := so.S['singular_name'];
    rec.Fsingular_name_short   := so.S['singular_name_short'];
    rec.Fplural_name           := so.S['plural_name'];
    rec.Fplural_name_short     := so.S['plural_name_short'];
    rec.Fsquad_select          := so.I['squad_select'];
    rec.Fsquad_min_play        := so.I['squad_min_play'];
    rec.Fsquad_max_play        := so.I['squad_max_play'];
    rec.Fui_shirt_specific     := so.B['ui_shirt_specific'];
    rec.Fsub_positions_locked  := so.S['sub_positions_locked'];
    rec.Felement_count         := so.I['element_count'];

    FStaticElementTypes.Add(rec);
  end;
end;

constructor TFPLStaticElementTypes.Create;
begin
  inherited;
  FStaticElementTypes := TCollections.CreateObjectList<TFPLStaticElementType>(TRUE);
end;

destructor TFPLStaticElementTypes.Destroy;
begin
  // nowt to do
  inherited;
end;

function TFPLStaticElementTypes.getStaticElementTypes: IReadOnlyList<TFPLStaticElementType>;
begin
  result := FStaticElementTypes.AsReadOnlyList;
end;

{ TFPLStaticElementType }

constructor TFPLStaticElementType.Create;
// This class cannot be instantiated from outside of this unit
begin
  raise EProgrammerNotFound.Create('DO NOT USE THIS CONSTRUCTOR!');
end;

constructor TFPLStaticElementType.Create(const aOK: string);
// This overloaded constructor only allows this class to be instantiated from within this unit
begin
  inherited Create;
end;

initialization
  gInstance := NIL;

finalization
  gInstance := NIL;

end.
