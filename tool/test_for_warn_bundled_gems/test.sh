#!/bin/bash

echo "* Show warning require and LoadError"
ruby test_warn_bundled_gems.rb
echo

echo "* Show warning when bundled gems called as dependency"
ruby test_warn_dependency.rb
echo

echo "* Show warning sub-feature like bigdecimal/util"
ruby test_warn_sub_feature.rb
echo

echo "* Show warning dash gem like net/smtp"
ruby test_warn_dash_gem.rb
echo

echo "* Show warning when bundle exec with ruby and script"
bundle exec ruby test_warn_bundle_exec.rb
echo

echo "* Show warning when bundle exec with shebang's script"
bundle exec ./test_warn_bundle_exec_shebang.rb
echo

echo "* Show warning when bundle exec with -r option"
bundle exec ruby -rostruct -e ''
echo

echo "* Show warning with bootsnap"
ruby test_warn_bootsnap.rb
echo

echo "* Show warning with bootsnap for gem with native extension"
ruby test_warn_bootsnap_rubyarchdir_gem.rb
echo

echo "* Show warning with zeitwerk"
ruby test_warn_zeitwerk.rb
echo

echo "* Don't show warning bundled gems on Gemfile"
ruby test_no_warn_dependency.rb
echo

echo "* Don't show warning with net/smtp when net-smtp on Gemfile"
ruby test_no_warn_dash_gem.rb
echo

echo "* Don't show warning bigdecimal/util when bigdecimal on Gemfile"
ruby test_no_warn_sub_feature.rb
echo

echo "* Show warning when warn is not the standard one in the current scope"
ruby test_warn_redefined.rb
echo

echo "* Show warning with bootsnap and some gem in Gemfile"
ruby test_warn_bootsnap_and_gem.rb
echo

echo "* Don't show warning for reline when using irb from standard library"
bundle exec ruby -rirb -e ''
echo
