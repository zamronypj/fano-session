(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

 {-----------------------------------------------
   register middleware list for each routes that
   does nothing,
   need to be use factory so each route will have
   different middleware list
   Replace with TMiddlewareCollectionAwareFactory to support middleware
   or replace with your own implementation if required
 ------------------------------------------------}
container.add('appMiddlewares', TMiddlewareCollectionAwareFactory.create());
container.factory('routeMiddlewares', TMiddlewareCollectionAwareFactory.create());

container.add(
    'sessionManager',
    TJsonFileSessionManagerFactory.create(
        'fano_sess',
        'storages/sessions/'
    )
);

container.add(
    GuidToString(IDispatcher),
    TSessionDispatcherFactory.create(
        container.get('appMiddlewares') as IMiddlewareCollectionAware,
        container.get(GuidToString(IRouteMatcher)) as IRouteMatcher,
        TRequestResponseFactory.create(),
        container.get('sessionManager') as ISessionManager,
        (TCookieFactory.create()).domain('fano-session.zamroni'),
        3600
    )
);
