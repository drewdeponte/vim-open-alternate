function! s:OpenAlternate()
  let new_file = s:AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! s:AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let in_feature = match(current_file, '\.feature$') != -1
  let in_step_def = match(current_file, '^features/step_definitions/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1

  if in_feature
    " go to step defs file
    " features/choose_plan.feature
    let new_file = substitute(new_file, '\.feature$', '_steps.rb', '')
    " features/choose_plan_steps.rb
    let new_file = substitute(new_file, 'features/', 'features/step_definitions/', '')
    " features/step_definitions/choose_plan_steps.rb
  elseif in_spec
    " go to implementation file
    let new_file = substitute(new_file, 'erb_spec\.rb$', 'erb', '')
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  elseif in_step_def
    " go to feature file
    " features/step_definitions/choose_plan_steps.rb
    let new_file = substitute(new_file, '_steps\.rb$', '.feature', '')
    " features/step_definitions/choose_plan.feature
    let new_file = substitute(new_file, 'step_definitions/', '', '')
    " features/choose_plan.feature
  else
    " go to spec file
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = substitute(new_file, '\.erb$', '\.erb_spec.rb', '')
    let new_file = 'spec/' . new_file
  endif

  return new_file
endfunction

command! OpenAlternate :call s:OpenAlternate()
