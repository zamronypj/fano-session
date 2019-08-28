(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{-----------------------------------------------
  register application configuration
------------------------------------------------}
container.add(
    'config',
    TJsonFileConfigFactory.create(
        getCurrentDir() + '/config/config.json'
    )
);
config := container.get('config') as IAppConfiguration;

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
        config.getString('session.name'),
        config.getString('session.dir')
    )
);

container.add(
    GuidToString(IDispatcher),
    TSessionDispatcherFactory.create(
        container.get('appMiddlewares') as IMiddlewareCollectionAware,
        container.get(GuidToString(IRouteMatcher)) as IRouteMatcher,
        TRequestResponseFactory.create(),
        container.get('sessionManager') as ISessionManager,
        (TCookieFactory.create()).domain(config.getString('cookie.domain')),
        config.getInt('cookie.maxAge')
    )
);
