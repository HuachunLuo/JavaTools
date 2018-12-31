unit uMsg;

interface
uses SysUtils;

type
  TMsg = class(TObject)
  private
    FCode: Integer;
    Fmsg: string;
  public
    property Code: Integer read FCode write FCode;
    property msg: string read Fmsg write Fmsg;
  end;

  TMsgMgr = class(TObject)
  public
    constructor Create;
    class function GetInstance(): TMsgMgr;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    function Error(Code: Integer; Msg: string): TMsg;
    function success: TMsg;
  end;

implementation
var
  GlobalSingle: TMsgMgr;

constructor TMsgMgr.Create;
begin

end;

function TMsgMgr.Error(Code: Integer; Msg: string): TMsg;
begin
  Result.FCode := code;
  Result.Fmsg := Msg;
end;

procedure TMsgMgr.FreeInstance;
begin
  inherited;
  GlobalSingle := nil;
end;

class function TMsgMgr.GetInstance: TMsgMgr;
begin
     if not Assigned(GlobalSingle) then
   begin
     GlobalSingle := TMsgMgr.Create();
   end;
   Result := GlobalSingle;
end;

class function TMsgMgr.NewInstance: TObject;
begin
 if not Assigned(GlobalSingle) then
    GlobalSingle := TMsgMgr(inherited NewInstance);
  Result := GlobalSingle;
end;

function TMsgMgr.success: TMsg;
begin
  Result.FCode := 200;
  Result.Fmsg := '³É¹¦';
end;

end.

