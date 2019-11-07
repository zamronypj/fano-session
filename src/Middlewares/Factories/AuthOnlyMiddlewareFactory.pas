(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-middleware
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-middleware/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit AuthOnlyMiddlewareFactory;

interface

uses
    fano;

type

    TAuthOnlyMiddlewareFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    AuthOnlyMiddleware;

    function TAuthOnlyMiddlewareFactory.build(const container : IDependencyContainer) : IDependency;
    var config : IAppConfiguration;
        baseUrl : string;
    begin
        config := container.get('config') as IAppConfiguration;
        baseUrl := config.getString('baseUrl');
        result := TAuthOnlyMiddleware.create(
            container.get('sessionManager') as IReadOnlySessionManager,
            baseUrl + '/signin'
        );
    end;
end.
