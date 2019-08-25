(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit AuthController;

interface

{$MODE OBJFPC}
{$H+}

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
        fSession : ISessionManager;
        fTargetUrl : string;
    public
        constructor create(
            const aMiddlewares : IMiddlewareCollectionAware;
            const session : ISessionManager;
            const targetUrl : string
        );

        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

    constructor TAuthController.create(
        const aMiddlewares : IMiddlewareCollectionAware;
        const session : ISessionManager;
        const targetUrl : string
    );
    begin
        inherited create(aMiddlewares);
        fSession := session;
        fTargetUrl := targetUrl;
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
    var username, password, targetUrl : string;
        sess : ISession;
    begin
        sess := fSession.getSession(request);
        try
            sess.delete('userSignedIn');
            username := request.getParsedBodyParam('username');
            password := request.getParsedBodyParam('password');
            if (username = 'hello') and (password = 'world') then
            begin
                sess.setVar('userSignedIn', 'true');
                targetUrl := request.getParsedBodyParam('targetUrl', fTargetUrl);
                result := TRedirectResponse.create(response.headers(), targetUrl);
            end else
            begin
                response.body().write('Wrong username password combination');
            end;
        finally
            sess := nil;
        end;
    end;

end.
