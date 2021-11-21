RailsAdmin.config do |config|
  
  config.main_app_name = ["Survivable", "BackOffice"]
  # or something more dynamic
  config.main_app_name = Proc.new { |controller| [ "Survivable", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  
      config.authorize_with do |controller|
        if Current.user.nil?
          redirect_to main_app.root_path, notice: 'Please Login to Continue...'
        elsif !Current.user.admin?
          redirect_to main_app.root_path, notice: 'You are not Admin bro!'
        end
      end

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
