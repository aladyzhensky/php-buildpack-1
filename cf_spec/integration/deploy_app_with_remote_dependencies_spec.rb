$: << 'cf_spec'
require 'cf_spec_helper'

describe 'CF PHP Buildpack' do
  subject(:app) { Machete.deploy_app(app_name) }
  let(:browser) { Machete::Browser.new(app) }

  after do
    Machete::CF::DeleteApp.new.execute(app)
  end

  context 'the application has remote dependencies', if: Machete::BuildpackMode.online? do
    let(:app_name) { 'app_with_remote_dependencies' }

    specify do
      expect(app).to be_running

      browser.visit_path("/")
      expect(browser).to have_body 'App with remote dependencies running'

      assert_offline_mode_has_no_internet_traffic
    end
  end
end

