function use-aws-profile() {
  local profile global sso_role_arn username credentials
  
  ### Check usage
  case $# in
    1)
      profile=$1
      global=no
      ;;
    2)
      profile=$1
      if [ $2 = '--global' ] || [ $2 = '-g' ]; then     
        global=yes
      else
        echo "Invalid argument value."
        echo "USAGE: $0 <profile> [--global/-g]"
        return 1
      fi
      ;;
    *)
      echo "Invalid number of arguments."
      echo "USAGE: $0 <profile> [--global/-g]"
      return 1
  esac
  
  aws sso login --profile $profile > /dev/null || {
    echo "SSO login failed for profile $profile."
    return 1
  }

  sso_role_name="$(aws configure get sso_role_name --profile $profile)"
  sso_account_id="$(aws configure get sso_account_id --profile $profile)"
  access_token="$(cd ~/.aws/sso/cache/ && cat $(ls -larth ~/.aws/sso/cache/ | tail -1 | awk '{print $9}') | jq '."accessToken"' | tr -d '"')"
  
  credentials="$(aws sso get-role-credentials --profile $profile --role-name $sso_role_name --account-id $sso_account_id --access-token $access_token)" || {
    echo "Unable to get sso role credentials using profile $profile."
    return 1
  }
  
  export AWS_TARGET_PROFILE=$profile
  export AWS_ACCESS_KEY_ID="$(echo "$credentials" | jq '.roleCredentials.accessKeyId' -r)"
  export AWS_SECRET_ACCESS_KEY="$(echo "$credentials" | jq '.roleCredentials.secretAccessKey' -r)"
  export AWS_SESSION_TOKEN="$(echo "$credentials" | jq '.roleCredentials.sessionToken' -r)"

  if [ $global = 'yes' ]; then
    aws configure set --profile default aws_access_key_id ${AWS_ACCESS_KEY_ID}
    aws configure set --profile default aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
    aws configure set --profile default aws_session_token ${AWS_SESSION_TOKEN}
  fi
}

function switch-env() {
  local environment global
  ### Check usage
  case $# in
    1)
      environment=$1
      ;;
    2)
      environment=$1
      if [ $2 = '--global' ] || [ $2 = '-g' ]; then     
        global=yes
      else
        echo "Invalid argument value."
        echo "USAGE: $0 <environment> [--global/-g]"
        return 1
      fi
      ;;
    *)
      echo "Invalid number of arguments."
      echo "USAGE: $0 <environment> [--global/-g]"
      return 1
  esac  

  use-aws-profile $@ > /dev/null
  kubectl config use-context $1 > /dev/null
}

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export GNUPGHOME=$HOME/private/.gnupg
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# Claude Code Agent aliases for easier terminal use
alias cca='claude-code'
alias ccf='claude-code "Fix any bugs or issues in this code"'
alias cce='claude-code "Explain this code step by step"'
alias cct='claude-code "Generate comprehensive unit tests"'
alias cco='claude-code "Optimize this code for performance and readability"'
alias ccr='claude-code "Refactor this code to improve structure"'

# Quick Claude functions
claude-file() {
    if [ -z "$1" ]; then
        echo "Usage: claude-file <task> [file]"
        return 1
    fi
    local file=${2:-$(find . -name "*.py" -o -name "*.js" -o -name "*.go" -o -name "*.lua" -o -name "*.vim" | head -1)}
    claude-code "$1" < "$file"
}

claude-project() {
    if [ -z "$1" ]; then
        echo "Usage: claude-project <task>"
        return 1
    fi
    find . -name "*.py" -o -name "*.js" -o -name "*.go" -o -name "*.lua" -o -name "*.vim" | head -10 | xargs -I {} claude-code "$1" < {}
}
export QLTY_COVERAGE_TOKEN="qltcw_uVbLRD541hbArUDl"
