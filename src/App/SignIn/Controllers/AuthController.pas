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
    public
        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

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
