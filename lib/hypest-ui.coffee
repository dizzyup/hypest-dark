root = document.documentElement
themeName = 'hypest-dark'

module.exports =
  activate: (state) ->
    atom.config.observe "#{themeName}.vibrancy", (value) ->
      setVibrancy(value)

    atom.config.observe "#{themeName}.syntaxTheme", (value) ->
      setSyntaxTheme(value)

    atom.config.observe "#{themeName}.tabCloseButton", (value) ->
      setTabCloseButton(value)

    atom.config.observe "#{themeName}.hideDockButtons", (value) ->
      setHideDockButtons(value)

  deactivate: ->
    unsetVibrancy()
    unsetSyntaxTheme()
    unsetTabCloseButton()
    unsetHideDockButtons()

# Vibrancy -----------------------

setVibrancy = (vibrancy) ->
  if vibrancy
    require("electron").remote.getCurrentWindow().setVibrancy("dark");
    document.documentElement.classList.add("hypest-vibrancy");
  else
    unsetVibrancy()

unsetVibrancy = ->
  document.documentElement.classList.remove("hypest-vibrancy");

# Dark Syntax -----------------------

setSyntaxTheme = (syntaxTheme) ->
  if syntaxTheme
    document.documentElement.classList.add("hypest-light-syntax");
  else
    unsetSyntaxTheme()

unsetSyntaxTheme = ->
  document.documentElement.classList.remove("hypest-light-syntax");

# Tab Close Button -----------------------

setTabCloseButton = (tabCloseButton) ->
  if tabCloseButton is 'Right'
    document.documentElement.classList.add("hypest-close-right");
  else
    unsetTabCloseButton()

unsetTabCloseButton = ->
  document.documentElement.classList.remove("hypest-close-right");

# Dock Buttons -----------------------

setHideDockButtons = (hideDockButtons) ->
  if hideDockButtons
    document.documentElement.classList.add("hypest-hide-dock-buttons");
  else
    unsetHideDockButtons()

unsetHideDockButtons = ->
  document.documentElement.classList.remove("hypest-hide-dock-buttons");
