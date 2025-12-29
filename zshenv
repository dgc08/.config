# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
  
fi

# Make system functions available to zsh
() {
  setopt LOCAL_OPTIONS CASE_GLOB EXTENDED_GLOB

  local system_fpaths=(
      # Package default
      /usr/share/zsh/site-functions(/-N)

      # Debian
      /usr/share/zsh/functions/**/*(/-N)
      /usr/share/zsh/vendor-completions/(/-N)
      /usr/share/zsh/vendor-functions/(/-N)
  )
  fpath=(${fpath} ${system_fpaths})
}
