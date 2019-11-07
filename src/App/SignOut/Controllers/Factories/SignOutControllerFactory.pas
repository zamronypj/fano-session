(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SignOutControllerFactory;

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
    TSignOutControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    SignOutController;

    function TSignOutControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var config : IAppConfiguration;
        baseUrl : string;
    begin
        config := container.get('config') as IAppConfiguration;
        baseUrl := config.getString('baseUrl');
        result := TSignOutController.create(
            container.get('sessionManager') as IReadOnlySessionManager,
            baseUrl + '/signin'
        );
    end;
end.
