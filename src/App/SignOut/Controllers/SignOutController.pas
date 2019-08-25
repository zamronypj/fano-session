(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SignOutController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /signout
     *
     * See Routes/SignOut/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TSignOutController = class(TRouteHandler)
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

    constructor TSignOutController.create(
        const aMiddlewares : IMiddlewareCollectionAware;
        const session : ISessionManager;
        const targetUrl : string
    );
    begin
        inherited create(aMiddlewares);
        fSession := session;
        fTargetUrl := targetUrl;
    end;

    destructor TSignOutController.destroy();
    begin
        fSession := nil;
        inherited destroy();
    end;

    function TSignOutController.handleRequest(
          const request : IRequest;
          const response : IResponse
    ) : IResponse;
    var
        sess : ISession;
    begin
        sess := fSession.getSession(request);
        try
            sess.delete('userSignedIn');
            result := TRedirectResponse.create(response.headers(), fTargetUrl);
        finally
            sess := nil;
        end;
    end;

end.
