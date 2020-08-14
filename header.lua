return {
  id = "ProjectRevision",
  name = "ProjectRevision",
  load = function()
    return ({["Rengar"] = true})[player.charName]
  end,
}
    