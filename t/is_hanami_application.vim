runtime! plugin/vim-open-alternate.vim

call vspec#hint({'scope': 'VimOpenAlternateScope()', 'sid': 'VimOpenAlternateSid()'})

describe 's:IsHanamiAppImplementationFile'
  before
    call writefile([], "config/routes.rb", "")
    call writefile([], "config/application.rb", "")
    call writefile([], "config/environment.rb", "")
    call mkdir("app", "")
  end

  after
    call delete("config/routes.rb")
    call delete("config/application.rb")
    call delete("config/environment.rb")
    call system("rm -r app")
  end

  context 'when given a hanami application controller file path'
    it 'returns true'
      Expect vspec#call('s:IsHanamiAppImplementationFile', 'app/controllers/application.rb') == 1
    end
  end

  context 'when given a hanami application view file path'
    it 'returns true'
      Expect vspec#call('s:IsHanamiAppImplementationFile', 'app/views/application_layout.rb') == 1
    end
  end
end
