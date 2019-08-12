(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}

{-----------------------------------------------
  setup global view parameters
------------------------------------------------}
container.add('viewParams', TViewParametersFactory.create());

container.add('homeView', THomeViewFactory.create());
container.add('signinView', TSignInViewFactory.create());
