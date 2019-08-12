(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HomeViewFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view THomeView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THomeViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *};

    function THomeViewFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TTemplateView.create(
            'resources/Templates/Home/index.html',
            TSimpleTemplateParser.create('{{', '}}'),
            TStringFileReader.create()
        );
    end;
end.
