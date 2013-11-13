# Based on https://github.com/evrone/quiet_assets/blob/master/lib/quiet_assets.rb

class QuietAssets
  include LoggerSilence

  def initialize app
    @app = app
  end

  def call env
    if asset_request? env['PATH_INFO']
      silence { @app.call env }
    else
      @app.call env
    end
  end

  private

  def logger
    Rails.logger
  end
  delegate :level, :level=, to: :logger

  def asset_request? path
    path.start_with? assets_prefix
  end

  def assets_prefix
    Rails.configuration.assets.prefix
  end
end