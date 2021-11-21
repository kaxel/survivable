RailsAdmin.config do |config|
  
  config.main_app_name = ["Survivable", "BackOffice"]
  # or something more dynamic
  config.main_app_name = Proc.new { |controller| [ "Survivable", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }

  ### Popular gems integration

  ## == Devise ==
  RailsAdmin.config do |config|
    config.authenticate_with do
      warden.authenticate! scope: :admin
    end
    config.current_user_method(&:current_admin)
  end

  ## == CancanCan ==
  # RailsAdmin.config do |config|
  #   config.authorize_with :cancancan
  # end

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  


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
