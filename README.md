# PeakFit

An app to track your strength training workouts.

## :hammer: Project Setup

### Prerequisites

- [Node.js](https://nodejs.org) is needed for git hooks
    - How to install node instructions can be found [here](https://nodejs.org/en/learn/getting-started/how-to-install-nodejs). @heyjaywilson suggests using the prebuilt installer for the current version
- Xcode 16.0 (@heyjaywilson suggests using the [Xcodes app](https://github.com/XcodesOrg/XcodesApp) to manage Xcode versions)
- [swift-format](https://github.com/apple/swift-format#getting-swift-format)
    - How to install instructions can be found [here](https://github.com/swiftlang/swift-format#installing-via-homebrew)
    - You need swift-format installed because the formatting hooks use the command `swift-format` and not `swift format` which is the command that comes with Xcode 16

### Steps

1. Clone the repo
2. Navigate into the repo via the command line
3. Run `npm prepare` to install git hooks

## Commands

These commands are available once you have installed the prerequisites and have run `npm prepare`.

| Command | Purpose |
| --- | --- |
| `npm prepare` | installs git hooks |
| `npm run emojify` | adds emoji to the last commit |
| `npm format` | runs swift format across all swift files |
| `npm format-changes` | runs a script to only format swift files that have been touched |

## Contributing TLDR

> [!NOTE]
> If you just want to request a feature or report a bug, do so in the [discussions](https://github.com/heyjaywilson/peakfit/discussions/new).

1. Ask for an [issue](https://github.com/heyjaywilson/peakfit/issues) to be assigned to you and wait for @heyjaywilson to assign the issue to you.
2. Fork the repo and make changes
3. Commit your changes. Your commit messages **must** follow [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/). There is a git hook that runs on commit that validates the commit message format.
4. Open a PR and make it pass

If there are any questions, please open a [discussion](https://github.com/heyjaywilson/peakfit/discussions/new).

For more details around contributing see [the contributing file](https://github.com/heyjaywilson/peakfit/blob/main/.github/CONTRIBUTING.MD)

## Resources for coding conventions

- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
