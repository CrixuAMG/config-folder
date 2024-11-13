function __fish_composer_no_subcommand
    for i in (commandline -opc)
        if contains -- $i _complete about archive audit browse bump check-platform-reqs clear-cache completion config create-project depends diagnose dump-autoload exec fund global help init install licenses list outdated prohibits reinstall remove require run-script search self-update show status suggests update validate
            return 1
        end
    end
    return 0
end

# global options
complete -c composer -n '__fish_composer_no_subcommand' -l help -d 'Display help for the given command. When no command is given display help for the [32mlist[39m command'
complete -c composer -n '__fish_composer_no_subcommand' -l quiet -d 'Do not output any message'
complete -c composer -n '__fish_composer_no_subcommand' -l verbose -d 'Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug'
complete -c composer -n '__fish_composer_no_subcommand' -l version -d 'Display this application version'
complete -c composer -n '__fish_composer_no_subcommand' -l ansi -d 'Force (or disable --no-ansi) ANSI output'
complete -c composer -n '__fish_composer_no_subcommand' -l no-ansi -d 'Negate the "--ansi" option'
complete -c composer -n '__fish_composer_no_subcommand' -l no-interaction -d 'Do not ask any interactive question'
complete -c composer -n '__fish_composer_no_subcommand' -l profile -d 'Display timing and memory usage information'
complete -c composer -n '__fish_composer_no_subcommand' -l no-plugins -d 'Whether to disable plugins.'
complete -c composer -n '__fish_composer_no_subcommand' -l no-scripts -d 'Skips the execution of all scripts defined in composer.json file.'
complete -c composer -n '__fish_composer_no_subcommand' -l working-dir -d 'If specified, use the given directory as working directory.'
complete -c composer -n '__fish_composer_no_subcommand' -l no-cache -d 'Prevent use of the cache'

# commands
complete -c composer -f -n '__fish_composer_no_subcommand' -a _complete -d 'Internal command to provide shell completion suggestions'
complete -c composer -f -n '__fish_composer_no_subcommand' -a about -d 'Shows a short information about Composer'
complete -c composer -f -n '__fish_composer_no_subcommand' -a archive -d 'Creates an archive of this composer package'
complete -c composer -f -n '__fish_composer_no_subcommand' -a audit -d 'Checks for security vulnerability advisories for installed packages'
complete -c composer -f -n '__fish_composer_no_subcommand' -a browse -d 'Opens the package\'s repository URL or homepage in your browser'
complete -c composer -f -n '__fish_composer_no_subcommand' -a bump -d 'Increases the lower limit of your composer.json requirements to the currently installed versions'
complete -c composer -f -n '__fish_composer_no_subcommand' -a check-platform-reqs -d 'Check that platform requirements are satisfied'
complete -c composer -f -n '__fish_composer_no_subcommand' -a clear-cache -d 'Clears composer\'s internal package cache'
complete -c composer -f -n '__fish_composer_no_subcommand' -a completion -d 'Dump the shell completion script'
complete -c composer -f -n '__fish_composer_no_subcommand' -a config -d 'Sets config options'
complete -c composer -f -n '__fish_composer_no_subcommand' -a create-project -d 'Creates new project from a package into given directory'
complete -c composer -f -n '__fish_composer_no_subcommand' -a depends -d 'Shows which packages cause the given package to be installed'
complete -c composer -f -n '__fish_composer_no_subcommand' -a diagnose -d 'Diagnoses the system to identify common errors'
complete -c composer -f -n '__fish_composer_no_subcommand' -a dump-autoload -d 'Dumps the autoloader'
complete -c composer -f -n '__fish_composer_no_subcommand' -a exec -d 'Executes a vendored binary/script'
complete -c composer -f -n '__fish_composer_no_subcommand' -a fund -d 'Discover how to help fund the maintenance of your dependencies'
complete -c composer -f -n '__fish_composer_no_subcommand' -a global -d 'Allows running commands in the global composer dir ($COMPOSER_HOME)'
complete -c composer -f -n '__fish_composer_no_subcommand' -a help -d 'Display help for a command'
complete -c composer -f -n '__fish_composer_no_subcommand' -a init -d 'Creates a basic composer.json file in current directory'
complete -c composer -f -n '__fish_composer_no_subcommand' -a install -d 'Installs the project dependencies from the composer.lock file if present, or falls back on the composer.json'
complete -c composer -f -n '__fish_composer_no_subcommand' -a licenses -d 'Shows information about licenses of dependencies'
complete -c composer -f -n '__fish_composer_no_subcommand' -a list -d 'List commands'
complete -c composer -f -n '__fish_composer_no_subcommand' -a outdated -d 'Shows a list of installed packages that have updates available, including their latest version'
complete -c composer -f -n '__fish_composer_no_subcommand' -a prohibits -d 'Shows which packages prevent the given package from being installed'
complete -c composer -f -n '__fish_composer_no_subcommand' -a reinstall -d 'Uninstalls and reinstalls the given package names'
complete -c composer -f -n '__fish_composer_no_subcommand' -a remove -d 'Removes a package from the require or require-dev'
complete -c composer -f -n '__fish_composer_no_subcommand' -a require -d 'Adds required packages to your composer.json and installs them'
complete -c composer -f -n '__fish_composer_no_subcommand' -a run-script -d 'Runs the scripts defined in composer.json'
complete -c composer -f -n '__fish_composer_no_subcommand' -a search -d 'Searches for packages'
complete -c composer -f -n '__fish_composer_no_subcommand' -a self-update -d 'Updates composer.phar to the latest version'
complete -c composer -f -n '__fish_composer_no_subcommand' -a show -d 'Shows information about packages'
complete -c composer -f -n '__fish_composer_no_subcommand' -a status -d 'Shows a list of locally modified packages'
complete -c composer -f -n '__fish_composer_no_subcommand' -a suggests -d 'Shows package suggestions'
complete -c composer -f -n '__fish_composer_no_subcommand' -a update -d 'Updates your dependencies to the latest version according to composer.json, and updates the composer.lock file'
complete -c composer -f -n '__fish_composer_no_subcommand' -a validate -d 'Validates a composer.json and composer.lock'

# command options

# _complete
complete -c composer -A -n '__fish_seen_subcommand_from _complete' -l shell -d 'The shell type ("bash")'
complete -c composer -A -n '__fish_seen_subcommand_from _complete' -l input -d 'An array of input tokens (e.g. COMP_WORDS or argv)'
complete -c composer -A -n '__fish_seen_subcommand_from _complete' -l current -d 'The index of the "input" array that the cursor is in (e.g. COMP_CWORD)'
complete -c composer -A -n '__fish_seen_subcommand_from _complete' -l symfony -d 'The version of the completion script'

# about

# archive
complete -c composer -A -n '__fish_seen_subcommand_from archive' -l format -d 'Format of the resulting archive: tar, tar.gz, tar.bz2 or zip (default tar)'
complete -c composer -A -n '__fish_seen_subcommand_from archive' -l dir -d 'Write the archive to this directory'
complete -c composer -A -n '__fish_seen_subcommand_from archive' -l file -d 'Write the archive with the given file name. Note that the format will be appended.'
complete -c composer -A -n '__fish_seen_subcommand_from archive' -l ignore-filters -d 'Ignore filters when saving package'

# audit
complete -c composer -A -n '__fish_seen_subcommand_from audit' -l no-dev -d 'Disables auditing of require-dev packages.'
complete -c composer -A -n '__fish_seen_subcommand_from audit' -l format -d 'Output format. Must be "table", "plain", "json", or "summary".'
complete -c composer -A -n '__fish_seen_subcommand_from audit' -l locked -d 'Audit based on the lock file instead of the installed packages.'

# browse
complete -c composer -A -n '__fish_seen_subcommand_from browse' -l homepage -d 'Open the homepage instead of the repository URL.'
complete -c composer -A -n '__fish_seen_subcommand_from browse' -l show -d 'Only show the homepage or repository URL.'

# bump
complete -c composer -A -n '__fish_seen_subcommand_from bump' -l dev-only -d 'Only bump requirements in "require-dev".'
complete -c composer -A -n '__fish_seen_subcommand_from bump' -l no-dev-only -d 'Only bump requirements in "require".'
complete -c composer -A -n '__fish_seen_subcommand_from bump' -l dry-run -d 'Outputs the packages to bump, but will not execute anything.'

# check-platform-reqs
complete -c composer -A -n '__fish_seen_subcommand_from check-platform-reqs' -l no-dev -d 'Disables checking of require-dev packages requirements.'
complete -c composer -A -n '__fish_seen_subcommand_from check-platform-reqs' -l lock -d 'Checks requirements only from the lock file, not from installed packages.'
complete -c composer -A -n '__fish_seen_subcommand_from check-platform-reqs' -l format -d 'Format of the output: text or json'

# clear-cache
complete -c composer -A -n '__fish_seen_subcommand_from clear-cache' -l gc -d 'Only run garbage collection, not a full cache clear'

# completion
complete -c composer -A -n '__fish_seen_subcommand_from completion' -l debug -d 'Tail the completion debug log'

# config
complete -c composer -A -n '__fish_seen_subcommand_from config' -l global -d 'Apply command to the global config file'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l editor -d 'Open editor'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l auth -d 'Affect auth config file (only used for --editor)'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l unset -d 'Unset the given setting-key'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l list -d 'List configuration settings'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l file -d 'If you want to choose a different composer.json or config.json'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l absolute -d 'Returns absolute paths when fetching *-dir config values instead of relative'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l json -d 'JSON decode the setting value, to be used with extra.* keys'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l merge -d 'Merge the setting value with the current value, to be used with extra.* keys in combination with --json'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l append -d 'When adding a repository, append it (lowest priority) to the existing ones instead of prepending it (highest priority)'
complete -c composer -A -n '__fish_seen_subcommand_from config' -l source -d 'Display where the config value is loaded from'

# create-project
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l stability -d 'Minimum-stability allowed (unless a version is specified).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l prefer-source -d 'Forces installation from package sources when possible, including VCS information.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l prefer-dist -d 'Forces installation from package dist (default behavior).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l prefer-install -d 'Forces installation from package dist|source|auto (auto chooses source for dev versions, dist for the rest).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l repository -d 'Add custom repositories to look the package up, either by URL or using JSON arrays'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l repository-url -d 'DEPRECATED: Use --repository instead.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l add-repository -d 'Add the custom repository in the composer.json. If a lock file is present it will be deleted and an update will be run instead of install.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l dev -d 'Enables installation of require-dev packages (enabled by default, only present for BC).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l no-dev -d 'Disables installation of require-dev packages.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l no-custom-installers -d 'DEPRECATED: Use no-plugins instead.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l no-secure-http -d 'Disable the secure-http config option temporarily while installing the root package. Use at your own risk. Using this flag is a bad idea.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l keep-vcs -d 'Whether to prevent deleting the vcs folder.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l remove-vcs -d 'Whether to force deletion of the vcs folder without prompting.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l no-install -d 'Whether to skip installation of the package dependencies.'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l no-audit -d 'Whether to skip auditing of the installed package dependencies (can also be set via the COMPOSER_NO_AUDIT=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l audit-format -d 'Audit output format. Must be "table", "plain", "json" or "summary".'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from create-project' -l ask -d 'Whether to ask for project directory.'

# depends
complete -c composer -A -n '__fish_seen_subcommand_from depends' -l recursive -d 'Recursively resolves up to the root package'
complete -c composer -A -n '__fish_seen_subcommand_from depends' -l tree -d 'Prints the results as a nested tree'
complete -c composer -A -n '__fish_seen_subcommand_from depends' -l locked -d 'Read dependency information from composer.lock'

# diagnose

# dump-autoload
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l optimize -d 'Optimizes PSR0 and PSR4 packages to be loaded with classmaps too, good for production.'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l classmap-authoritative -d 'Autoload classes from the classmap only. Implicitly enables `--optimize`.'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l apcu -d 'Use APCu to cache found/not-found classes.'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l apcu-prefix -d 'Use a custom prefix for the APCu autoloader cache. Implicitly enables --apcu'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l dev -d 'Enables autoload-dev rules. Composer will by default infer this automatically according to the last install or update --no-dev state.'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l no-dev -d 'Disables autoload-dev rules. Composer will by default infer this automatically according to the last install or update --no-dev state.'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from dump-autoload' -l strict-psr -d 'Return a failed status code (1) if PSR-4 or PSR-0 mapping errors are present. Requires --optimize to work.'

# exec
complete -c composer -A -n '__fish_seen_subcommand_from exec' -l list -d ''

# fund
complete -c composer -A -n '__fish_seen_subcommand_from fund' -l format -d 'Format of the output: text or json'

# global

# help
complete -c composer -A -n '__fish_seen_subcommand_from help' -l format -d 'The output format (txt, xml, json, or md)'
complete -c composer -A -n '__fish_seen_subcommand_from help' -l raw -d 'To output raw command help'

# init
complete -c composer -A -n '__fish_seen_subcommand_from init' -l name -d 'Name of the package'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l description -d 'Description of package'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l author -d 'Author name of package'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l type -d 'Type of package (e.g. library, project, metapackage, composer-plugin)'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l homepage -d 'Homepage of package'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l require -d 'Package to require with a version constraint, e.g. foo/bar:1.0.0 or foo/bar=1.0.0 or "foo/bar 1.0.0"'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l require-dev -d 'Package to require for development with a version constraint, e.g. foo/bar:1.0.0 or foo/bar=1.0.0 or "foo/bar 1.0.0"'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l stability -d 'Minimum stability (empty or one of: stable, RC, beta, alpha, dev)'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l license -d 'License of package'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l repository -d 'Add custom repositories, either by URL or using JSON arrays'
complete -c composer -A -n '__fish_seen_subcommand_from init' -l autoload -d 'Add PSR-4 autoload mapping. Maps your package\'s namespace to the provided directory. (Expects a relative path, e.g. src/)'

# install
complete -c composer -A -n '__fish_seen_subcommand_from install' -l prefer-source -d 'Forces installation from package sources when possible, including VCS information.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l prefer-dist -d 'Forces installation from package dist (default behavior).'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l prefer-install -d 'Forces installation from package dist|source|auto (auto chooses source for dev versions, dist for the rest).'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l dry-run -d 'Outputs the operations but will not execute anything (implicitly enables --verbose).'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l download-only -d 'Download only, do not install packages.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l dev -d 'DEPRECATED: Enables installation of require-dev packages (enabled by default, only present for BC).'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l no-suggest -d 'DEPRECATED: This flag does not exist anymore.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l no-dev -d 'Disables installation of require-dev packages.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l no-autoloader -d 'Skips autoloader generation'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l no-install -d 'Do not use, only defined here to catch misuse of the install command.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l audit -d 'Run an audit after installation is complete.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l audit-format -d 'Audit output format. Must be "table", "plain", "json", or "summary".'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l optimize-autoloader -d 'Optimize autoloader during autoloader dump'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l classmap-authoritative -d 'Autoload classes from the classmap only. Implicitly enables `--optimize-autoloader`.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l apcu-autoloader -d 'Use APCu to cache found/not-found classes.'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l apcu-autoloader-prefix -d 'Use a custom prefix for the APCu autoloader cache. Implicitly enables --apcu-autoloader'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from install' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'

# licenses
complete -c composer -A -n '__fish_seen_subcommand_from licenses' -l format -d 'Format of the output: text, json or summary'
complete -c composer -A -n '__fish_seen_subcommand_from licenses' -l no-dev -d 'Disables search in require-dev packages.'

# list
complete -c composer -A -n '__fish_seen_subcommand_from list' -l raw -d 'To output raw command list'
complete -c composer -A -n '__fish_seen_subcommand_from list' -l format -d 'The output format (txt, xml, json, or md)'
complete -c composer -A -n '__fish_seen_subcommand_from list' -l short -d 'To skip describing commands\' arguments'

# outdated
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l outdated -d 'Show only packages that are outdated (this is the default, but present here for compat with `show`'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l all -d 'Show all installed packages with their latest versions'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l locked -d 'Shows updates for packages from the lock file, regardless of what is currently in vendor dir'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l direct -d 'Shows only packages that are directly required by the root package'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l strict -d 'Return a non-zero exit code when there are outdated packages'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l major-only -d 'Show only packages that have major SemVer-compatible updates.'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l minor-only -d 'Show only packages that have minor SemVer-compatible updates.'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l patch-only -d 'Show only packages that have patch SemVer-compatible updates.'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l format -d 'Format of the output: text or json'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l ignore -d 'Ignore specified package(s). Use it if you don\'t want to be informed about new versions of some packages.'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l no-dev -d 'Disables search in require-dev packages.'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages). Use with the --outdated option'
complete -c composer -A -n '__fish_seen_subcommand_from outdated' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages). Use with the --outdated option'

# prohibits
complete -c composer -A -n '__fish_seen_subcommand_from prohibits' -l recursive -d 'Recursively resolves up to the root package'
complete -c composer -A -n '__fish_seen_subcommand_from prohibits' -l tree -d 'Prints the results as a nested tree'
complete -c composer -A -n '__fish_seen_subcommand_from prohibits' -l locked -d 'Read dependency information from composer.lock'

# reinstall
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l prefer-source -d 'Forces installation from package sources when possible, including VCS information.'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l prefer-dist -d 'Forces installation from package dist (default behavior).'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l prefer-install -d 'Forces installation from package dist|source|auto (auto chooses source for dev versions, dist for the rest).'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l no-autoloader -d 'Skips autoloader generation'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l optimize-autoloader -d 'Optimize autoloader during autoloader dump'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l classmap-authoritative -d 'Autoload classes from the classmap only. Implicitly enables `--optimize-autoloader`.'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l apcu-autoloader -d 'Use APCu to cache found/not-found classes.'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l apcu-autoloader-prefix -d 'Use a custom prefix for the APCu autoloader cache. Implicitly enables --apcu-autoloader'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from reinstall' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'

# remove
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l dev -d 'Removes a package from the require-dev section.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l dry-run -d 'Outputs the operations but will not execute anything (implicitly enables --verbose).'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l no-update -d 'Disables the automatic update of the dependencies (implies --no-install).'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l no-install -d 'Skip the install step after updating the composer.lock file.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l no-audit -d 'Skip the audit step after updating the composer.lock file (can also be set via the COMPOSER_NO_AUDIT=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l audit-format -d 'Audit output format. Must be "table", "plain", "json", or "summary".'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l update-no-dev -d 'Run the dependency update with the --no-dev option.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l update-with-dependencies -d 'Allows inherited dependencies to be updated with explicit dependencies. (Deprecated, is now default behavior)'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l update-with-all-dependencies -d 'Allows all inherited dependencies to be updated, including those that are root requirements.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l with-all-dependencies -d 'Alias for --update-with-all-dependencies'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l no-update-with-dependencies -d 'Does not allow inherited dependencies to be updated with explicit dependencies.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l unused -d 'Remove all packages which are locked but not required by any other package.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l optimize-autoloader -d 'Optimize autoloader during autoloader dump'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l classmap-authoritative -d 'Autoload classes from the classmap only. Implicitly enables `--optimize-autoloader`.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l apcu-autoloader -d 'Use APCu to cache found/not-found classes.'
complete -c composer -A -n '__fish_seen_subcommand_from remove' -l apcu-autoloader-prefix -d 'Use a custom prefix for the APCu autoloader cache. Implicitly enables --apcu-autoloader'

# require
complete -c composer -A -n '__fish_seen_subcommand_from require' -l dev -d 'Add requirement to require-dev.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l dry-run -d 'Outputs the operations but will not execute anything (implicitly enables --verbose).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l prefer-source -d 'Forces installation from package sources when possible, including VCS information.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l prefer-dist -d 'Forces installation from package dist (default behavior).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l prefer-install -d 'Forces installation from package dist|source|auto (auto chooses source for dev versions, dist for the rest).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l fixed -d 'Write fixed version to the composer.json.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l no-suggest -d 'DEPRECATED: This flag does not exist anymore.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l no-update -d 'Disables the automatic update of the dependencies (implies --no-install).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l no-install -d 'Skip the install step after updating the composer.lock file.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l no-audit -d 'Skip the audit step after updating the composer.lock file (can also be set via the COMPOSER_NO_AUDIT=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l audit-format -d 'Audit output format. Must be "table", "plain", "json", or "summary".'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l update-no-dev -d 'Run the dependency update with the --no-dev option.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l update-with-dependencies -d 'Allows inherited dependencies to be updated, except those that are root requirements.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l update-with-all-dependencies -d 'Allows all inherited dependencies to be updated, including those that are root requirements.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l with-dependencies -d 'Alias for --update-with-dependencies'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l with-all-dependencies -d 'Alias for --update-with-all-dependencies'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l prefer-stable -d 'Prefer stable versions of dependencies (can also be set via the COMPOSER_PREFER_STABLE=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l prefer-lowest -d 'Prefer lowest versions of dependencies (can also be set via the COMPOSER_PREFER_LOWEST=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l sort-packages -d 'Sorts packages when adding/updating a new dependency'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l optimize-autoloader -d 'Optimize autoloader during autoloader dump'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l classmap-authoritative -d 'Autoload classes from the classmap only. Implicitly enables `--optimize-autoloader`.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l apcu-autoloader -d 'Use APCu to cache found/not-found classes.'
complete -c composer -A -n '__fish_seen_subcommand_from require' -l apcu-autoloader-prefix -d 'Use a custom prefix for the APCu autoloader cache. Implicitly enables --apcu-autoloader'

# run-script
complete -c composer -A -n '__fish_seen_subcommand_from run-script' -l timeout -d 'Sets script timeout in seconds, or 0 for never.'
complete -c composer -A -n '__fish_seen_subcommand_from run-script' -l dev -d 'Sets the dev mode.'
complete -c composer -A -n '__fish_seen_subcommand_from run-script' -l no-dev -d 'Disables the dev mode.'
complete -c composer -A -n '__fish_seen_subcommand_from run-script' -l list -d 'List scripts.'

# search
complete -c composer -A -n '__fish_seen_subcommand_from search' -l only-name -d 'Search only in package names'
complete -c composer -A -n '__fish_seen_subcommand_from search' -l only-vendor -d 'Search only for vendor / organization names, returns only "vendor" as result'
complete -c composer -A -n '__fish_seen_subcommand_from search' -l type -d 'Search for a specific package type'
complete -c composer -A -n '__fish_seen_subcommand_from search' -l format -d 'Format of the output: text or json'

# self-update
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l rollback -d 'Revert to an older installation of composer'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l clean-backups -d 'Delete old backups during an update. This makes the current version of composer the only backup available after the update'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l update-keys -d 'Prompt user for a key update'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l stable -d 'Force an update to the stable channel'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l preview -d 'Force an update to the preview channel'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l snapshot -d 'Force an update to the snapshot channel'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l 1 -d 'Force an update to the stable channel, but only use 1.x versions'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l 2 -d 'Force an update to the stable channel, but only use 2.x versions'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l 2.2 -d 'Force an update to the stable channel, but only use 2.2.x LTS versions'
complete -c composer -A -n '__fish_seen_subcommand_from self-update' -l set-channel-only -d 'Only store the channel as the default one and then exit'

# show
complete -c composer -A -n '__fish_seen_subcommand_from show' -l all -d 'List all packages'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l locked -d 'List all locked packages'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l installed -d 'List installed packages only (enabled by default, only present for BC).'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l platform -d 'List platform packages only'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l available -d 'List available packages only'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l self -d 'Show the root package information'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l name-only -d 'List package names only'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l path -d 'Show package paths'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l tree -d 'List the dependencies as a tree'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l latest -d 'Show the latest version'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l outdated -d 'Show the latest version but only for packages that are outdated'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l ignore -d 'Ignore specified package(s). Use it with the --outdated option if you don\'t want to be informed about new versions of some packages.'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l major-only -d 'Show only packages that have major SemVer-compatible updates. Use with the --latest or --outdated option.'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l minor-only -d 'Show only packages that have minor SemVer-compatible updates. Use with the --latest or --outdated option.'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l patch-only -d 'Show only packages that have patch SemVer-compatible updates. Use with the --latest or --outdated option.'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l direct -d 'Shows only packages that are directly required by the root package'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l strict -d 'Return a non-zero exit code when there are outdated packages'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l format -d 'Format of the output: text or json'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l no-dev -d 'Disables search in require-dev packages.'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages). Use with the --outdated option'
complete -c composer -A -n '__fish_seen_subcommand_from show' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages). Use with the --outdated option'

# status

# suggests
complete -c composer -A -n '__fish_seen_subcommand_from suggests' -l by-package -d 'Groups output by suggesting package (default)'
complete -c composer -A -n '__fish_seen_subcommand_from suggests' -l by-suggestion -d 'Groups output by suggested package'
complete -c composer -A -n '__fish_seen_subcommand_from suggests' -l all -d 'Show suggestions from all dependencies, including transitive ones'
complete -c composer -A -n '__fish_seen_subcommand_from suggests' -l list -d 'Show only list of suggested package names'
complete -c composer -A -n '__fish_seen_subcommand_from suggests' -l no-dev -d 'Exclude suggestions from require-dev packages'

# update
complete -c composer -A -n '__fish_seen_subcommand_from update' -l with -d 'Temporary version constraint to add, e.g. foo/bar:1.0.0 or foo/bar=1.0.0'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l prefer-source -d 'Forces installation from package sources when possible, including VCS information.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l prefer-dist -d 'Forces installation from package dist (default behavior).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l prefer-install -d 'Forces installation from package dist|source|auto (auto chooses source for dev versions, dist for the rest).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l dry-run -d 'Outputs the operations but will not execute anything (implicitly enables --verbose).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l dev -d 'DEPRECATED: Enables installation of require-dev packages (enabled by default, only present for BC).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l no-dev -d 'Disables installation of require-dev packages.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l lock -d 'Overwrites the lock file hash to suppress warning about the lock file being out of date without updating package versions. Package metadata like mirrors and URLs are updated if they changed.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l no-install -d 'Skip the install step after updating the composer.lock file.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l no-audit -d 'Skip the audit step after updating the composer.lock file (can also be set via the COMPOSER_NO_AUDIT=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l audit-format -d 'Audit output format. Must be "table", "plain", "json", or "summary".'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l no-autoloader -d 'Skips autoloader generation'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l no-suggest -d 'DEPRECATED: This flag does not exist anymore.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l no-progress -d 'Do not output download progress.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l with-dependencies -d 'Update also dependencies of packages in the argument list, except those which are root requirements.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l with-all-dependencies -d 'Update also dependencies of packages in the argument list, including those which are root requirements.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l optimize-autoloader -d 'Optimize autoloader during autoloader dump.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l classmap-authoritative -d 'Autoload classes from the classmap only. Implicitly enables `--optimize-autoloader`.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l apcu-autoloader -d 'Use APCu to cache found/not-found classes.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l apcu-autoloader-prefix -d 'Use a custom prefix for the APCu autoloader cache. Implicitly enables --apcu-autoloader'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l ignore-platform-req -d 'Ignore a specific platform requirement (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l ignore-platform-reqs -d 'Ignore all platform requirements (php & ext- packages).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l prefer-stable -d 'Prefer stable versions of dependencies (can also be set via the COMPOSER_PREFER_STABLE=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l prefer-lowest -d 'Prefer lowest versions of dependencies (can also be set via the COMPOSER_PREFER_LOWEST=1 env var).'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l interactive -d 'Interactive interface with autocompletion to select the packages to update.'
complete -c composer -A -n '__fish_seen_subcommand_from update' -l root-reqs -d 'Restricts the update to your first degree dependencies.'

# validate
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l no-check-all -d 'Do not validate requires for overly strict/loose constraints'
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l check-lock -d 'Check if lock file is up to date (even when config.lock is false)'
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l no-check-lock -d 'Do not check if lock file is up to date'
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l no-check-publish -d 'Do not check for publish errors'
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l no-check-version -d 'Do not report a warning if the version field is present'
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l with-dependencies -d 'Also validate the composer.json of all installed dependencies'
complete -c composer -A -n '__fish_seen_subcommand_from validate' -l strict -d 'Return a non-zero exit code for warnings as well as errors'
