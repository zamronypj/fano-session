(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit AuthController;

interface

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * POST /signin
     *
     * See Routes/SignIn/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TAuthController = class(TRouteHandler)
    private
        fSession : ISession;
    public
        constructor create(
            const beforeMiddlewares : IMiddlewareCollection;
            const afterMiddlewares : IMiddlewareCollection;
            const session : ISession
        );

        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

    constructor TAuthController.create(
        const beforeMiddlewares : IMiddlewareCollection;
        const afterMiddlewares : IMiddlewareCollection;
        const session : ISession
    );
    begin
        inherited create(beforeMiddlewares, afterMiddlewares);
        fSession := session;
    end;

    destructor TAuthController.destroy();
    begin
        fSession := nil;
        inherited destroy();
    end;

    function TAuthController.handleRequest(
          const request : IRequest;
          const response : IResponse
    ) : IResponse;
    var username, password : string;
    begin
        username := request.getParsedBodyParam('username');
        password := request.getParsedBodyParam('password');
        if (username = 'hello') and (password = 'world') then
        begin
            fSession.setVar('userSignedIn', 'true');
        end else
        begin
            fSession.delete('userSignedIn');
        end;
        result := TRedirectResponse.create(
            response.headers(),
            'http://fano-session.zamroni/'
        );
    end;

end.
