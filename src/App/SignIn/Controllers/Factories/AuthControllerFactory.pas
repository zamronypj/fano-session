(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit AuthControllerFactory;

interface

{$MODE OBJFPC}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TSignInController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TAuthControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    AuthController;

    function TAuthControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TAuthController.create(
            container.get('routeMiddlewares') as IMiddlewareCollectionAware,
            container.get('sessionManager') as ISessionManager,
            'http://fano-session.zamroni/'
        );
    end;
end.
