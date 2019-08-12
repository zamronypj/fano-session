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
    TAuthController = class(TRouteHandler, IDependency)
    private
        fSession : ISessionManager;
    public
        constructor create(
            const beforeMiddlewares : IMiddlewareCollection;
            const afterMiddlewares : IMiddlewareCollection;
            const session : ISessionManager
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
        const session : ISessionManager
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
        sess : ISession;
    begin
        sess := fSession.beginSession(request, 3600);
        username := request.getParsedBodyParam('username');
        password := request.getParsedBodyParam('password');
        if (username = 'hello') and (password = 'world') then
        begin
            sess.setVar('userSignedIn', 'true');
        end else
        begin
            sess.delete('userSignedIn');
        end;
        result := TRedirectResponse.create(
            response.headers(),
            'http://fano-session.zamroni/'
        );
        fSession.endSession(sess);
    end;

end.
