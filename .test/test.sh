#!/bin/bash

TEST_HOME=test-home

run() {
  ../install.sh -t $(realpath $TEST_HOME)
}

setup_suite() {
  mkdir -p $TEST_HOME
  cp -r fixtures/test-* ..
  touch $TEST_HOME/.stow-skip
  run
}

teardown_suite() {
  rm -rf $TEST_HOME
  rm -rf ../test-*
}

test_skip() {
  assert_fail "test -f $TEST_HOME/test-skip-file"
}

test_installed() {
  rm -f ../test-disabled/.stow-disabled
  run
  assert "test -f $TEST_HOME/test-disabled-file"
}

test_disabled() {
  touch ../test-disabled/.stow-disabled
  run
  assert_fail "test -f $TEST_HOME/test-disabled-file"
}

test_disabled_none() {
  assert_fail "test -f $TEST_HOME/test-disabled-none-file"
}

if [[ "$(basename $0)" == "test.sh" ]]; then
  $(dirname $0)/bash_unit $0
fi
