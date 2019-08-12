(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-session
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-middleware/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit AuthOnlyMiddleware;

interface

uses

    fano;

type

    (*!------------------------------------------------
     * middleware implementation that pass request ony if user
     * is signed in
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *-------------------------------------------------*)
    TAuthOnlyMiddleware = class(TInterfacedObject, IMiddleware, IDependency)
    private
        fSession : ISession;
        fTargetUrlRedirect : string;
    public
        constructor create(const session : ISession; const redirectUrl : string);
        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            var canContinue : boolean
        ) : IResponse;
    end;

implementation

    constructor TAuthOnlyMiddleware.create(const session : ISession; const redirectUrl : string);
    begin
        inherited create();
        fSession := session;
        fTargetUrlRedirect : redirectUrl;
    end;

    destructor TAuthOnlyMiddleware.destroy();
    begin
        fSession := nil;
        inherited destroy();
    end;

    function TAuthOnlyMiddleware.handleRequest(
          const request : IRequest;
          const response : IResponse;
          var canContinue : boolean
    ) : IResponse;
    begin
        canContinue := fSession.has('userSignedIn');
        if (canContinue) then
        begin
            result := response;
        end else
        begin
            result := TRedirectResponse.create(
                response.headers(),
                fTargetUrlRedirect
            );
        end;
    end;

end.
