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

    TAppServiceProvider = class(TDaemonAppServiceProvider)
    protected
        function buildAppConfig(const ctnr : IDependencyContainer) : IAppConfiguration; override;

        function buildErrorHandler(
            const ctnr : IDependencyContainer;
            const config : IAppConfiguration
        ) : IErrorHandler; override;

        function buildDispatcher(
            const ctnr : IDependencyContainer;
            const routeMatcher : IRouteMatcher;
            const config : IAppConfiguration
        ) : IDispatcher; override;
    public
        procedure register(const container : IDependencyContainer); override;
    end;

    TAppRoutes = class(TRouteBuilder)
    public
        procedure buildRoutes(
            const container : IDependencyContainer;
            const router : IRouter
        ); override;
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

    function TAppServiceProvider.buildAppConfig(const ctnr : IDependencyContainer) : IAppConfiguration;
    begin
        ctnr.add(
            'config',
            TJsonFileConfigFactory.create(
                getCurrentDir() + '/config/config.json'
            )
        );
        result := ctnr.get('config') as IAppConfiguration;
    end;

    function TAppServiceProvider.buildErrorHandler(
        const ctnr : IDependencyContainer;
        const config : IAppConfiguration
    ) : IErrorHandler;
    var factory : IDependencyFactory;
        basedir : string;
    begin
        baseDir := getCurrentDir() + '/resources/Templates/Error/';
        factory := TProdOrDevErrorHandlerFactory.create(
            baseDir + '404.html',
            baseDir + '500.html',
            config.getBool('isProduction')
        );
        result := factory.build(ctnr) as IErrorHandler;
    end;

    function TAppServiceProvider.buildDispatcher(
        const ctnr : IDependencyContainer;
        const routeMatcher : IRouteMatcher;
        const config : IAppConfiguration
    ) : IDispatcher;
    begin
        ctnr.add('appMiddlewares', TMiddlewareListFactory.create());

        ctnr.add(
            'sessionManager',
            TJsonFileSessionManagerFactory.create(
                config.getString('session.name'),
                config.getString('session.dir')
            ).sessionIdGenerator(
                TSha2KeyRandSessionIdGeneratorFactory.create(
                    config.getString('secretKey')
                )
            )
        );

        ctnr.add(
            GuidToString(IDispatcher),
            TSessionDispatcherFactory.create(
                ctnr.get('appMiddlewares') as IMiddlewareLinkList,
                routeMatcher,
                TRequestResponseFactory.create(),
                ctnr.get('sessionManager') as ISessionManager,
                (TCookieFactory.create()).domain(config.getString('cookie.domain')),
                config.getInt('cookie.maxAge')
            )
        );
        result := ctnr.get(GuidToString(IDispatcher)) as IDispatcher;
    end;

    procedure TAppServiceProvider.register(const container : IDependencyContainer);
    begin
        {$INCLUDE Dependencies/dependencies.inc}
    end;

    procedure TAppRoutes.buildRoutes(
        const container : IDependencyContainer;
        const router : IRouter
    );
    begin
        {$INCLUDE Routes/routes.inc}
    end;

end.
