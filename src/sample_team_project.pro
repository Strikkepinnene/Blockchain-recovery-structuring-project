; IDL Team Project Template
; Created: 10/15/2025 10:01:30
; 
; This is a template for collaborative IDL development
; Use this as a starting point for team projects

pro sample_team_project, input_data, VERBOSE=verbose
  compile_opt idl2
  ; Team collaboration example procedure
  
  if keyword_set(verbose) then print, 'Processing team data...'
  
  ; Your team processing logic here
  result = input_data * 2.0 + 1.0
  
  ; Display results for team review
  print, 'Team processing complete. Sample result:', result[0:4]
end

; Main level program for testing
compile_opt idl2

; Example usage for team testing
test_data = findgen(100)
result = sample_team_project(test_data, /VERBOSE)

print, 'Team project template executed successfully'
print, 'Total elements processed:', n_elements(result)

end
