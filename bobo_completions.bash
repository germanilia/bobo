#!/bin/bash
_bobo_providers()
{
  case "${#COMP_WORDS[@]}" in
    "2" )
      providers=""
      while IFS='' read -r line || [[ -n "$line" ]]; do
        providers+="$line "
      done < "bobo_providers"  
      COMPREPLY=($(compgen -W "$providers" "${COMP_WORDS[1]}"))
      ;;
    "3" ) 
      actions=""
      while IFS='' read -r line || [[ -n "$line" ]]; do
        actions+="$line "
      done < "bobo_actions"  
      COMPREPLY=($(compgen -W "$actions" "${COMP_WORDS[2]}"))
      ;;
    "4" ) 
      if [[ ${COMP_WORDS[1]}  == "aws" ]]; then
         COMPREPLY=($(compgen -W "$(awk '$1~/profile/{split($2,nm,"]"); print nm[1]}' ~/.aws/config)" "${COMP_WORDS[3]}"))
      fi
      if [[ ${COMP_WORDS[1]}  == "gcp" ]]; then
         COMPREPLY=($(compgen -W "$(gcloud auth list --format=text | awk '$1~/account/{print $2}')" "${COMP_WORDS[3]}"))
      fi
      ;;
  esac
}
complete -F _bobo_providers bobo

