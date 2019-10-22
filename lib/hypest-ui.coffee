root = document.documentElement
container = document.querySelector('atom-workspace')

themeName = 'hypest-dark'

module.exports =
  activate: (state) ->
    dummyEditor = document.createElement('atom-text-editor')
    dummyEditor.classList.add("hypest-dummy-editor")
    container.appendChild(dummyEditor)

    atom.workspace.getCenter().paneContainer.element.classList.add("hypest-workspace")

    atom.config.observe "#{themeName}.vibrancy", (value) ->
      setVibrancy(value)

    atom.config.observe "#{themeName}.syntaxTheme", (value) ->
      setSyntaxTheme(value)

    atom.config.observe "#{themeName}.tabCloseButton", (value) ->
      setTabCloseButton(value)

    atom.config.observe "#{themeName}.hideDockButtons", (value) ->
      setHideDockButtons(value)

  deactivate: ->
    dummyEditor = document.querySelector('atom-text-editor.hypest-dummy-editor')
    dummyEditor.parentNode.removeChild(dummyEditor)

    atom.workspace.getCenter().paneContainer.element.classList.remove("hypest-workspace")

    unsetVibrancy()
    unsetSyntaxTheme()
    unsetTabCloseButton()
    unsetHideDockButtons()

# Syntax theme -----------------------

setSyntaxTheme = (syntaxTheme) ->
  editor = document.querySelector('atom-text-editor.hypest-dummy-editor')
  editorColor = getComputedStyle(editor).backgroundColor

  rgb = editorColor.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
  contrast = if (rgb != null) then Math.round((rgb[1] * 299 + rgb[2] * 587 + rgb[3] * 114) / 1000) else 0

  if syntaxTheme is 'Always match light theme'
    setLightTheme()
  else if syntaxTheme is 'Always match dark theme'
    setDarkTheme()
  else if syntaxTheme is 'Detect automatically'
    if (contrast >= 200)
      setLightTheme()
    else if (contrast < 200)
      setDarkTheme()
    else
      setDarkTheme()

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
