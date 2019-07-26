(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HelloController;

interface

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /hello
     *
     * See Routes/Hello/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THelloController = class(TRouteHandler, IDependency)
    public
        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

    function THelloController.handleRequest(
          const request : IRequest;
          const response : IResponse
    ) : IResponse;
    begin
        {---put your code here---}
        //response.body().write('nice');
        result := response;
    end;

end.
