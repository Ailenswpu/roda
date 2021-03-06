class Roda
  module RodaPlugins
    # The view_subdirs plugin is designed for sites that have
    # outgrown a flat view directory and use subdirectories
    # for views.  It allows you to set the view directory to
    # use, and template names that do not contain a slash will
    # automatically use that view subdirectory.  Example:
    #
    #   plugin :render
    #   plugin :view_subdirs
    #
    #   route do |r|
    #     r.on "users" do
    #       set_view_subdir 'users'
    #       
    #       r.get :id do
    #         view 'profile' # uses ./views/users/profile.erb
    #       end
    #
    #       r.get 'list' do
    #         view 'lists/users' # uses ./views/lists/users.erb
    #       end
    #     end
    #   end
    #
    # This plugin should be loaded after the render plugin, since
    # it works by overriding parts of the render plugin.
    module ViewSubdirs
      module InstanceMethods
        # Set the view subdirectory to use.  This can be set to nil
        # to not use a view subdirectory.
        def set_view_subdir(v)
          @_view_subdir = v
        end

        private

        # Override the template name to use the view subdirectory if the
        # there is a view subdirectory and the template name does not
        # contain a slash.
        def template_path(template, opts)
          t = template.to_s
          if (v = @_view_subdir) && t !~ /\//
            template = "#{v}/#{t}"
          end
          super
        end
      end
    end

    register_plugin(:view_subdirs, ViewSubdirs)
  end
end
