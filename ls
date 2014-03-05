[1mHelp[0m
  help               Show a list of commands or information about a specific command

[1mContext[0m
  cd                 Move into a new context (object or scope).
  find-method        Recursively search for a method within a Class/Module or the current namespace.
  ls                 Show the list of vars and methods in the current scope.
  pry-backtrace      Show the backtrace for the Pry session.
  raise-up           Raise an exception out of the current pry instance.
  reset              Reset the REPL to a clean state.
  whereami           Show code surrounding the current context.
  wtf?               Show the backtrace of the most recent exception.

[1mEditing[0m
  !                  Clear the input buffer.
  amend-line         Amend a line of input in multi-line mode.
  edit               Invoke the default editor on a file.
  hist               Show and replay Readline history.
  play               Playback a string variable or a method or a file as input.
  show-input         Show the contents of the input buffer for the current multi-line expression.

[1mIntrospection[0m
  ri                 View ri documentation.
  show-doc           Show the documentation for a method or class.
  show-source        Show the source for a method or class.
  stat               View method information and set _file_ and _dir_ locals.

[1mGems[0m
  gem-cd             Change working directory to specified gem's directory.
  gem-install        Install a gem and refresh the gem cache.
  gem-list           List and search installed gems.
  gem-open           Opens the working directory of the gem in your editor

[1mCommands[0m
  import-set         Import a Pry command set.
  install-command    Install a disabled command.

[1mAliases[0m
  !!!                Alias for `exit-program`
  !!@                Alias for `exit-all`
  $                  Alias for `show-source`
  ?                  Alias for `show-doc`
  clipit             Alias for `gist --clip`
  file-mode          Alias for `shell-mode`
  history            Alias for `hist`
  jist               Alias for `gist`
  quit               Alias for `exit`
  quit-program       Alias for `exit-program`
  reload-method      Alias for `reload-code`
  show-method        Alias for `show-source`

[1mInput and Output[0m
  .<shell command>   All text following a '.' is forwarded to the shell.
  cat                Show code from a file, Pry's input buffer, or the last exception.
  fix-indent         Correct the indentation for contents of the input buffer
  save-file          Export to a file using content from the REPL.
  shell-mode         Toggle shell mode. Bring in pwd prompt and file completion.

[1mMisc[0m
  gist               Playback a string variable or a method or a file as input.
  pry-version        Show Pry version.
  reload-code        Reload the source file that contains the specified code object.
  simple-prompt      Toggle the simple prompt.
  toggle-color       Toggle syntax highlighting.

[1mNavigating Pry[0m
  !pry               Start a Pry session on current self.
  disable-pry        Stops all future calls to pry and exits the current session.
  exit               Pop the previous binding.
  exit-all           End the current Pry session.
  exit-program       End the current program.
  jump-to            Jump to a binding further up the stack.
  nesting            Show nesting information.
  switch-to          Start a new subsession on a binding in the current stack.