# Change Log

All notable changes to *omni-kill.el* will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]
- *Nothing so far*
### [0.6.0] - 2017-16-05
### Changed
- Reimplement the macros with function and closure
- Restore byte compilation + lexical binding
### [0.5.1] - 2017-10-05
### Changed
- dispatcher such as `omni-kill` now accept symbol as arg for non interactive use
## [0.5.0] - 2017-10-01
### Added
- 4 new actions:
  - narrow
  - save to register
  - go to start/beginning
  - go to end
## [0.4.0] - 2017-10-01
### Added
- function to destroy the commands
- dynamically rename the commands by changing the custom naming scheme
## [0.3.0] - 2017-10-01
### Fixed
- disabled byte-compilation that was broking the macros because of the defconst
### Changed
- Huge refactor of inner working for better extensibility
### Dropped
- support of broken `number` thing

<!-- history digging to be made -->
[unreleased]: https://github.com/AdrieanKhisbe/omni-kill.el/compare/v0.6.0...HEAD
[0.5.1]: https://github.com/AdrieanKhisbe/omni-kill.el/compare/v0.5.1...v0.6.0
[0.6.0]: https://github.com/AdrieanKhisbe/omni-kill.el/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/AdrieanKhisbe/omni-kill.el/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/AdrieanKhisbe/omni-kill.el/compare/v0.3.0....v0.4.0
[0.3.0]: https://github.com/AdrieanKhisbe/omni-kill.el/compare/547b0a1....v0.3.0
