(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SignInControllerFactory;

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
    TSignInControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    SignInController;

    function TSignInControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TSignInController.create(
            container.get('signinView') as IView,
            container.get('viewParams') as IViewParameters
        );
    end;
end.
