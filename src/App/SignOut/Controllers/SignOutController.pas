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
    TSignOutController = class(TAbstractController)
    private
        fSession : IReadOnlySessionManager;
        fTargetUrl : string;
    public
        constructor create(
            const session : IReadOnlySessionManager;
            const targetUrl : string
        );

        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

    constructor TSignOutController.create(
        const session : IReadOnlySessionManager;
        const targetUrl : string
    );
    begin
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
        const response : IResponse;
        const args : IRouteArgsReader
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
