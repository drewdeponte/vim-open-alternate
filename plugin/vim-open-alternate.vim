function! s:IsRSpecFile(file)
  return match(a:file, '^spec/') != -1
endfunction

function! s:IsCucumberFeatureFile(file)
  return match(a:file, '\.feature$') != -1
endfunction

function! s:IsCucumberStepDefinitionFile(file)
  return match(a:file, '^features/step_definitions/') != -1
endfunction

function! s:IsRailsControllerModelViewFile(file)
  return match(a:file, '\<controllers\>') != -1 || match(a:file, '\<models\>') != -1 || match(a:file, '\<views\>') != -1
endfunction

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
  if s:IsRailsControllerModelViewFile(alternate_file)
    let alternate_file = 'app/' . alternate_file
  end
  return alternate_file
endfunction

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
  if s:IsRailsControllerModelViewFile(a:ruby_implementation_file)
    let alternate_file = substitute(a:ruby_implementation_file, '^app/', '', '')
  end
  let alternate_file = substitute(alternate_file, '\.rb$', '_spec.rb', '')
  let alternate_file = substitute(alternate_file, '\.erb$', '\.erb_spec.rb', '')
  let alternate_file = 'spec/' . alternate_file
  return alternate_file
endfunction

function! s:AlternateFileForCurrentFile()
  let current_file = expand("%")

  if s:IsCucumberFeatureFile(current_file)
    return s:AlternateFileForCucumberFeatureFile(current_file)
  elseif s:IsRSpecFile(current_file)
    return s:AlternateFileForRSpecFile(current_file)
  elseif s:IsCucumberStepDefinitionFile(current_file)
    return s:AlternateFileForCucumberStepDefinitionFile(current_file)
  else
    return s:AlternateFileForRubyImplementationFile(current_file)
  endif
endfunction

function! s:OpenAlternate()
  exec ':e ' . s:AlternateFileForCurrentFile()
endfunction

command! OpenAlternate :call s:OpenAlternate()
