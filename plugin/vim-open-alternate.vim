""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions to help identify types of files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:IsRSpecFile(file)
  return match(a:file, '^spec/.*_spec\.rb$') != -1
endfunction

function! s:IsRakeRSpecFile(file)
  return match(a:file, '^spec/.*_rake_spec\.rb$') != -1
endfunction

function! s:IsRakeFile(file)
  return match(a:file, '.*\.rake$') != -1
endfunction

function! s:IsCucumberFeatureFile(file)
  return match(a:file, '^features/.*\.feature$') != -1
endfunction

function! s:IsCucumberStepDefinitionFile(file)
  return match(a:file, '^features/step_definitions/.*_steps\.rb$') != -1
endfunction

function! s:IsRailsControllerModelViewAssetFile(file)
  let l:is_ruby_file =
    \ match(a:file, '^\(app\|spec\)\/controllers\/.*\.rb$') != -1 ||
    \ match(a:file, '^\(app\|spec\)\/models\/.*\.rb$') != -1 ||
    \ match(a:file, '^\(app\|spec\)\/views\/.*\.rb$') != -1 ||
    \ match(a:file, '^\(app\|spec\)\/helpers\/.*\.rb$') != -1 ||
    \ match(a:file, '^\(app\|spec\)\/mailers\/.*\.rb$') != -1
  let l:is_rails_app =
    \ filereadable('config/application.rb') &&
    \ filereadable('config/routes.rb') &&
    \ isdirectory('app')
  return is_ruby_file && is_rails_app
endfunction

function! s:IsHanamiContainerArchitecture(file)
  let l:is_ruby_file = match(a:file, '^\(apps\|spec\)\/.*\.rb$') != -1
  let l:is_hanami_container =
    \ filereadable('config/environment.rb') &&
    \ isdirectory('apps')
  return is_ruby_file && is_hanami_container
endfunction

function! s:IsHanamiAppImplementationFile(file)
  let l:is_ruby_file = match(a:file, '^\(app\|spec\)\/.*\.rb$') != -1
  let l:is_hanami_app =
    \ filereadable('config/application.rb') &&
    \ filereadable('config/routes.rb') &&
    \ filereadable("config/environment.rb") &&
    \ isdirectory('app')
  return is_ruby_file && is_hanami_app
endfunction

function! s:IsJavascriptSpecFile(file)
  return match(a:file, '^spec/.*_spec\.js$') != -1
endfunction

function! s:IsJavascriptImplementationFile(file)
  return match(a:file, '^.*\.js$') != -1
endfunction

function! s:IsExUnitTestFile(file)
  return match(a:file, '^test/.*_test\.exs$') != -1
endfunction

function! s:IsElixirImplementationFile(file)
  return match(a:file, '^.*\.ex$') != -1
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions to generate alternate files paths for test files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:AlternateFileForCucumberFeatureFile(cucumber_feature_file)
  " go to step defs file
  " features/choose_plan.feature
  let alternate_file = substitute(a:cucumber_feature_file, '\.feature$', '_steps.rb', '')
  " features/choose_plan_steps.rb
  let alternate_file = substitute(alternate_file, 'features/', 'features/step_definitions/', '')
  " features/step_definitions/choose_plan_steps.rb
  return alternate_file
endfunction

function! s:AlternateFileForRSpecFile(rspec_file)
  " go to implementation file
  let alternate_file = substitute(a:rspec_file, 'erb_spec\.rb$', 'erb', '')
  let alternate_file = substitute(alternate_file, '_spec\.rb$', '.rb', '')
  let alternate_file = substitute(alternate_file, '^spec/', '', '')
  if s:IsHanamiAppImplementationFile(a:rspec_file)
    let alternate_file = 'app/' . alternate_file
  elseif s:IsRailsControllerModelViewAssetFile(a:rspec_file)
    let alternate_file = 'app/' . alternate_file
  elseif s:IsHanamiContainerArchitecture(a:rspec_file)
    let alternate_file = 'apps/' . alternate_file
  else
    let alternate_file = 'lib/' . alternate_file
  end
  return alternate_file
endfunction

function! s:AlternateFileForRakeRSpecFile(rspec_file)
  " go to implementation file
  let alternate_file = substitute(a:rspec_file, '_rake_spec\.rb$', '.rake', '')
  let alternate_file = substitute(alternate_file, '^spec/', '', '')
  if s:IsRailsControllerModelViewAssetFile(alternate_file)
    let alternate_file = 'app/' . alternate_file
  end
  return alternate_file
endfunction

function! s:AlternateFileForJavascriptSpecFile(javascript_spec_file)
  " go to implementation file
  let alternate_file = substitute(a:javascript_spec_file, '_spec\.js$', '.js', '')
  let alternate_file = substitute(alternate_file, '^spec/', '', '')
  if s:IsRailsControllerModelViewAssetFile(alternate_file)
    let alternate_file = 'app/' . alternate_file
  end
  return alternate_file
endfunction

function! s:AlternateFileForExUnitTestFile(exunit_test_file)
  " go to implementation file
  let alternate_file = substitute(a:exunit_test_file, '_test\.exs$', '.ex', '')
  let alternate_file = substitute(alternate_file, '^test/', '', '')
  return alternate_file
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions to generate alternate files paths for implementation files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:AlternateFileForCucumberStepDefinitionFile(cucumber_step_definition_file)
  " go to feature file
  " features/step_definitions/choose_plan_steps.rb
  let alternate_file = substitute(a:cucumber_step_definition_file, '_steps\.rb$', '.feature', '')
  " features/step_definitions/choose_plan.feature
  let alternate_file = substitute(alternate_file, 'step_definitions/', '', '')
  " features/choose_plan.feature
  return alternate_file
endfunction

function! s:AlternateFileForRubyImplementationFile(ruby_implementation_file)
  let alternate_file = a:ruby_implementation_file
  " go to spec file
  if s:IsHanamiAppImplementationFile(a:ruby_implementation_file)
    let alternate_file = substitute(alternate_file, '^app/', '', '')
  elseif s:IsRailsControllerModelViewAssetFile(a:ruby_implementation_file)
    let alternate_file = substitute(alternate_file, '^app/', '', '')
  elseif s:IsHanamiContainerArchitecture(a:ruby_implementation_file)
    let alternate_file = substitute(alternate_file, '^apps/', '', '')
  else
    let alternate_file = substitute(alternate_file, '^lib/', '', '')
  end
  let alternate_file = substitute(alternate_file, '\.rb$', '_spec.rb', '')
  let alternate_file = substitute(alternate_file, '\.erb$', '\.erb_spec.rb', '')
  let alternate_file = 'spec/' . alternate_file
  return alternate_file
endfunction

function! s:AlternateFileForRakeImplementationFile(rake_implementation_file)
  let alternate_file = a:rake_implementation_file
  " go to spec file
  if s:IsRailsControllerModelViewAssetFile(a:rake_implementation_file)
    let alternate_file = substitute(a:rake_implementation_file, '^app/', '', '')
  end
  let alternate_file = substitute(alternate_file, '\.rake$', '_rake_spec.rb', '')
  let alternate_file = 'spec/' . alternate_file
  return alternate_file
endfunction

function! s:AlternateFileForJavascriptImplementationFile(javascript_implementation_file)
  let alternate_file = a:javascript_implementation_file
  " go to spec file
  if s:IsRailsControllerModelViewAssetFile(a:javascript_implementation_file)
    let alternate_file = substitute(a:javascript_implementation_file, '^app/', '', '')
  end
  let alternate_file = substitute(alternate_file, '\.js$', '_spec.js', '')
  let alternate_file = 'spec/' . alternate_file
  return alternate_file
endfunction

function! s:AlternateFileForElixirImplementationFile(elixir_implementation_file)
  " go to implementation file
  let alternate_file = substitute(a:elixir_implementation_file, '\.ex$', '_test.exs', '')
  let alternate_file = 'test/' . alternate_file
  return alternate_file
endfunction

function! s:RemoveLeadingDotSlash(file)
  return substitute(a:file, '^\./', '', '')
endfunction

function! s:AlternateFileFor(file)
  let path = s:RemoveLeadingDotSlash(a:file)

  if s:IsCucumberFeatureFile(path)
    return s:AlternateFileForCucumberFeatureFile(path)
  elseif s:IsCucumberStepDefinitionFile(path)
    return s:AlternateFileForCucumberStepDefinitionFile(path)
  elseif s:IsRakeRSpecFile(path)
    return s:AlternateFileForRakeRSpecFile(path)
  elseif s:IsRakeFile(path)
    return s:AlternateFileForRakeImplementationFile(path)
  elseif s:IsJavascriptSpecFile(path)
    return s:AlternateFileForJavascriptSpecFile(path)
  elseif s:IsJavascriptImplementationFile(path)
    return s:AlternateFileForJavascriptImplementationFile(path)
  elseif s:IsExUnitTestFile(path)
    return s:AlternateFileForExUnitTestFile(path)
  elseif s:IsElixirImplementationFile(path)
    return s:AlternateFileForElixirImplementationFile(path)
  elseif s:IsRSpecFile(path)
    return s:AlternateFileForRSpecFile(path)
  else
    return s:AlternateFileForRubyImplementationFile(path)
  endif
endfunction

function! s:AlternateFileForCurrentFile()
  let current_file = expand("%")
  return s:AlternateFileFor(current_file)
endfunction

function! s:OpenAlternate()
  exec ':e ' . s:AlternateFileForCurrentFile()
endfunction

command! OpenAlternate :call s:OpenAlternate()

" Sadly these are here to enable testing script scoped methods in the test suite.
function! VimOpenAlternateScope()
  return s:
endfunction

function! VimOpenAlternateSid()
  return maparg('<SID>', 'n')
endfunction
nnoremap <SID>  <SID>
