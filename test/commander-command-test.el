(ert-deftest test-commander-command-simple ()
  (with-mock
   (mock (help) :times 1)
   (commander
    (command "help" "HELP" 'help)
    (parse '("help")))))

(ert-deftest test-commander-command-required-argument-present ()
  (with-mock
   (mock (help "show") :times 1)
   (commander
    (command "help <command>" "HELP" 'help)
    (parse '("help" "show")))))

(ert-deftest test-commander-command-required-argument-not-present ()
  (with-mock
   (mock (error "Command `%s` requires argument" "help") :times 1)
   (commander
    (command "help <command>" "HELP" 'help)
    (parse '("help")))))

(ert-deftest test-commander-command-one-or-more-no-arguments ()
  (with-mock
   (mock (error "Command `%s` requires at least one argument" "help") :times 1)
   (commander
    (command "help <*>" "HELP" 'help)
    (parse '("help")))))

(ert-deftest test-commander-command-one-or-more-with-arguments ()
  (with-mock
   (mock (help "foo" "bar" "baz") :times 1)
   (commander
    (command "help <*>" "HELP" 'help)
    (parse '("help" "foo" "bar" "baz")))))

(ert-deftest test-commander-command-optional-argument-present ()
  (with-mock
   (mock (help "show") :times 1)
   (commander
    (command "help [command]" "HELP" 'help)
    (parse '("help" "show")))))

(ert-deftest test-commander-command-optional-argument-not-present ()
  (with-mock
   (mock (help) :times 1)
   (commander
    (command "help [command]" "HELP" 'help)
    (parse '("help")))))

(ert-deftest test-commander-command-optional-argument-not-present-with-default-value ()
  (with-mock
   (mock (help "show") :times 1)
   (commander
    (command "help [command]" "HELP" 'help "show")
    (parse '("help")))))

(ert-deftest test-commander-command-zero-or-more-no-arguments ()
  (with-mock
   (mock (help) :times 1)
   (commander
    (command "help [*]" "HELP" 'help)
    (parse '("help")))))

(ert-deftest test-commander-command-zero-or-more-with-arguments ()
  (with-mock
   (mock (help "foo" "bar" "baz") :times 1)
   (commander
    (command "help [*]" "HELP" 'help)
    (parse '("help" "foo" "bar" "baz")))))

(ert-deftest test-commander-command-with-options ()
  (with-mock
   (mock (help "foo") :times 1)
   (mock (foo "bar") :times 1)
   (mock (qux) :times 1)
   (commander
    (option "--foo <arg>" "FOO" 'foo)
    (option "--qux" "QUX" 'qux)
    (command "help [*]" "HELP" 'help)
    (parse '("--foo" "bar" "help" "foo" "--qux")))))

(ert-deftest test-commander-command-not-registered ()
  (with-mock
   (mock (error "Command `%s` not available" "foo"))
   (commander
    (parse '("foo")))))

(ert-deftest test-commander-command-required-options-then-option-after ()
  (with-mock
   (mock (say "One" "Two" "Three") :times 1)
   (mock (four) :times 1)
   (commander
    (option "--say <*>" "..." 'say)
    (option "--four" "..." 'four)
    (parse '("--say" "One" "Two" "Three" "--four")))))

(ert-deftest test-commander-command-optional-options-then-option-after ()
  (with-mock
   (mock (say "One" "Two" "Three") :times 1)
   (mock (four) :times 1)
   (commander
    (option "--say [*]" "..." 'say)
    (option "--four" "..." 'four)
    (parse '("--say" "One" "Two" "Three" "--four")))))

(ert-deftest test-commander-command-with-single-lower-capital-letter ()
  (with-mock
   (mock (command/f) :times 1)
   (commander
    (command "f" "..." 'command/f)
    (parse '("f")))))

(ert-deftest test-commander-command-with-single-upper-capital-letter ()
  (with-mock
   (mock (command/F) :times 1)
   (commander
    (command "F" "..." 'command/F)
    (parse '("F")))))

(ert-deftest test-commander-command-with-single-digit-number ()
  (with-mock
   (mock (command/0) :times 1)
   (commander
    (command "0" "..." 'command/0)
    (parse '("0")))))

(ert-deftest test-commander-command-with-multiple-digit-number ()
  (with-mock
   (mock (command/42) :times 1)
   (commander
    (command "42" "..." 'command/42)
    (parse '("42")))))

(ert-deftest test-commander-command-with-upper-case-letters ()
  (with-mock
   (mock (command/FOURTY-TWO) :times 1)
   (commander
    (command "FOURTY-TWO" "..." 'command/FOURTY-TWO)
    (parse '("FOURTY-TWO")))))

(ert-deftest test-commander-command-with-dash ()
  (with-mock
   (mock (command/fourty-two) :times 1)
   (commander
    (command "fourty-two" "..." 'command/fourty-two)
    (parse '("fourty-two")))))
