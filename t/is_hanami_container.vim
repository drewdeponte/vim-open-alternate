runtime! plugin/vim-open-alternate.vim

call vspec#hint({'scope': 'VimOpenAlternateScope()', 'sid': 'VimOpenAlternateSid()'})

describe 's:IsHanamiContainerArchitecture'
  context 'when given an hanami rspec controller file path'
    it 'returns true'
      Expect vspec#call('s:IsHanamiContainerArchitecture', 'spec/web/controllers/users/create_spec.rb') == 1
    end
  end

  context 'when given an hanami rspec views file path'
    it 'returns true'
      Expect vspec#call('s:IsHanamiContainerArchitecture', 'spec/web/views/application_layout_spec.rb') == 1
    end
  end

  context 'when given a hanami container app controller file path'
    it 'returns true'
      Expect vspec#call('s:IsHanamiContainerArchitecture', 'apps/web/controllers/application_layout_spec.rb') == 1
    end
  end

  context 'when given a hanami container app view file path'
    it 'returns true'
      Expect vspec#call('s:IsHanamiContainerArchitecture', 'apps/web/views/application_layout_spec.rb') == 1
    end
  end
end
