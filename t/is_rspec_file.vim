runtime! plugin/vim-open-alternate.vim

call vspec#hint({'scope': 'VimOpenAlternateScope()', 'sid': 'VimOpenAlternateSid()'})

describe 's:IsRSpecFile'
  context 'when given a path to an rspec file'
    it 'it returns true'
      Expect vspec#call('s:IsRSpecFile', 'spec/hoopty/doopty_spec.rb') to_be_true
    end
  end

  context 'when given a path to a non-rspec file'
    it 'it returns false'
      Expect vspec#call('s:IsRSpecFile', 'app/hoopty/doopty.rb') to_be_false
    end
  end
end
