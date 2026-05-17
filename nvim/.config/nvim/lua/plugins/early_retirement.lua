return {
  "chrisgrieser/nvim-early-retirement",
  config = true,
  event = "VeryLazy",
  opts = {
    retirementAgeMins = 20,
    ignoreUnsavedChangesBufs = true,
    ignoreVisibleBufs = true,
    ignoreSpecialBufTypes = true,
    deleteBufferWhenFileDeleted = false,
  },
}
