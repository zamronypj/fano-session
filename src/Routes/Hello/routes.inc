(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

//protect hello controller so that
//only signed in user can access it otherwise it will redirect to sign in page
router.get(
    '/hello',
    container.get('helloController') as IRouteHandler
).addBefore(container.get('authOnlyMiddleware') as IMiddleware);
