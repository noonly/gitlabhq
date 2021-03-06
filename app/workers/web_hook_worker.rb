class WebHookWorker
  include Sidekiq::Worker
  include DedicatedSidekiqQueue

  sidekiq_options retry: 4

  def perform(hook_id, data, hook_name)
    hook = WebHook.find(hook_id)
    data = data.with_indifferent_access

    WebHookService.new(hook, data, hook_name).execute
  end
end
