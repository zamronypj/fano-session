(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit bootstrap;

interface

uses

    fano;

type

    TBootstrapApp = class(TSimpleScgiWebApplication)
    protected
        procedure buildDependencies(const container : IDependencyContainer); override;
        procedure buildRoutes(const container : IDependencyContainer); override;
    end;

implementation

uses
    sysutils

    (*! -------------------------------
     *   controllers factory
     *----------------------------------- *)
    {---- put your controller factory here ---},
    HomeControllerFactory,
    HomeViewFactory,
    SignInControllerFactory,
    SignInViewFactory,
    AuthControllerFactory,
    AuthViewFactory,
    SignOutControllerFactory,
    AuthOnlyMiddlewareFactory;


    procedure TBootstrapApp.buildDependencies(const container : IDependencyContainer);
    var config : IAppConfiguration;
    begin
        {$INCLUDE Dependencies/dependencies.inc}
    end;

    procedure TBootstrapApp.buildRoutes(const container : IDependencyContainer);
    var router : IRouter;
    begin
        router := container.get(GUIDToString(IRouter)) as IRouter;
        try
            {$INCLUDE Routes/routes.inc}
        finally
            router := nil;
        end;
    end;

end.
