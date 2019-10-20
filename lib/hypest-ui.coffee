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

    atom.themes.onDidChangeActiveThemes ->
      setSyntaxTheme()

  deactivate: ->
    unsetVibrancy()
    unsetSyntaxTheme()
    unsetTabCloseButton()
    unsetHideDockButtons()

# Syntax theme -----------------------

setSyntaxTheme = (syntaxTheme) ->
  editor = document.querySelector('atom-pane-container.panes atom-text-editor.editor')
  editorColor = getComputedStyle(editor).backgroundColor

  rgb = editorColor.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
  r = rgb[1]
  g = rgb[2]
  b = rgb[3]
  contrast = Math.round((r * 299 + g * 587 + b * 114) / 1000)

  console.log(contrast)
  console.log(syntaxTheme)

  if syntaxTheme is 'Always match light theme'
    setLightTheme()
    console.log('is always light')
  else if syntaxTheme is 'Always match dark theme'
    setDarkTheme()
    console.log('is always dark')
  else if syntaxTheme is 'Detect automatically'
    console.log('detected successfully')
    if (contrast >= 200)
      setLightTheme()
      console.log('light detected')
    else if (contrast < 200)
      setDarkTheme()
      console.log('dark detected')
    else
      setLightTheme()
      console.log('fallback to light')

setLightTheme = ->
  document.documentElement.classList.remove("hypest-dark-syntax")
  document.documentElement.classList.add("hypest-light-syntax")

setDarkTheme = ->
  document.documentElement.classList.remove("hypest-light-syntax")
  document.documentElement.classList.add("hypest-dark-syntax")

unsetSyntaxTheme = ->
  document.documentElement.classList.remove("hypest-light-syntax", "hypest-dark-syntax")

# Vibrancy -----------------------

setVibrancy = (vibrancy) ->
  if vibrancy
    require("electron").remote.getCurrentWindow().setVibrancy("dark")
    document.documentElement.classList.add("hypest-vibrancy")
  else
    unsetVibrancy()

unsetVibrancy = ->
  document.documentElement.classList.remove("hypest-vibrancy")

# Dark Syntax -----------------------

setSyntaxTheme = (syntaxTheme) ->
  if syntaxTheme
    document.documentElement.classList.add("hypest-light-syntax")
  else
    unsetSyntaxTheme()

unsetSyntaxTheme = ->
  document.documentElement.classList.remove("hypest-light-syntax")

# Tab Close Button -----------------------

setTabCloseButton = (tabCloseButton) ->
  if tabCloseButton is 'Right'
    document.documentElement.classList.add("hypest-close-right")
  else
    unsetTabCloseButton()

unsetTabCloseButton = ->
  document.documentElement.classList.remove("hypest-close-right")

# Dock Buttons -----------------------

setHideDockButtons = (hideDockButtons) ->
  if hideDockButtons
    document.documentElement.classList.add("hypest-hide-dock-buttons")
  else
    unsetHideDockButtons()

unsetHideDockButtons = ->
  document.documentElement.classList.remove("hypest-hide-dock-buttons")
