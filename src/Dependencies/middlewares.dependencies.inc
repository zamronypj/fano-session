(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-middleware
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-middleware/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)

{-----------------------------------------------
  register SessionBeginMiddleware  inside
  dependency container
------------------------------------------------}
container.add(
    'sessionBeginMiddleware',
    TSessionBeginMiddlewareFactory.create(
        container.get('sessionManager') as ISessionManager,
        3600
    )
);

container.add(
    'sessionEndMiddleware',
    TSessionEndMiddlewareFactory.create(
        container.get('sessionManager') as ISessionManager
    )
);

{-----------------------------------------------
  register AuthOnlyMiddleware  inside
  dependency container
------------------------------------------------}
container.add('authOnlyMiddleware', TAuthOnlyMiddlewareFactory.create());

{-----------------------------------------------
  register AuthOnlyMiddleware  inside
  dependency container
------------------------------------------------}

container.get('appMiddlewares')
    .addBefore(container.get('sessionBeginMiddleware') as IMiddleware);
    .addAfter(container.get('sessionEndMiddleware') as IMiddleware);
