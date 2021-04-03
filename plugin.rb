# name: discourse-webhook-user-activated
# about: Fires a user_activated webhook when a user is activated.
# version: 1.0
# authors: Wilson29thID (wilson@29th.org)
# url: https://github.com/29th/discourse-webhook-user-activated

PLUGIN_NAME = "discourse_user_activated_webhook".freeze

enabled_site_setting :discourse_user_activated_webhook_enabled

after_initialize do
  add_model_callback(User, :after_update) do
    if saved_change_to_active && active == true && email_confirmed?
      WebHook.enqueue_object_hooks(:user, self, "user_activated")
    end
  end
end
