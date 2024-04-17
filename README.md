## Required tools
- ripgrep
- (fd)[https://github.com/sharkdp/fd?tab=readme-ov-file#installation]

## Usefull tools
- tmux
- fzf

### Use .vimrc configuration for Vim

`ln .vimrc ~/.vimrc`

### Use .ideavimrc


`ln .ideavimrc ~/.ideavimrc`

TODO: There is a better approach. Please look https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

### Troubleshooting

#### JDTLS Lombok issues

If a project is configured with Lombok, LSP could display errors not detencting that a class has methods generated by lombok. For exmaple:

```
example.builder().build; #The method builder() is undefined
```

One problem could be that the lombok jar is not configured in the classpath. Add the dependency, for example (gradle):
`implementation group: 'org.projectlombok:', name: 'lombok', version: '1.18.32'`

Note: It seems that nvim-jdtls does not detect 

```
dependencies {
    classpath "io.freefair.gradle:lombok-plugin:6.6.3"
}
```
It is still necessary to add the dependecy.

TODO: You may not want to add the dependecy. I have to try the following: add the jar in the `lib/` directory and configure the jdtls.settings:

```json
config.settings = {
    java = {
        configuration = {
            project = {
                referencedLibraries = {
                    "**/lib/*.jar",
                },
            }
        }
    }
}
```


### To improve

- [ ] Java LSP Integration
- [ ] Open '{', '(', etc. should close as well
- [ ] (Not in this project) Start terminal with tmux session `default`
- [ ] Telescope git status should display in a different way


