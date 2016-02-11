runtime! plugin/vim-open-alternate.vim

call vspec#hint({'scope': 'VimOpenAlternateScope()', 'sid': 'VimOpenAlternateSid()'})

describe 's:RemoveLeadingDotSlash'
  it 'removes the leading dot slash from the given path'
    Expect vspec#call('s:RemoveLeadingDotSlash', './spec/controllers/tasks_controller_spec.rb') == 'spec/controllers/tasks_controller_spec.rb'
  end

  it 'leaves paths without leading dot slash alone'
    Expect vspec#call('s:RemoveLeadingDotSlash', 'spec/controllers/tasks_controller_spec.rb') == 'spec/controllers/tasks_controller_spec.rb'
  end
end

describe 's:AlternateFileFor'
  context 'Cucumber support'
    context 'when path is a Cucumber feature file'
      it 'returns the paired step definition file'
        Expect vspec#call('s:AlternateFileFor', 'features/project_management.feature') == 'features/step_definitions/project_management_steps.rb'
      end
    end

    context 'when path is a Cucumber step definition file'
      it 'returns the paired Cucumber feature file'
        Expect vspec#call('s:AlternateFileFor', 'features/step_definitions/project_management_steps.rb') == 'features/project_management.feature'
      end
    end
  end

  context 'JavaScript Jasmine Support'
    context 'when path is a javascript spec file'
      it 'returns the paired javascript implementation files'
        Expect vspec#call('s:AlternateFileFor', 'spec/foo/bar/jacked_spec.js') == 'foo/bar/jacked.js'
      end
    end

    context 'when path is a javascript implementation file'
      it 'returns the paired javascript spec files'
        Expect vspec#call('s:AlternateFileFor', 'foo/bar/jacked.js') == 'spec/foo/bar/jacked_spec.js'
      end
    end
  end

  context 'Elixir ExUnit support'
    context 'when path is a ex unit test file'
      it 'returns the paired elixir implementation'
        Expect vspec#call('s:AlternateFileFor', 'test/lib/my_awesome_app/supervisor_test.exs') == 'lib/my_awesome_app/supervisor.ex'
      end
    end

    context 'when path is an elixir implementation file'
      it 'returns the paired ExUnit test file'
        Expect vspec#call('s:AlternateFileFor', 'lib/my_awesome_app/supervisor.ex') == 'test/lib/my_awesome_app/supervisor_test.exs'
      end
    end
  end

  context 'Hanami Container RSpec support'
    context 'when path is a controller RSpec file'
      it 'returns the paired controller implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/web/controllers/users/create_spec.rb') == 'apps/web/controllers/users/create.rb'
      end
    end

    context 'when path is a controller implementation file'
      it 'returns the paired controller RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'apps/web/controllers/users/create.rb') == 'spec/web/controllers/users/create_spec.rb'
      end
    end

    context 'when path is a view RSpec file'
      it 'returns the paired view implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/web/views/users/create_spec.rb') == 'apps/web/views/users/create.rb'
      end
    end

    context 'when path is a view implementation file'
      it 'returns the paired view RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'apps/web/views/users/create.rb') == 'spec/web/views/users/create_spec.rb'
      end
    end

    context 'when path is a lib RSpec file'
      it 'returns the paired lib implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/foo/bar/car/my_lib_spec.rb') == 'lib/foo/bar/car/my_lib.rb'
      end
    end

    context 'when path is a lib implementation file'
      it 'returns the paired lib RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'lib/foo/bar/car/my_lib.rb') == 'spec/foo/bar/car/my_lib_spec.rb'
      end
    end

    context 'when path is a app implementation file'
      it 'returns the paired app RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'apps/offer_service/fulfiller.rb') == 'spec/offer_service/fulfiller_spec.rb'
      end
    end

    " context 'when path is app RSpec file'
    "   it 'returns the paired app implementation file'
    "     Expect vspec#call('s:AlternateFileFor', 'spec/offer_service/fulfiller_spec.rb') == 'apps/offer_service/fulfiller.rb'
    "   end
    " end
  end

  context 'Hanami App RSpec support'
    context 'when path is a controller RSpec file'
      it 'returns the paired controller implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/controllers/users/create_spec.rb') == 'app/controllers/users/create.rb'
      end
    end

    context 'when path is a controller implementation file'
      it 'returns the paired controller RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/controllers/users/create.rb') == 'spec/controllers/users/create_spec.rb'
      end
    end

    context 'when path is a view RSpec file'
      it 'returns the paired view implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/views/users/create_spec.rb') == 'app/views/users/create.rb'
      end
    end

    context 'when path is a view implementation file'
      it 'returns the paired view RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/views/users/create.rb') == 'spec/views/users/create_spec.rb'
      end
    end

    context 'when path is a lib RSpec file'
      it 'returns the paired lib implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/foo/bar/car/my_lib_spec.rb') == 'lib/foo/bar/car/my_lib.rb'
      end
    end

    context 'when path is a lib implementation file'
      it 'returns the paired lib RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'lib/foo/bar/car/my_lib.rb') == 'spec/foo/bar/car/my_lib_spec.rb'
      end
    end

    context 'when path is a app implementation file'
      it 'returns the paired app RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/fulfiller.rb') == 'spec/fulfiller_spec.rb'
      end
    end

    " context 'when path is app RSpec file'
    "   it 'returns the paired app implementation file'
    "     Expect vspec#call('s:AlternateFileFor', 'spec/fulfiller_spec.rb') == 'app/fulfiller.rb'
    "   end
    " end
  end

  context 'Rails RSpec support'
    context 'when path is a controller RSpec file'
      it 'returns the paird controller implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/controllers/tasks_controller_spec.rb') == 'app/controllers/tasks_controller.rb'
      end
    end

    context 'when path is a controller implementation file'
      it 'returns the paired controller RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/controllers/tasks_controller.rb') == 'spec/controllers/tasks_controller_spec.rb'
      end
    end

    context 'when path is a model RSpec file'
      it 'returns the paired model implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/models/task_spec.rb') == 'app/models/task.rb'
      end
    end

    context 'when path is a model implementation file'
      it 'returns the paired model RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/models/task.rb') == 'spec/models/task_spec.rb'
      end
    end

    context 'when path is a helper RSpec file'
      it 'returns the paired helper implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/helpers/hoopty_spec.rb') == 'app/helpers/hoopty.rb'
      end
    end

    context 'when path is a helper implementation file'
      it 'returns the paired helper RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/helpers/hoopty.rb') == 'spec/helpers/hoopty_spec.rb'
      end
    end

    context 'when path is a mailer RSpec file'
      it 'returns the paired mailer implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/mailers/hoopty_mailer_spec.rb') == 'app/mailers/hoopty_mailer.rb'
      end
    end

    context 'when path is a mailer implementation file'
      it 'returns the paired mailer RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'app/mailers/hoopty_mailer.rb') == 'spec/mailers/hoopty_mailer_spec.rb'
      end
    end

    context 'when path is a lib RSpec file'
      it 'returns the paired lib implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/foo_spec.rb') == 'lib/foo.rb'
        cd ..
      end
    end

    context 'when path is a lib implementation file'
      it 'returns the paired lib RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'lib/foo.rb') == 'spec/foo_spec.rb'
      end
    end

    context 'when path is a rake implementation file'
      it 'returns the paired rake RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'bar/foo.rake') == 'spec/bar/foo_rake_spec.rb'
      end
    end

    context 'when path is a rake RSpec file'
      it 'returns the paired rake implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/bar/foo_rake_spec.rb') == 'bar/foo.rake'
      end
    end
  end

  context 'Ruby Gem RSpec support'
    context 'when path is a lib implementation file'
      it 'returns the paired RSpec file'
        Expect vspec#call('s:AlternateFileFor', 'lib/foo.rb') == 'spec/foo_spec.rb'
      end
    end

    context 'when path is a lib RSpec file'
      it 'returns the paired ruby implementation file'
        Expect vspec#call('s:AlternateFileFor', 'spec/foo_spec.rb') == 'lib/foo.rb'
      end
    end
  end
end
