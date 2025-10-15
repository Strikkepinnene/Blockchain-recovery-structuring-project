; Blockchain Recovery Analysis Workflow
; IDL Script for Social Node Blockchain Recovery
; Handles multi-chain asset discovery and recovery

pro blockchain_recovery_analysis, config_file, output_dir, VERBOSE=verbose
  compile_opt idl2
  
  if keyword_set(verbose) then print, 'Starting blockchain recovery analysis...'
  
  ; Read blockchain configuration
  config = json_parse(config_file, /TOSTRUCT)
  
  ; Initialize recovery arrays
  recovery_results = list()
  
  ; Primary chains analysis
  primary_chains = config.blockchain_recovery_targets.primary_chains
  chain_names = primary_chains.keys()
  
  foreach chain_name, chain_names do begin
    if keyword_set(verbose) then print, 'Analyzing chain: ', chain_name
    
    chain_config = primary_chains[chain_name]
    
    ; Create chain analysis structure
    chain_analysis = { $
      chain: chain_name, $
      symbol: chain_config.symbol, $
      genesis_date: chain_config.genesis_date, $
      has_mining_rewards: chain_config.mining_rewards, $
      contract_types: chain_config.contract_types, $
      recovery_methods: chain_config.recovery_methods, $
      priority_score: 0.0 $
    }
    
    ; Calculate priority score based on age and mining rewards
    if chain_config.mining_rewards then chain_analysis.priority_score += 10.0
    if chain_config.haskey('staking_rewards') && chain_config.staking_rewards then chain_analysis.priority_score += 5.0
    
    ; Add genesis date priority (older = higher priority)
    genesis_year = fix(strmid(chain_config.genesis_date, 0, 4))
    age_bonus = (2025 - genesis_year) * 2.0
    chain_analysis.priority_score += age_bonus
    
    recovery_results.add, chain_analysis
    
    if keyword_set(verbose) then begin
      print, '  Priority Score: ', chain_analysis.priority_score
      print, '  Recovery Methods: ', strjoin(chain_config.recovery_methods, ', ')
    endif
  endforeach
  
  ; Sort by priority score (highest first)
  priority_scores = fltarr(recovery_results.count())
  for i = 0, recovery_results.count()-1 do begin
    priority_scores[i] = recovery_results[i].priority_score
  endfor
  
  sort_indices = reverse(sort(priority_scores))
  sorted_results = list()
  foreach idx, sort_indices do sorted_results.add, recovery_results[idx]
  
  ; Generate recovery report
  report_file = filepath('blockchain_recovery_report.json', root_dir=output_dir)
  
  report = { $
    analysis_date: systime(/UTC), $
    total_chains_analyzed: recovery_results.count(), $
    recovery_priorities: sorted_results.toarray(), $
    high_priority_chains: [], $
    recommended_actions: [] $
  }
  
  ; Identify high priority chains (score > 15)
  high_priority = []
  recommended_actions = []
  
  foreach result, sorted_results do begin
    if result.priority_score gt 15.0 then begin
      high_priority = [high_priority, result.chain + ' (' + result.symbol + ')']
      recommended_actions = [recommended_actions, 'Prioritize ' + result.chain + ' wallet recovery using: ' + strjoin(result.recovery_methods, ', ')]
    endif
  endforeach
  
  report.high_priority_chains = high_priority
  report.recommended_actions = recommended_actions
  
  ; Save report
  json_serialize, report, report_file
  
  if keyword_set(verbose) then begin
    print, 'Recovery analysis complete!'
    print, 'High priority chains: ', strjoin(high_priority, ', ')
    print, 'Report saved to: ', report_file
  endif
  
  ; Store result in common block for retrieval
  common blockchain_analysis, analysis_result
  analysis_result = report
end

; Main execution block for team testing
compile_opt idl2

; Set up analysis parameters
config_file = 'config/blockchain-recovery-config.json'
output_dir = 'data/recovery_analysis'

; Ensure output directory exists
if ~file_test(output_dir, /directory) then file_mkdir, output_dir

; Run blockchain recovery analysis
print, 'Starting Social Node Blockchain Recovery Analysis...'
blockchain_recovery_analysis, config_file, output_dir, /VERBOSE

; Retrieve result from common block
common blockchain_analysis, analysis_result

print, 'Analysis completed successfully!'
print, 'Total chains analyzed: ', analysis_result.total_chains_analyzed
print, 'High priority recovery targets: ', n_elements(analysis_result.high_priority_chains)

end